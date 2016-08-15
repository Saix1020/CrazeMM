//
//  HttpAddIntention.h
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

typedef NS_ENUM(NSInteger, MMType){
    kTypeBuy = 0,
    kTypeSupply = 1,
};


@interface HttpAddIntentionRequest : BaseHttpRequest

@property (nonatomic) NSInteger sid;
@property (nonatomic) MMType type;

-(instancetype)initWithSid:(NSInteger)sid andType:(MMType)type;
+(void)addIntention:(NSInteger)sid andType:(MMType)type;;

@end

@interface HttpAddViewRequest : BaseHttpRequest

@property (nonatomic) NSInteger sid;
@property (nonatomic) MMType type;

-(instancetype)initWithSid:(NSInteger)sid andType:(MMType)type;;
+(void)addView:(NSInteger)sid andType:(MMType)type;;

@end