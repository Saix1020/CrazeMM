//
//  BuyProductiewController.m
//  CrazeMM
//
//  Created by saix on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyProductViewController.h"
#import "HttpProductDetail.h"
#import "BuyProductView.h"
#import "HttpAddIntention.h"
#import "HttpBuyOrder.h"

@interface BuyProductViewController ()

@property (nonatomic, strong) UIButton* supplyButton;
@property (nonatomic, strong) BuyProductView* supplyProductView;
@end

@implementation BuyProductViewController

// WTF, why we need overload loadView here?
-(void)loadView
{
    [super loadView];
}

-(instancetype)initWithProductDTO:(BaseProductDTO *)dto
{
    self = [super initWithProductDTO:dto];
    if (self) {
        if (!self.productDto.isActive) {
            self.supplyButton.enabled = NO;
            self.supplyButton.backgroundColor = [UIColor clearColor];
        }
        else {
            self.supplyButton.enabled = YES;
            self.supplyButton.backgroundColor = [UIColor redButtonColor];
        }
    }

    return self;
    
}


-(UIButton*)supplyButton
{
    if (!_supplyButton) {
        _supplyButton  = [UIButton buttonWithType:UIButtonTypeSystem];
        [_supplyButton setTitle:@"我来供货" forState:UIControlStateNormal];
        _supplyButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _supplyButton.layer.cornerRadius = 0;
        [_supplyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_supplyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [self.buttomView addSubview:_supplyButton];

        @weakify(self);
        self.supplyButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
            
            @strongify(self);

            [HttpAddIntentionRequest addIntention:self.productDetailDto.id andType:kTypeBuy];
            if ([UserCenter defaultCenter].isLogined) {
                self.modalView.presentAnimationStyle = SlideInUp;
                self.modalView.dismissAnimationStyle = SlideOutDown;
                self.modalView.contentView = self.supplyProductView;
                self.modalView.isCancelAble = NO;
                [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
                    @strongify(self);
                    BuyProductView* orderProductView = (BuyProductView*)contentView;
                    orderProductView.productDetailDto = self.productDetailDto;
                }];
                
            }
            else {
                LoginViewController* loginVC = [[LoginViewController alloc] init];
                loginVC.fromVC = self;
                [self.navigationController pushViewController:loginVC animated:YES];
            }

            return [RACSignal empty];
        }];
    }
    
    return _supplyButton;
}

-(BuyProductView*)supplyProductView
{
    if(!_supplyProductView){
        _supplyProductView  =  [[[NSBundle mainBundle]loadNibNamed:@"BuyProductView" owner:nil options:nil] firstObject];
        [self.view addSubview:_supplyProductView];
        _supplyProductView.amountLabel.text = @"供货数量";
        _supplyProductView.amountTextField.userInteractionEnabled = NO;
        _supplyProductView.subButton.userInteractionEnabled = NO;
        _supplyProductView.addButton.userInteractionEnabled = NO;
        @weakify(self);
        _supplyProductView.determineButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            //            [self.modalView dismiss];
            
            if ([_supplyProductView.amountTextField.text integerValue] > 0  && [_supplyProductView.amountTextField.text integerValue] <= self.productDetailDto.quantity) {
                [self.modalView dismiss];
                [self handleOrderWithQuantity:[_supplyProductView.amountTextField.text integerValue] andMessage:_supplyProductView.descTextView.text];
            }
            else {
                [self showAlertViewWithMessage:@"请输入正确的数量!"];
            }
            return [RACSignal empty];
        }];
        
        _supplyProductView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input){
            @strongify(self);
            [self.modalView dismiss];
            return [RACSignal empty];
        }];
        _supplyProductView.x = 0;
        _supplyProductView.y = [UIScreen mainScreen].bounds.size.height - _supplyProductView.height;
        _supplyProductView.width = [UIScreen mainScreen].bounds.size.width;
        
    }
    
    return _supplyProductView;
}


-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.supplyButton.frame = CGRectMake(0, 20, self.view.bounds.size.width, 50);
}

-(void)getProductDetail:(BOOL)needHud
{
    HttpBuyProductDetailRequest* request = [[HttpBuyProductDetailRequest alloc] initWithProductId:self.productDto.id];
    if (needHud) {
        [self showProgressIndicatorWithTitle:@"正在努力加载..."];
    }
    [request request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpBuyProductDetailResponse* response = (HttpBuyProductDetailResponse*)request.response;
        
        self.productDetailDto = response.dto;
        [self.productDto resetByProductDetailDto:self.productDetailDto];
        if (!self.productDto.isActive) {
            self.supplyButton.enabled = NO;
            self.supplyButton.backgroundColor = [UIColor clearColor];
        }
        else {
            self.supplyButton.enabled = YES;
            self.supplyButton.backgroundColor = [UIColor redButtonColor];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        if (needHud) {
            [self dismissProgressIndicator];
        }
    });
}

-(void)handleOrderWithQuantity:(NSInteger)quantity andMessage:(NSString *)message
{
    HttpBuyOrderRequest* request = [[HttpBuyOrderRequest alloc] initWithBid:self.productDto.id andQuantity:quantity andMessage:message];
    
    [request request]
    .then(^(id responseObj){
        if (request.response.ok) {
            [self showAlertViewWithMessage:@"供货成功"];
            [self getProductDetail:NO];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    
}

-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}
@end
