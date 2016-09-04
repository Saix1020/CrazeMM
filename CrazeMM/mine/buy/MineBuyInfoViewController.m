//
//  MineBuyInfoViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineBuyInfoViewController.h"
#import "HttpMineSupply.h"
#import "HttpMineSupplyShelve.h"

@interface MineBuyInfoViewController ()

@property (nonatomic, readonly) NSInteger bid;
@property (nonatomic, strong) MineBuyDetailDTO* buyDetailDto;

@end



@implementation MineBuyInfoViewController

-(NSInteger)bid
{
    return self.sid;
}

-(NSArray*)bottomButtonsTitle
{
    NSArray* titles;
    switch (self.state) {
        case 100: //正常
            titles = @[@"下架"];
            break;
        case 400:
        case 500: //下架
            titles = @[@"上架", @"修改"];
            break;
        case 150:
        case 200: //成交
            break;
        default:
            break;
    }
    
    return titles;
}

-(void)handleClickEvent:(id)sender
{
    switch (self.state) {
        case 100: //正常
        {
            HttpMineBuyUnshelveRequest* request = [[HttpMineBuyUnshelveRequest alloc] initWithIds:@[@(self.bid)]];
            [self invokeHttpRequest:request
                    andConfirmTitle: [NSString stringWithFormat:@"确认要下架%ld吗?", self.sid]
                    andSuccessTitle:@"下架成功"];
        }
        
            break;
        case 400:
        case 500: //
        {
            HttpMineBuyReshelveRequest* request = [[HttpMineBuyReshelveRequest alloc] initWithIds:@[@(self.bid)]];
            [self invokeHttpRequest:request
                    andConfirmTitle: [NSString stringWithFormat:@"确认要上架%ld吗?", self.sid]
                    andSuccessTitle:@"上架成功"];
        }
            
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"求购%ld详情", self.bid];
}

-(AFPromise*)getDtoDetailInfo
{
        HttpMineBuyDetailRequest* request = [[HttpMineBuyDetailRequest alloc]initWithId:self.sid];
    
        return [request request]
        .then(^(id responseObj){
            NSLog(@"%@", responseObj);
            HttpMineBuyDetailResponse * response = (HttpMineBuyDetailResponse*)request.response;
            if (response.ok) {
                self.buyDetailDto = response.buyDetailDto;
                [self deplayTimeLine:self.buyDetailDto.logs];
            }
    
            else{
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
            
        });

}

@end
