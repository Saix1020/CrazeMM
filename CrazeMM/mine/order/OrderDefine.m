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
                string =  @"待付款";
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

+(NSDictionary*)allOrderStateMap
{
    return @{
             @"待付款" : @(TOBEPAID), //
             @"支付中" : @(PAYING), //
             @"已撤销" : @(CANCELED), // 
             @"待发货" : @(TOBESENT), //
             @"待签收" : @(TOBERECEIVED), //
             @"待结款" : @(TOBESETTLED),  //
             @"结款待确认" : @(TOBECONFIRMED), 
             @"已完成" : @(COMPLETED), //
             @"已关闭" : @(ORDERCLOSE), //
             @"支付超时" : @(PAYTIMEOUT), //
             @"待退货" : @(RETURNING), //
             @"待仲裁" : @(ARBITRATING), //
             @"待退款" : @(PAYBACK)
             
             };
}

+(NSArray*)allOrderState
{
    return @[
             @"待付款", @"支付中", @"已撤销",
             @"待发货", @"待签收", @"待结款",
             @"结款待确认", @"已完成", @"已关闭",
             @"支付超时", @"待退货", @"待仲裁",
             @"待退款"
             ];
}


@end
