//
//  HttpBalance.h
//  CrazeMM
//
//  Created by saix on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BalanceDTO.h"

@interface HttpBalanceRequest : BaseHttpRequest

@end

@interface HttpBalanceResponse : BaseHttpResponse

@property (nonatomic, strong) BalanceDTO* balanceDto;

@end
