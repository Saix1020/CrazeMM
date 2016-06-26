//
//  SupplyProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyProductViewController.h"
#import "HttpProductDetail.h"
#import "HttpSupplyOrder.h"
#import "HttpOrderStatus.h"
#import "PayViewController.h"
#import "BuyProductView.h"
#import "HttpAddIntention.h"

@interface SupplyProductViewController()

@property (nonatomic, strong) BuyProductView* buyProductView;
@property (nonatomic, strong) BuyProductView* orderProductView;

@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) UIButton* orderButton;


@end

@implementation SupplyProductViewController

-(instancetype)initWithProductDTO:(BaseProductDTO *)dto
{
    self = [super initWithProductDTO:dto];
    if (self) {
        if (!self.productDto.isActive || self.productDto.millisecond<0) {
            self.payButton.enabled = NO;
            self.orderButton.enabled = NO;
            self.payButton.backgroundColor = [UIColor clearColor];
            self.orderButton.backgroundColor = [UIColor clearColor];
        }
        else {
            self.payButton.enabled = YES;
            self.orderButton.enabled = YES;
            self.payButton.backgroundColor = [UIColor blueButtonColor];
            self.orderButton.backgroundColor = [UIColor redButtonColor];
        }
        
        
    }
    
    return self;
    
}

-(BuyProductView*)buyProductView
{
    if(!_buyProductView){
        _buyProductView  =  [[[NSBundle mainBundle]loadNibNamed:@"BuyProductView" owner:nil options:nil] firstObject];
        [self.view addSubview:_buyProductView];
        @weakify(self);
        _buyProductView.determineButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            //            [self.modalView dismiss];
            
            if ([self.buyProductView.amountTextField.text integerValue] > 0  && [self.buyProductView.amountTextField.text integerValue] <= self.productDetailDto.quantity) {
                [self.modalView dismiss];
                [self handleBuyWithQuantity:[self.buyProductView.amountTextField.text integerValue] andMessage:self.buyProductView.descTextView.text];
            }
            else {
                [self showAlertViewWithMessage:@"请输入正确的数量!"];
            }
            
            //            PayViewController* payVC = [[PayViewController alloc] init];
            //            [self.navigationController pushViewController:payVC animated:YES];
            
            return [RACSignal empty];
        }];
        
        _buyProductView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input){
            @strongify(self);
            [self.modalView dismiss];
            return [RACSignal empty];
        }];
        _buyProductView.x = 0;
        _buyProductView.y = [UIScreen mainScreen].bounds.size.height - _buyProductView.height;
        _buyProductView.width = [UIScreen mainScreen].bounds.size.width;
        
    }
    
    return _buyProductView;
}

-(BuyProductView*)orderProductView
{
    if(!_orderProductView){
        _orderProductView  =  [[[NSBundle mainBundle]loadNibNamed:@"BuyProductView" owner:nil options:nil] firstObject];
        [self.view addSubview:_orderProductView];
        _orderProductView.amountLabel.text = @"订单数量";
        @weakify(self);
        _orderProductView.determineButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            if ([self.orderProductView.amountTextField.text integerValue] > 0  && [self.orderProductView.amountTextField.text integerValue] <= self.productDetailDto.quantity) {
                [self.modalView dismiss];
                [self handleOrderWithQuantity:[self.orderProductView.amountTextField.text integerValue] andMessage:self.orderProductView.descTextView.text];
            }
            else {
                [self showAlertViewWithMessage:@"请输入正确的数量!"];
            }
            
            return [RACSignal empty];
        }];
        
        _orderProductView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input){
            @strongify(self);
            [self.modalView dismiss];
            return [RACSignal empty];
        }];
        
        _orderProductView.x = 0;
        _orderProductView.y = [UIScreen mainScreen].bounds.size.height - _orderProductView.height;
        _orderProductView.width = [UIScreen mainScreen].bounds.size.width;
        
    }
    
    return _orderProductView;
}

-(UIButton*)payButton
{
    if(!_payButton){
        _payButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_payButton setTitle:@"立刻付款" forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        @weakify(self);
        _payButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
//            HttpAddIntentionRequest* request = [[HttpAddIntentionRequest alloc] initWithSid:self.productDetailDto.id];
//            [request request]
//            .then(^(id responseObject){
//                
//            })
//            .catch(^(NSError* error){
//                
//            });
            [HttpAddIntentionRequest addIntention:self.productDetailDto.id andType:kTypeSupply];
            if ([UserCenter defaultCenter].isLogined) {
                self.modalView.presentAnimationStyle = SlideInUp;
                self.modalView.dismissAnimationStyle = SlideOutDown;
                self.modalView.contentView = self.buyProductView;
                self.modalView.isCancelAble = NO;
                [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
                    @strongify(self);
                    BuyProductView* buyProductView = (BuyProductView*)contentView;
                    buyProductView.productDetailDto = self.productDetailDto;
                    
                }];
                
            }
            else {
                LoginViewController* loginVC = [[LoginViewController alloc] init];
                loginVC.fromVC = self;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
            
            return [RACSignal empty];
        }];
        
        [self.buttomView addSubview:_payButton];
        
    }
    
    return _payButton;
}

-(UIButton*)orderButton
{
    if(!_orderButton){
        _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_orderButton setTitle:@"加入订货单" forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        @weakify(self);
        _orderButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [HttpAddIntentionRequest addIntention:self.productDetailDto.id andType:kTypeSupply];
            if ([UserCenter defaultCenter].isLogined) {
                self.modalView.presentAnimationStyle = SlideInUp;
                self.modalView.dismissAnimationStyle = SlideOutDown;
                self.modalView.contentView = self.orderProductView;
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
        
        [self.buttomView addSubview:_orderButton];
    }
    
    return _orderButton;
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
    self.payButton.frame = CGRectMake(0, 20, self.view.bounds.size.width/2, 50);
    self.orderButton.frame = CGRectMake(self.view.bounds.size.width/2, 20, self.view.bounds.size.width/2, 50);
}

-(void)getProductDetail:(BOOL)needHud
{
    HttpSupplyProductDetailRequest* request = [[HttpSupplyProductDetailRequest alloc] initWithProductId:self.productDto.id];
    if (needHud) {
        [self showProgressIndicatorWithTitle:@"正在努力加载..."];
    }
    [request request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpSupplyProductDetailResponse* response = (HttpSupplyProductDetailResponse*)request.response;
        self.productDetailDto = response.dto;
        [self.productDto resetByProductDetailDto:self.productDetailDto];
        if (!self.productDto.isActive) {
            self.payButton.enabled = NO;
            self.orderButton.enabled = NO;
            self.payButton.backgroundColor = [UIColor clearColor];
            self.orderButton.backgroundColor = [UIColor clearColor];
        }
        else {
            self.payButton.enabled = YES;
            self.orderButton.enabled = YES;
            self.payButton.backgroundColor = [UIColor blueButtonColor];
            self.orderButton.backgroundColor = [UIColor redButtonColor];
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
    [super handleOrderWithQuantity:quantity andMessage:message];
    HttpSupplyOrderRequest* request = [[HttpSupplyOrderRequest alloc] initWithSid:self.productDto.id andVersion:self.productDetailDto.version andQuantity:quantity andMessage:message];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
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

-(void)handleBuyWithQuantity:(NSInteger)quantity andMessage:(NSString *)message
{
    HttpSupplyOrderRequest* request = [[HttpSupplyOrderRequest alloc] initWithSid:self.productDto.id andVersion:self.productDetailDto.version andQuantity:quantity andMessage:message];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            //[self getProductDetail:NO];
            HttpSupplyOrderResponse* response = (HttpSupplyOrderResponse*)request.response;
            HttpOrderStatusRequest* orderStatusRequest = [[HttpOrderStatusRequest alloc] initWithOrderId:response.orderId andOderType:kOrderTypeBuy];
            return [orderStatusRequest request]
            .then(^(id responseStatusObj){
                if (orderStatusRequest.response.ok) {
                    HttpOrderStatusResponse* orderStatusResponse = (HttpOrderStatusResponse*)orderStatusRequest.response;
                    PayViewController* payVC = [[PayViewController alloc] initWithOrderStatusDTO:orderStatusResponse.orderStatusDto];
                    [self.navigationController pushViewController:payVC animated:YES];
                }
            });
        }
        else {
//            [self showAlertViewWithMessage:request.response.errorMsg];
            return [BaseHttpRequest httpRequestError:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        //[self.modalView dismiss];
//        [super handleBuyWithQuantity:quantity andMessage:message];
    });
}



-(void)updateProductDto
{
    if (!self.productDetailDto) {
        return;
    }
    
    self.productDto.quantity = self.productDetailDto.quantity;
}

-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}

@end
