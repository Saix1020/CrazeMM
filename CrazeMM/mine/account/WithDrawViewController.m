//
//  RechargeViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithDrawViewController.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SuggestViewController.h"
#import "ZZPopoverWindow.h"
#import "HttpPay.h"
#import "TTModalView.h"
#import "PayAlertView.h"
#import "OnlinePayViewController.h"
#import "WithDrawAlertView.h"
#import "HttpMineAccount.h"
#import "BankCardDTO.h"
#import "HttpWithDraw.h"


@interface WithDrawViewController ()

@property (nonatomic, strong) AddrCommonCell* moneyCell;
@property (nonatomic, strong) AddrRegionCell* typeCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;
@property (strong, nonatomic) SuggestViewController* suggestVC;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@property (nonatomic, strong) TTModalView* confirmModalView;
@property (nonatomic, strong) WithDrawAlertView* withDrawAlertView;
@property (nonatomic, strong) PayInfoDTO* payInfoDto;

@property (nonatomic, strong) NSArray* bankInfo;
@property (nonatomic) NSInteger selectedBankCardIndex;
@end

@implementation WithDrawViewController

-(AddrCommonCell*)moneyCell
{
    if (!_moneyCell) {
        _moneyCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _moneyCell.title = @"提现金额";
        _moneyCell.placehoder = @"请输入金额";
        _moneyCell.textFieldCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _moneyCell;
}

-(AddrRegionCell*)typeCell
{
    if (!_typeCell) {
        _typeCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _typeCell.title = @"银行账号";
        _typeCell.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
//        _typeCell.value = @"个人网银";
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
        
        [_confirmButton addTarget:self action:@selector(withDraw:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmCell;
}

-(TTModalView*)confirmModalView
{
    if (!_confirmModalView) {
        _confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
        _confirmModalView.isCancelAble = YES;
        _confirmModalView.modalWindowLevel = UIWindowLevelNormal;
//        _confirmModalView.contentView = self.withDrawAlertView;
    }
    
    return _confirmModalView;
}

//-(WithDrawAlertView*)withDrawAlertView
//{
//    if(!_withDrawAlertView){
//        _withDrawAlertView = (WithDrawAlertView*)[UINib viewFromNib:@"WithDrawAlertView"];
//        _withDrawAlertView.layer.cornerRadius = 6.f;
//        
//    }
//    return _withDrawAlertView;
//}



-(void)withDraw:(id)sender
{
//    [self.moneyCell.textFieldCell resignFirstResponder];
    [self.view endEditing:YES];
    self.confirmModalView.modalWindowFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.withDrawAlertView = (WithDrawAlertView*)[UINib viewFromNib:@"WithDrawAlertView"];
    self.withDrawAlertView.delegate = self;
    self.withDrawAlertView.layer.cornerRadius = 6.f;
    self.confirmModalView.contentView = self.withDrawAlertView;
    @weakify(self);
    self.withDrawAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        @strongify(self);
        [self.confirmModalView dismiss];
        return [RACSignal empty];
    }];

    self.confirmModalView.presentAnimationStyle = fadeIn;
    self.confirmModalView.dismissAnimationStyle = fadeOut ;
    
    [self.confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY-25.f;
        
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户充值";
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    HttpMineAccountRequest* request = [[HttpMineAccountRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            HttpMineAccountResponse* response = (HttpMineAccountResponse*)request.response;
            self.bankInfo = response.backCards;
            for (BankCardDTO* dto in self.bankInfo) {
                if (dto.isDefault) {
                    self.typeCell.value = dto.bankDesc;
                    self.selectedBankCardIndex = [self.bankInfo indexOfObject:dto];
                    break;
                }
            }
        }
    });
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
        NSMutableArray* suggestStrings = [[NSMutableArray alloc] init];
        for (BankCardDTO* dto in self.bankInfo) {
            [suggestStrings addObject:dto.bankDesc];
        }
        if (suggestStrings.count != 0) {
            self.suggestVC.suggestedStrings = suggestStrings;
            self.suggestVC.delegate = self;
            self.suggestVC.view.frame = CGRectMake(0, 0, self.typeCell.width, self.suggestVC.height);
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
    
//    if (![selectedString isEqualToString:@"个人网银"]) {
//        [self showAlertViewWithMessage:@"改充值方式暂不支持, 敬请期待"];
//    }
//    
//    self.typeCell.value = @"个人网银";
    self.typeCell.value = selectedString;
    for (NSInteger i=0; i<self.bankInfo.count; ++i) {
        if ([((BankCardDTO*)self.bankInfo[i]).bankDesc isEqualToString:selectedString]) {
            self.selectedBankCardIndex = i;
            break;
        }
    }
    
    [self.popover dismiss];
}

-(void)DidFinishInput:(NSString *)inputString
{
    //[self.view endEditing:YES];
    [self.confirmModalView dismiss];
    BankCardDTO* dto = self.bankInfo[self.selectedBankCardIndex];
    HttpWithDrawRequest* request = [[HttpWithDrawRequest alloc] initWithBid:dto.id andPassword:inputString andAmount:[self.moneyCell.value floatValue]];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
//            [self showAlertViewWithMessage:@"提现申请成功"];
            @weakify(self);
            [self showAlertViewWithMessage:@"提现申请成功" withCallback:^(id x){
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
            

        }
        else{
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        
    });
}

@end
