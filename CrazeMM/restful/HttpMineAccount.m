//
//  HttpMineAccount.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMineAccount.h"

@implementation HttpMineAccountRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/user/listBankAccount");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMineAccountResponse class];
}

@end

@implementation HttpMineAccountResponse

-(void)parserResponse
{
    self.backCards = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in self.all[@"list"]) {
        BankCardDTO* dto = [[BankCardDTO alloc] initWith:dict];
        [self.backCards addObject:dto];
    }
}

@end


@implementation HttpSetDefaultAccountRequest

-(instancetype)initWithCardId:(NSInteger)cardId
{
    self = [super init];
    if (self) {
        self.cardId = cardId;
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/user/setDefaultAccount/%ld", self.cardId];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

@end

@implementation HttpDeleteBankAccountRequest

-(instancetype)initWithCardId:(NSInteger)cardId
{
    self = [super init];
    if (self) {
        self.cardId = cardId;
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/user/deleteBankAccount/%ld", self.cardId];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

@end

@implementation HttpSaveBankAccountRequest

//save_bank_token:-1222738828588611419
//userBuySell.openingbank:11111111
//userBuySell.bankaccount:1111111111111
//userBuySell.bankusername:111111
//userBuySell.isDefault:true

-(instancetype)initWithBankName:(NSString *)bankName andBankAccout:(NSString *)bankAccout andUserName:(NSString *)userName andIsDefaut:(BOOL)isDefault
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"userBuySell.openingbank" : bankName,
                         @"userBuySell.bankaccount" : bankAccout,
                         @"userBuySell.bankusername": userName,
                         @"userBuySell.isDefault"   : @(isDefault)
                         } mutableCopy];
    }
    
    return self;
}

-(BOOL)needToken
{
    return YES;

}
-(NSString*)tokenName
{
    return @"save_bank_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/user/saveBankAccount");
}

-(NSString*)method
{
    return @"POST";
}

@end