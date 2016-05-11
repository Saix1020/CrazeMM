//
//  SupplyProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyProductViewController.h"
#import "HttpProductDetail.h"

@implementation SupplyProductViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    HttpSupplyProductDetailRequest* request = [[HttpSupplyProductDetailRequest alloc] initWithProductId:self.productDto.id];
    
    [request request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpSupplyProductDetailResponse* response = (HttpSupplyProductDetailResponse*)request.response;
        self.productDetailDto = response.dto;
        
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
        
    })
    .finally(^(){
        
    });
}

@end
