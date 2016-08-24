//
//  BankCardDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BankCardDTO.h"

@implementation BankCardDTO

-(instancetype) initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.bankaccount = dict[@"bankaccount"];
        self.bankusername = dict[@"bankusername"];
        self.isDefault = [dict[@"isDefault"] boolValue];
        self.openingbank = dict[@"openingbank"];
        self.state = [dict[@"state"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
    }
    return self;
}

-(NSString*)bankDesc
{
    NSString* bankAccout;
    if (self.bankaccount.length<4) {
        bankAccout = self.bankaccount;
    }
    else {
        bankAccout = [self.bankaccount substringFromIndex:self.bankaccount.length-4];
    }
    
    return [NSString stringWithFormat:@"%@(%@)", self.openingbank, bankAccout];
}

@end
