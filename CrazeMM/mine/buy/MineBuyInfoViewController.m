//
//  MineBuyInfoViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineBuyInfoViewController.h"
#import "HttpMineSupply.h"

@interface MineBuyInfoViewController ()

@property (nonatomic, readonly) NSInteger bid;
@property (nonatomic, strong) MineBuyDetailDTO* buyDetailDto;

@end



@implementation MineBuyInfoViewController

-(NSInteger)bid
{
    return self.sid;
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
