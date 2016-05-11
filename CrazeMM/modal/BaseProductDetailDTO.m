//
//  BaseProductDetailDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseProductDetailDTO.h"

//@property (nonatomic, copy) NSString* typeName;
//@property (nonatomic) NSInteger validateState;
//@property (nonatomic, copy) NSString* username;

@implementation ProductUserInfo



-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.typeName = dict[@"typeName"];
        self.validateState = [dict[@"validateState"] integerValue];
        self.username = dict[@"username"];
        self.successOrderCount = [dict[@"successOrderCount"] integerValue];
    }
    
    return self;
}

@end

@implementation ProductStepPrice

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        self.qfrom = [dict[@"qfrom"] integerValue];
        self.qto = [dict[@"qto"] integerValue];
        self.sid = [dict[@"sid"] integerValue];
        self.sprice = [dict[@"sprice"] floatValue];

    }
    
    return self;
}

@end



@implementation BaseProductDetailDTO
-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.users = [[ProductUserInfo alloc] initWith:dict[@"user"]];
        
        self.isSplit = [dict[@"isSplit"] boolValue];
        self.isStep = [dict[@"isStep"] boolValue];
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];
        self.active = [dict[@"active"] boolValue];
        self.isSerial = [dict[@"isSerial"] boolValue];
        self.isTop = [dict[@"isTop"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        
        self.quantity = [dict[@"quantity"] integerValue];
        self.millisecond = [dict[@"millisecond"] integerValue];
        self.intentions = [dict[@"intentions"] integerValue];
        self.version = [dict[@"version"] integerValue];
        self.duration = [dict[@"duration"] integerValue];
        self.left = [dict[@"left"] integerValue];
        self.state = [dict[@"state"] integerValue];
        
        self.price = [dict[@"price"] floatValue];
        
        self.region = dict[@"region"];
        self.deadlineStr = dict[@"deadlineStr"];
        self.goodName = dict[@"goodName"];
        self.stateLabel = dict[@"stateLabel"];
        self.message = dict[@"message"];
        
        if (self.isStep) {
            [self parserProductSteporices:dict[@"stepPrices"]];
        }
    }
    
    return self;
}

-(void)parserProductSteporices:(NSArray*)stepPrices
{
    self.stepPrices = [[NSMutableArray alloc] init];
    
    for (NSDictionary* stepPrice in stepPrices) {
        ProductStepPrice* productStepPrice = [[ProductStepPrice alloc] initWith:stepPrice];
        [self.stepPrices addObject:productStepPrice];
    }
    
}

@end
