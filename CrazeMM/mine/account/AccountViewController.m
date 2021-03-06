//
//  AccountViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountSummaryCell.h"
#import "AccountDetailCell.h"
#import "BankCardListViewController.h"

@interface AccountViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) AccountSummaryCell* summaryCell;
@property (nonatomic, strong) AccountDetailCell* detailCell;
@end

@implementation AccountViewController

-(AccountSummaryCell*)summaryCell
{
    if (!_summaryCell) {
        _summaryCell = [[[NSBundle mainBundle]loadNibNamed:@"AccountSummaryCell" owner:nil options:nil] firstObject];
    }
    
    return _summaryCell;
}

-(AccountDetailCell*)detailCell
{
    if (!_detailCell) {
        _detailCell = [[[NSBundle mainBundle]loadNibNamed:@"AccountDetailCell" owner:nil options:nil] firstObject];
        _detailCell.delegate = self;
    }
    
    return _detailCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的账户";
    self.view.backgroundColor = [UIColor light_Gray_Color];
    
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"SupplyListCell" bundle:nil] forCellReuseIdentifier:@"SupplyListCell"];
    
    
//    self.tableView.tableHeaderView = self.segmentCell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.row==0) {
        cell = self.summaryCell;
    }
    else if(indexPath.row==2){
        cell = self.detailCell;
    }
    else {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row  == 0) {
        return [AccountSummaryCell cellHeight];
    }
    
    else if(indexPath.row==2){
        return [AccountDetailCell cellHeight];
        
    }
    
    return 12.f;
}

#pragma  -- mark AccountDetailCellDelegate
-(void)itemClicked:(NSInteger)type
{
    if (type == 2) {
        BankCardListViewController* bankCardListVC = [[BankCardListViewController alloc] init];
        [self.navigationController pushViewController:bankCardListVC animated:YES];
    }
}

@end
