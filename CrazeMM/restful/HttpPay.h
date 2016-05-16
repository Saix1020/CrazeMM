//
//  HttpPay.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "PayInfoDTO.h"

@interface HttpPayInfoRequest : BaseHttpRequest

-(instancetype)initWithPayPrice:(CGFloat)price;

@end

@interface HttpPayInfoResponse : BaseHttpResponse

@property (nonatomic, strong) PayInfoDTO* payInfoDto;

@end


@interface HttpPayRequest : BaseHttpRequest

-(instancetype)initWithPayDetail:(PayInfoDTO*)payInfoDto;

@end
