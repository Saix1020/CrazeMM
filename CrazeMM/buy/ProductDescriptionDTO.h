//
//  ProductDescriptionDTO.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"



@interface ProductDescriptionDTO : BaseDTO

@property (nonatomic, copy) NSString* imageURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic) NSUInteger id;
@property (nonatomic, copy) NSString* status;
@property (nonatomic) NSUInteger remainingTime;
@property (nonatomic, strong) NSDate* createTime;
@property (nonatomic, readonly) NSString* detail;
@property (nonatomic) double minimumPrice;
@property (nonatomic) NSUInteger minimumNumber;
@property (nonatomic) BOOL canSplit;

@property (nonatomic) NSUInteger elapseTime;

@property (nonatomic, readonly) NSString* miniumPriceString1;
@property (nonatomic, readonly) NSString* miniumPriceString2;
@property (nonatomic, readonly) NSString* minimumNumberString;
// add more

+(ProductDescriptionDTO*)mockDate;

@end
