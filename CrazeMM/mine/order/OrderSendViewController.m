//
//  SendViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderSendViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SelectionViewController.h"
#import "HttpMineAccount.h"
#import "HttpLogis.h"
#import "OrderDetailDTO.h"
#import "HttpOrderOperation.h"


@interface OrderSendViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, copy) NSArray* logisArray;
@property (nonatomic, copy) NSArray* bankAccounts;

@property (nonatomic, readonly) NSArray* receiveWay;
@property (nonatomic, strong) NSIndexPath* editingIndexPath;
@property (nonatomic, strong) NSArray* selectionArray;

@property (nonatomic, strong) AddrRegionCell* receiveWayCell;
@property (nonatomic, strong) AddrRegionCell* bankAccoutCell;
@property (nonatomic, strong) AddrRegionCell* logisCell;
@property (nonatomic, strong) AddrCommonCell* logisNoCell;

@end

@implementation OrderSendViewController

-(UIButton*)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmButton setTitle:@"确认发货" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        
    }
    return _confirmButton;
}

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:self.confirmButton];
        [self.view addSubview:_bottomView];
    }
    
    return _bottomView;
}

-(NSArray*)receiveWay
{
    return @[@"账户余额", @"银行转账"];
}

-(instancetype)initWithOrderDetaildtos:(NSArray*)orderDetailDtos
{
    self = [super init];
    if (self) {
        self.orderDetailDtos = orderDetailDtos;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认发货";
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    self.tableView.frame = self.view.frame;
    
    HttpMineAccountRequest*  accountRequest = [[HttpMineAccountRequest alloc] init];
    [accountRequest request]
    .then(^(id responseObj){
        HttpMineAccountResponse* response = (HttpMineAccountResponse*)accountRequest.response;
        if (response.ok) {
            self.bankAccounts = response.backCards;
            if (self.bankAccounts.count>0) {
                if ([self.receiveWay indexOfObject: self.receiveWayCell.value] == 0) {
                    for (BankCardDTO* dto in self.bankAccounts) {
                        if (dto.isDefault) {
                            self.bankAccoutCell.value = dto.bankDesc;
                        }
                    }
                }
            }
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    HttpLogisRequest* logisRequest = [[HttpLogisRequest alloc] init];
    [logisRequest request]
    .then(^(id responseObj){
        HttpLogisResponse* response = (HttpLogisResponse*)logisRequest.response;
        if (response.ok) {
            self.logisArray = response.logises;
            if (self.logisArray.count>0) {
                self.logisCell.value = ((LogisDTO*)self.logisArray[0]).name;

            }
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    self.receiveWayCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
    self.receiveWayCell.title = @"收款方式";
    self.receiveWayCell.value = self.receiveWay[0];

    self.bankAccoutCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
    self.bankAccoutCell.title = @"银行账号";
    
    self.logisCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
    self.logisCell.title = @"物流方式";
    
    self.logisNoCell =  (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
    self.logisNoCell.title = @"物流单号";
    self.logisNoCell.placehoder = @"请输入物流单号";
    
    [self.confirmButton addTarget:self action:@selector(orderSender:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)orderSender:(id)sender
{
    NSMutableArray* ids = [[NSMutableArray alloc] init];
    for (OrderDetailDTO* dto in self.orderDetailDtos) {
        [ids addObject:[NSString stringWithFormat:@"%ld", dto.id]];
    }
    
    
    NSInteger checkoutMethod = [self.receiveWay indexOfObject:self.receiveWayCell.value]+1;
    NSInteger bankIndex;
    BankCardDTO* dto = nil;
    for (bankIndex = 0; bankIndex<self.bankAccounts.count; ++bankIndex) {
        dto = self.bankAccounts[bankIndex];
        if ([dto.bankDesc isEqualToString:self.bankAccoutCell.value]) {
            break;
        }
    }
    
    NSInteger logisIndex;
    for (logisIndex = 0; logisIndex<self.logisArray.count; ++logisIndex) {
        LogisDTO* dto = self.logisArray[logisIndex];
        if ([dto.name isEqualToString:self.logisCell.value]) {
            break;
        }
    }
    
    
    @weakify(self);
    [self showAlertViewWithMessage:@"确认发货吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        [self showProgressIndicator];
                        NSInteger bankAccountId = 0;
                        if (checkoutMethod==2) {
                            bankAccountId = dto.id;
                        }
                        HttpOrderSendRequest *request = [[HttpOrderSendRequest alloc] initWithOids:ids
                                                                                 andCheckoutMethod:checkoutMethod
                                                                                        andAccount:bankAccountId
                                                                                        andLogisId:((LogisDTO*)self.logisArray[logisIndex]).id
                                                                                      andLogisName:((LogisDTO*)self.logisArray[logisIndex]).name
                                                                                      andOrderCode:self.logisNoCell.value];
                        [request request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (request.response.ok) {
                                if ([self.delegate respondsToSelector:@selector(sendSuccessWithOrderDetailDtos:)]) {
                                    [self.delegate sendSuccessWithOrderDetailDtos:self.orderDetailDtos];
                                }
                                
                                UIViewController* popToVC = nil;
                                for (UIViewController* vc in self.navigationController.viewControllers) {
                                    if ([vc isKindOfClass:NSClassFromString(@"OrderDetailViewController")]) {
                                        popToVC = vc;
                                        break;
                                    }
                                    else if([vc isKindOfClass:NSClassFromString(@"NewOrderListViewController")]) {
                                        popToVC = vc;
                                        break;
                                    }
                                }
                                if (popToVC) {
                                    [self.navigationController popToViewController:popToVC animated:YES];
                                }
                                else {
                                    [self.navigationController popToRootViewControllerAnimated:YES];
                                }
                            }
                            else {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        })
                        .finally(^(){
                            [self dismissProgressIndicator];
                        });
    
                    }
                 andCancelCallback:nil ];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-45, self.view.bounds.size.width, 45);
    self.confirmButton.frame = self.bottomView.bounds;

}

#pragma -- mark UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0 && indexPath.row==1) {
        if(![self.receiveWayCell.value isEqualToString:self.receiveWay[1]]){
            return 0.f;
        }
    }
    
    return 44.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                cell = self.receiveWayCell;
            }
            else {
                cell = self.bankAccoutCell;
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                cell = self.logisCell;
            }
            else {
                cell = self.logisNoCell;
            }
        }
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.editingIndexPath = indexPath;
    NSInteger selectedIndex = NSNotFound;
    SelectionViewController* selectionVC;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.selectionArray = self.receiveWay;
            selectedIndex = [self.selectionArray indexOfObject:self.receiveWayCell.value];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.receiveWay andSelectedIndex:selectedIndex andTitle:@"请选收货方式"];
        }
        else {
            NSMutableArray* selectionStrings = [[NSMutableArray alloc] init];
            for (NSInteger index = 0; index<self.bankAccounts.count; ++index) {
                BankCardDTO* bankCard = self.bankAccounts[index];
                [selectionStrings addObject:bankCard.bankDesc];
                if ([self.bankAccoutCell.value isEqualToString:bankCard.bankDesc]) {
                    selectedIndex = index;
                }
            }
            selectionVC = [[SelectionViewController alloc] initWithDataSource:selectionStrings andSelectedIndex:selectedIndex andTitle:@"请选银行账号"];

        }
    }
    else{
        if (indexPath.row == 0) {
            NSMutableArray* selectionStrings = [[NSMutableArray alloc] init];
            for (NSInteger index = 0; index<self.logisArray.count; ++index) {
                LogisDTO* logis = self.logisArray[index];
                [selectionStrings addObject:logis.name];
                if ([self.logisCell.value isEqualToString:logis.name]) {
                    selectedIndex = index;
                }
            }
            selectionVC = [[SelectionViewController alloc] initWithDataSource:selectionStrings andSelectedIndex:selectedIndex andTitle:@"请选物流方式"];
        }
        else {
            return;
        }
    }
    selectionVC.delegate = self;
    [self.navigationController pushViewController:selectionVC animated:YES];

}

#pragma -- mark SelectionViewControllerDelegate
-(void)didSelectItemWithTitle:(NSInteger)selectedIndex
{
    if (self.editingIndexPath.section == 0) {
        if (self.editingIndexPath.row == 0) {
            self.receiveWayCell.value = self.receiveWay[selectedIndex];
            if(selectedIndex == 0){
                self.bankAccoutCell.value = @"";
                self.bankAccoutCell.userInteractionEnabled = NO;
            }
            else {
                if (self.bankAccoutCell.value.length == 0) {
                    if (self.bankAccounts.count>0) {
                        self.bankAccoutCell.value = ((BankCardDTO*)self.bankAccounts[0]).bankDesc;
                    }
                }
                self.bankAccoutCell.userInteractionEnabled = YES;

            }
            [self.tableView reloadData]; 
        }
        else {
            self.bankAccoutCell.value = ((BankCardDTO*)self.bankAccounts[selectedIndex]).bankDesc;
        }
    }
    else {
        if (self.editingIndexPath.row == 0) {
            self.logisCell.value = ((LogisDTO*)self.logisArray[selectedIndex]).name;
        }
    }
}


@end
