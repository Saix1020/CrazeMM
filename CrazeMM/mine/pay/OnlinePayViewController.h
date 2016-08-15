//
//  OnlinePayViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayInfoDTO.h"
#import "OrderDetailDTO.h"

@interface OnlinePayViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) NSArray* orderDetailDtos;
-(instancetype)initWithPayInfoDto:(PayInfoDTO*)payInfoDto;


@end
