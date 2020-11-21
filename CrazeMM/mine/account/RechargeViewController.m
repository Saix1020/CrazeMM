//
//  RechargeViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RechargeViewController.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SuggestViewController.h"
#import "ZZPopoverWindow.h"
#import "HttpPay.h"
#import "TTModalView.h"
#import "PayAlertView.h"
#import "OnlinePayViewController.h"
#import "WithDrawAlertView.h"

@interface RechargeViewController ()

@property (nonatomic, strong) AddrCommonCell* moneyCell;
@property (nonatomic, strong) AddrRegionCell* typeCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;
@property (strong, nonatomic) SuggestViewController* suggestVC;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@property (nonatomic, strong) TTModalView* confirmModalView;
@property (nonatomic, strong) PayAlertView* payAlertView;
@property (nonatomic, strong) PayInfoDTO* payInfoDto;


@end

@implementation RechargeViewController

-(AddrCommonCell*)moneyCell
{
    if (!_moneyCell) {
        _moneyCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _moneyCell.title = @"充值金额";
        _moneyCell.placehoder = @"请输入金额";
        _moneyCell.textFieldCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _moneyCell;
}

-(AddrRegionCell*)typeCell
{
    if (!_typeCell) {
        _typeCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _typeCell.title = @"充值方式";
        _typeCell.value = @"个人网银";
    }
    return _typeCell;
}

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 16.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        _confirmCell.backgroundColor = RGBCOLOR(240, 240, 240);
        _confirmButton.enabled = NO;
        @weakify(self);
        RACSignal* enableSaveSignal = [RACSignal
                                       combineLatest:@[
                                                       RACObserve(self, moneyCell.value),
                                                       self.moneyCell.textFieldCell.rac_textSignal
                                                       ]
                                       reduce:^() {
                                           return @(self.moneyCell.value.length > 0);
                                       }];
//
        [enableSaveSignal subscribeNext:^(NSNumber* enable){
            @strongify(self);
            if (enable.boolValue) {
                self.confirmButton.enabled = YES;
                self.confirmButton.backgroundColor = [UIColor greenTextColor];
            }
            else {
                self.confirmButton.enabled = NO;
                self.confirmButton.backgroundColor = [UIColor light_Gray_Color];
                
            }
        }];
        
        [_confirmButton addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmCell;
}

-(TTModalView*)confirmModalView
{
    if (!_confirmModalView) {
        _confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
        _confirmModalView.isCancelAble = YES;
        _confirmModalView.modalWindowLevel = UIWindowLevelNormal;
        _confirmModalView.contentView = self.payAlertView;
    }
    
    return _confirmModalView;
}

-(PayAlertView*)payAlertView
{
    if (!_payAlertView) {
        _payAlertView = [[[NSBundle mainBundle]loadNibNamed:@"PayAlertView" owner:nil options:nil] firstObject];
        _payAlertView.layer.cornerRadius = 6.f;
        [_payAlertView.confirmButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _payAlertView;
}


-(void)pay
{
//    AddressDTO* addr = self.selectedAddrDto;
    HttpRechargeRequest* payRequest = [[HttpRechargeRequest alloc] initWithPayNo:self.payInfoDto.ORDERID andMethod:1 andMoney:self.payInfoDto.PAYMENT];
    [payRequest request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (payRequest.response.ok) {
            OnlinePayViewController* vc = [[OnlinePayViewController alloc] initWithPayInfoDto:self.payInfoDto];
            //vc.orderDetailDtos = self.orderDetailDtos;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [self showAlertViewWithMessage:payRequest.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
}

-(void)recharge:(id)sender
{
//    [self.moneyCell.textFieldCell resignFirstResponder];
    [self.view endEditing:YES];
    HttpPayInfoRequest* request = [[HttpPayInfoRequest alloc] initWithPayPrice:[self.moneyCell.value floatValue] andTarget:@"C"];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpPayInfoResponse* response = (HttpPayInfoResponse*)request.response;
        if (response.ok) {
            @weakify(self);
            self.payInfoDto = response.payInfoDto;
            self.confirmModalView.modalWindowFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            self.confirmModalView.presentAnimationStyle = fadeIn;
            self.confirmModalView.dismissAnimationStyle = fadeOut ;
            
            self.payAlertView.totalPriceLabel.text = [NSString stringWithFormat:@"%.02f", self.payInfoDto.PAYMENT];
            self.payAlertView.orderNoLabel.text = self.payInfoDto.ORDERID;
            
            [self.confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
                
                contentView.centerX = self.view.centerX;
                contentView.centerY = self.view.centerY;
                
                
                self.payAlertView.dismissButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    
                    return [RACSignal empty];
                }];
                
                self.payAlertView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    return [RACSignal empty];
                }];
                
                
            }];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
        
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户充值";
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        return 56.f;
    }
    
    return 44.f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0:
            cell = self.typeCell;
            break;
        case 1:
            cell = self.moneyCell;
            break;
        case 2:
            cell = self.confirmCell;
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //
        
        self.suggestVC = [[SuggestViewController alloc] init];
        NSArray* suggestStrings = @[@"个人网银",@"企业网银", @"线下转账"];
        if (suggestStrings.count != 0) {
            self.suggestVC.suggestedStrings = suggestStrings;
            self.suggestVC.delegate = self;
            self.suggestVC.view.frame = CGRectMake(0, 0, self.typeCell.regionLabel.width, self.suggestVC.height);
            self.popover                    = [[ZZPopoverWindow alloc] init];
            self.popover.popoverPosition = ZZPopoverPositionDown;
            self.popover.contentView        = self.suggestVC.view;
            self.popover.animationSpring = NO;
            self.popover.showArrow = NO;
            self.popover.didShowHandler = ^() {
                //self.popover.layer.cornerRadius = 0;
            };
            self.popover.didDismissHandler = ^() {
                //NSLog(@"Did dismiss");
            };
            
            [self.popover showAtView:self.typeCell.regionLabel];
        }

    }
}

-(void)didSelectSuggestString:(NSString*)selectedString
{
//    self.userNameField.text = selectedString;
    
    if (![selectedString isEqualToString:@"个人网银"]) {
        [self showAlertViewWithMessage:@"改充值方式暂不支持, 敬请期待"];
    }
    
    self.typeCell.value = @"个人网银";
    
    [self.popover dismiss];
}

@end
