//
//  HttpMineAccount.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BankCardDTO.h"


@interface HttpMineAccountRequest : BaseHttpRequest


@end

@interface HttpMineAccountResponse : BaseHttpResponse
@property (nonatomic, strong) NSMutableArray* backCards;
@end

@interface HttpSetDefaultAccountRequest : BaseHttpRequest

@property (nonatomic) NSInteger cardId;
-(instancetype)initWithCardId:(NSInteger)cardId;

@end


@interface HttpDeleteBankAccountRequest : BaseHttpRequest

@property (nonatomic) NSInteger cardId;
-(instancetype)initWithCardId:(NSInteger)cardId;

@end

@interface HttpSaveBankAccountRequest : BaseHttpRequest

-(instancetype)initWithBankName:(NSString*)bankName andBankAccout:(NSString*)bankAccout andUserName:(NSString*)userName andIsDefaut:(BOOL)isDefault;

@end