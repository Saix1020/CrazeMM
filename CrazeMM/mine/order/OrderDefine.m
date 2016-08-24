//
//  OrderDefine.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDefine.h"

@implementation OrderDefine

+(NSString*)orderStateToStringWithType:(MMOrderType)type andState:(MMOrderState)state
{
    NSString* string = @"";
    if (type == kOrderTypeBuy) {
        switch (state) {
            case TOBEPAID:
                string =  @"代付款";
                break;
            case PAYCOMPLETE:
                string = @"支付完成";
                break;
            case PAYTIMEOUT:
                string = @"支付超时";
                break;
            case TOBERECEIVED:
                string = @"待签收";
                break;
            case RECEIVECOMPLETE:
                string = @"签收完成";
                break;
            default:
                break;
        }
    }
    else{
        switch (state) {
            case TOBESENT:
                string =  @"待发货";
                break;
            case SENTCOMPLETE:
                string =  @"发货完成";
                break;
            case TOBECONFIRMED:
                string =  @"待确认";
                break;
            case CONFIRMEDCOMPLETE:
                string =  @"确认完成";
                break;
                
            default:
                break;
        }
    }
    
    
    return string;
}

@end
