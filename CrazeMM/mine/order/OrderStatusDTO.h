//
//  OrderStatusDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "AddrDTO.h"

@interface OrderLogDTO : BaseDTO

@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger oldState;
@property (nonatomic) NSInteger oid;
@property (nonatomic) NSInteger newState;
@property (nonatomic, copy) NSString* stateLabelNew;
@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* comment;
@property (nonatomic, copy) NSString* userName;
//@property (nonatomic, copy) NSString* newStateLabel;


@end

@interface OrderStatusDTO : BaseDTO

@property (nonatomic) BOOL isAnoy;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger state;
@property (nonatomic, copy) NSString* userImage;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic, copy) NSString* goodImage;

@property (nonatomic, copy) NSString* updateTime;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic) CGFloat price;

@property (nonatomic, strong) AddrDTO* addr;
@property (nonatomic, strong) NSMutableArray<OrderLogDTO*>* logs;

@end


