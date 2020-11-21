//
//  RechargeLogDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
//{"no":160610361819444,"uid":4,"auid":null,"methodDesc":"个人网银","money":1.00,"method":1,"createTime":"2016-06-10 10:03:04","stateDesc":"充值中","updateTime":"2016-06-10 10:03:04","comment":null,"id":15,"state":100}
@interface RechargeLogDTO : BaseDTO

@property (nonatomic) NSInteger no;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger method;
@property (nonatomic) NSInteger state;

@property (nonatomic, copy) NSString* methodDesc;
@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* stateDesc;
@property (nonatomic, copy) NSString* updateTime;
@property (nonatomic, copy) NSString* comment;

@property (nonatomic) float money;

@end
