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

@implementation SupplyProductViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.supplyOrBuyButton setTitle:@"我来供货" forState:UIControlStateNormal];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
