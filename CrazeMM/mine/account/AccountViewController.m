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
#import "HttpBalance.h"
#import "RechargeViewController.h"
#import "WithDrawViewController.h"
#import "BalanceLogViewController.h"

@interface AccountViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) AccountSummaryCell* summaryCell;
@property (nonatomic, strong) AccountDetailCell* detailCell;

@property (nonatomic, strong) UIActionSheet* moreActionSheet;
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

-(UIActionSheet*)moreActionSheet
{
    if (!_moreActionSheet) {
        _moreActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"交易记录", @"充值记录", @"提现记录", @"支付管理", nil];
        _moreActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;

    }
    
    return _moreActionSheet;
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreServices:)];
    
    
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
    
    HttpBalanceRequest* balanceRequest = [[HttpBalanceRequest alloc] init];
    [balanceRequest request]
    .then(^(id responseObj){
        HttpBalanceResponse* response = (HttpBalanceResponse*)balanceRequest.response;
        self.summaryCell.money = response.balanceDto.money;
        self.summaryCell.frozenMoney = response.balanceDto.freezeMoney;
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

-(void)moreServices:(id)sender
{
    [self.moreActionSheet showInView:self.view];
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
    if (type == 0) { //recharge
        RechargeViewController* rechargeVC = [[RechargeViewController alloc] init];
        [self.navigationController pushViewController:rechargeVC animated:YES];

    }
    else if (type == 3) {
        WithDrawViewController* withDrawVC = [[WithDrawViewController alloc] init];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }

    else if (type == 2) {
        BankCardListViewController* bankCardListVC = [[BankCardListViewController alloc] init];
        [self.navigationController pushViewController:bankCardListVC animated:YES];
    }
}


#pragma mark -- action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            BalanceLogViewController* balanceLogView = [[BalanceLogViewController alloc] init];
            [self.navigationController pushViewController:balanceLogView animated:YES];
        }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
  
        default:
            break;
    }
    
}


@end
