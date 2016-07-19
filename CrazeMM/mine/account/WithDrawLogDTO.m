//
//  WithDrawLogDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithDrawLogDTO.h"

@implementation WithDrawLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.amount = [dict[@"amount"] floatValue];
        self.uid = [dict[@"uid"] integerValue];
        self.state = [dict[@"state"] integerValue];
        self.bid = [dict[@"bid"] integerValue];
        
        self.bankaccount = dict[@"bankaccount"];
        self.bankusername = dict[@"bankusername"];
        self.createTime = dict[@"createTime"];
        self.stateLabel = dict[@"stateLabel"];
        self.comment = dict[@"comment"];
        self.applyTime = dict[@"applyTime"];
        self.openingbank = dict[@"openingbank"];


    }
    return self;
}

-(NSString*)bankDesc
{
    NSString* bankAccout;
    //if (NotNilAndNull(self.bankaccount)) {
        if (self.bankaccount.length<4) {
            bankAccout = self.bankaccount;
        }
        else {
            bankAccout = [self.bankaccount substringFromIndex:self.bankaccount.length-4];
        }
        
        return [NSString stringWithFormat:@"%@(%@)", self.openingbank, bankAccout];
    //}
    
//    else {
        return @"";
//    }
}

@end
