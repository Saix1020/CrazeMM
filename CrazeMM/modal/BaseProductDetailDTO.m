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

@implementation BaseProductLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        self.createTime = dict[@"createTime"];
        self.message = dict[@"message"];
        self.stateLabel = dict[@"newStateLabel"];

        self.afterState = [dict[@"afterState"] integerValue];
        self.beforeState = [dict[@"beforeState"] integerValue];
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
        self.views = [dict[@"views"] integerValue];
        
        self.price = [dict[@"price"] floatValue];
        
        self.region = dict[@"region"];
        self.deadlineStr = dict[@"deadlineStr"];
        self.goodName = dict[@"goodName"];
        self.stateLabel = dict[@"stateLabel"];
        self.message = dict[@"message"];
        
        NSArray* logs = dict[@"logs"];
        
        if (self.isStep) {
            [self parseProductSteporices:dict[@"stepPrices"]];
        }
        
        if (logs.count) {
            [self parseProductLogs:logs];
        }
    }
    
    return self;
}

-(void)parseProductLogs:(NSArray*)logs
{
    self.logs = [[NSMutableArray alloc] init];
    for (NSDictionary* log in logs) {
        BaseProductLogDTO* logDto = [[[self logClass] alloc] initWith:log];
        [self.logs addObject:logDto];
    }
}

-(Class)logClass
{
    return [BaseProductLogDTO class];
}

-(void)parseProductSteporices:(NSArray*)stepPrices
{
    self.stepPrices = [[NSMutableArray alloc] init];
    
    for (NSDictionary* stepPrice in stepPrices) {
        ProductStepPrice* productStepPrice = [[ProductStepPrice alloc] initWith:stepPrice];
        [self.stepPrices addObject:productStepPrice];
    }
    
}

-(CGFloat)totalPriceWithAmount:(NSInteger)amount
{
    CGFloat totalPrice = 0.f;
    if (self.isStep) {
        NSInteger index;
        for (index=0; index<self.stepPrices.count; ++index) {
            ProductStepPrice* stepPrice = self.stepPrices[index];
            if (amount > stepPrice.qfrom && amount <= stepPrice.qto) {
                totalPrice = stepPrice.sprice * amount;
                break;
            }
        }
        if (index == self.stepPrices.count) {
            ProductStepPrice* stepPrice = self.stepPrices.lastObject;
            totalPrice = stepPrice.sprice * amount;
        }
    }
    else {
        totalPrice = amount * self.price;
    }
    
    return totalPrice;
}


@end
