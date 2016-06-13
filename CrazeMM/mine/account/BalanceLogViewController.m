//
//  BalanceLogViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BalanceLogViewController.h"
#import "TimeLineViewControl.h"
#import "HttpBalance.h"
#import "MJRefresh.h"

@interface BalanceLogViewController ()

@property (nonatomic, strong) TimeLineViewControl* timeline;
@property (nonatomic, strong) UITableViewCell* timeLineCell;
@property (nonatomic, strong) NSMutableArray* balanceLogDtos;


@property (nonatomic) NSInteger totalRow;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger pageSize;


@end

@implementation BalanceLogViewController

-(UITableViewCell*)timeLineCell
{
    if (!_timeLineCell) {
        _timeLineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_timeLineCell"];
        _timeLineCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _timeLineCell.backgroundColor = [UIColor UIColorFromRGB:0xF0F0F0];
    }
    
    return _timeLineCell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户充值";
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    self.balanceLogDtos = [[NSMutableArray alloc] init];
    
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self refreshBlanceLog]
        .then(^(id x){
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        })
        .catch(^(NSError* error){
            [self.tableView.mj_header endRefreshing];
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshBlanceLog]
        .then(^(id x){
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
        })
        .catch(^(NSError* error){
            [self.tableView.mj_footer endRefreshing];
            [self showAlertViewWithMessage:error.localizedDescription];
        });;
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshBlanceLog];
}

-(AnyPromise*)refreshBlanceLog
{
//    if (self.pageNumber+1>self.totalPage) {
//        return nil;
//    }
    HttpBalanceLogRequest* request = [[HttpBalanceLogRequest alloc] initWithPageNum:self.pageNumber+1];
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            HttpBalanceLogResponse* response = (HttpBalanceLogResponse*)request.response;
            self.pageNumber = response.pageNumber>=response.totalPage?response.totalPage:response.pageNumber;
            self.totalPage = response.totalPage;
            if (response.balanceLogDtos.count>0) {
                [self.balanceLogDtos addObjectsFromArray:response.balanceLogDtos];
                [self rebuildTimeLineControl];
                [self.tableView reloadData];

            }
        }
    });
}

-(void)rebuildTimeLineControl
{
    [self.timeline removeFromSuperview];
    NSMutableArray* emptyArray = [[NSMutableArray alloc] initWithCapacity:self.balanceLogDtos.count];
    NSMutableArray* commentsArray = [[NSMutableArray alloc] initWithCapacity:self.balanceLogDtos.count];
    for (NSInteger i=0;i<self.balanceLogDtos.count; ++i) {
        BalanceLogDTO* dto = self.balanceLogDtos[i];
        emptyArray[i] = @"";
        commentsArray[i] = [NSString stringWithFormat:@"%@", dto.description];
    }
    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:emptyArray
                                           andTimeDescriptionArray:commentsArray
                                                  andCurrentStatus:1
                                                          andFrame:CGRectMake(-40, 16+20.f, 320 , self.view.bounds.size.height+40.f)];
    [self.timeline sizeToFit];
    [self.timeLineCell.contentView addSubview:self.timeline];
    self.tableView.rowHeight = MAX(self.timeline.timeLabelsHeight, self.timeline.descLabelsHeight) + 40.f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.timeLineCell;
}




@end
