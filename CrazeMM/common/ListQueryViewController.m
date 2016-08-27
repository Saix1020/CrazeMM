//
//  ListQueryViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ListQueryViewController.h"
#import "HttpRechargeLog.h"
#import "MJRefresh.h"
#import "RechargeLogCell.h"

@interface ListQueryViewController ()


@end

@implementation ListQueryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationItem.title = @"我的充值";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"RechargeLogCell" bundle:nil]  forCellReuseIdentifier:@"RechargeLogCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshListQuery]
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
    [self refreshListQuery];
}


-(AnyPromise*)refreshListQuery
{
    @synchronized (self) {
        if (self.requesting) {
            return nil;
        }
        self.requesting = YES;
    }
    
    return [self query];
}

-(AnyPromise*)query
{
    return nil;
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
    
    return [self cellHeight];
}

-(CGFloat)cellHeight
{
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
        cell = [self listCellWithTabelview:tableView andIndexPath:indexPath];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell*)listCellWithTabelview:(UITableView*)tableView andIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
