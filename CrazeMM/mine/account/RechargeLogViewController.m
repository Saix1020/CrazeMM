//
//  RechargeLogViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RechargeLogViewController.h"
#import "HttpRechargeLog.h"
#import "MJRefresh.h"
#import "RechargeLogCell.h"

@interface RechargeLogViewController ()

@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic) NSInteger totalRow;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger pageSize;

@property (nonatomic) BOOL requesting;


@end

@implementation RechargeLogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的充值";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RechargeLogCell" bundle:nil]  forCellReuseIdentifier:@"RechargeLogCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataSource = [[NSMutableArray alloc] init];

    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshRechargeLog]
        .then(^(id x){
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
        })
        .catch(^(NSError* error){
            [self.tableView.mj_footer endRefreshing];
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshRechargeLog];
}


-(AnyPromise*)refreshRechargeLog
{
    @synchronized (self) {
        if (self.requesting) {
            return nil;
        }
        self.requesting = YES;
    }
    HttpRechargeLogRequest* request = [[HttpRechargeLogRequest alloc] initWithPageNum:self.pageNumber+1];
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            HttpRechargeLogResponse* response = (HttpRechargeLogResponse*)request.response;
            self.pageNumber = response.pageNumber>=response.totalPage?response.totalPage:response.pageNumber;
            self.totalPage = response.totalPage;
            if (response.dtos.count>0) {
                [self.dataSource addObjectsFromArray:response.dtos];
                [self.tableView reloadData];
            }
        }
    })
    .finally(^(){
        self.requesting = NO;
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        return 14.f;
    }
    
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.row%2 == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UselessCell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    else {
        RechargeLogCell* rechargeLogCell = [tableView dequeueReusableCellWithIdentifier:@"RechargeLogCell"];
        rechargeLogCell.rechargeLogDto = self.dataSource[indexPath.row/2];
        cell = rechargeLogCell;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



@end
