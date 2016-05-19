//
//  ProductDescriptionDTO.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "BaseProductDTO.h"



@interface ProductDescriptionDTO : BaseProductDTO

@property (nonatomic, copy) NSString* imageURL;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* status;
@property (nonatomic) NSUInteger remainingTime;
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
