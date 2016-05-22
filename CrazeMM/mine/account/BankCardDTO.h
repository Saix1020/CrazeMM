//
//  BankCardDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface BankCardDTO : BaseDTO


@property (nonatomic, copy) NSString* bankaccount;
@property (nonatomic, copy) NSString* bankusername;
@property (nonatomic) BOOL isDefault;
@property (nonatomic, copy) NSString* openingbank;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger uid;

@end
