//
//  WithDrawLogDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

//{"auid":null,"amount":1.00,"bankaccount":"343434343434","bankusername":"银行名称","uid":4,"createTime":"2016-06-22 21:32:16","stateLabel":"待审批","comment":null,"id":21,"state":100,"bid":148,"applyTime":null,"openingbank":"测试银行"}

@interface WithDrawLogDTO : BaseDTO

@property (nonatomic) float amount;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger bid;

@property (nonatomic, copy) NSString* bankaccount;
@property (nonatomic, copy) NSString* bankusername;
@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic, copy) NSString* comment;
@property (nonatomic, copy) NSString* applyTime;
@property (nonatomic, copy) NSString* openingbank;

@property (nonatomic, readonly) NSString* bankDesc;

@end
