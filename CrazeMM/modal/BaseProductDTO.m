//
//  BaseProductDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseProductDTO.h"

@implementation BaseProductDTO

-(instancetype)initWith:(NSDictionary*)dict
{
    self = [self init];
    //
    if (self) {
        self.id = [dict[@"id"] integerValue];
        self.deadlineStr = dict[@"deadlineStr"];
        self.goodName = dict[@"goodName"];
        self.region = dict[@"region"];
        self.stateLabel = dict[@"stateLabel"];
        self.userImage = dict[@"userImage"];
        self.userName = dict[@"userName"];
        self.duration = [dict[@"duration"] integerValue];
        self.intentions = [dict[@"intentions"] integerValue];
        self.isActive = [dict[@"active"] boolValue];
        self.isAnoy = [dict[@"isAnoy"] boolValue];
        self.millisecond = [dict[@"millisecond"] integerValue];
        self.isStep = [dict[@"isStep"] boolValue];
        self.price = [dict[@"price"] floatValue];
        self.quantity = [dict[@"quantity"] integerValue];
        self.views = [dict[@"views"] integerValue];
        self.createTime = dict[@"createTime"];
        self.goodImage = dict[@"goodImage"];
        self.address = dict[@"address"];
        
        //isBrushMachine = 1;
        //isOriginal = 1;
        //isOriginalBox = 1;
        //isSerial = 1;
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isSerial = [dict[@"isSerial"] boolValue];


        
        self.selected = NO;
        if ([dict[@"stock"] isKindOfClass:[NSNumber class]]) {
            self.stock = nil;
        }
        else {
            self.stock = dict[@"stock"];
        }
        
        if(NotNilAndNull(dict[@"depot"])){
            self.depotDto = [[DepotDTO alloc] initWith:dict[@"depot"]];
        }
        else if (NotNilAndNull(self.stock)) {
            self.depotDto = [[DepotDTO alloc] initWith:self.stock[@"depot"]];
        }
    }
    
    return self;
}



-(void)resetByProductDetailDto:(BaseProductDetailDTO*)detailDto
{
    self.deadlineStr = detailDto.deadlineStr;
    self.region = detailDto.region;
    self.stateLabel = detailDto.stateLabel;
    self.duration = detailDto.duration;
    self.intentions = detailDto.intentions;
    self.isActive = detailDto.active;
    self.millisecond = detailDto.millisecond;
    self.isStep = detailDto.isStep;
    self.price = detailDto.price;
    self.quantity = detailDto.quantity;
    self.views = detailDto.views;
}


-(NSString*)description
{
    NSString* desc = [NSString stringWithFormat:
                      @"id : %lu\n"
                      "deadlineStr: %@\n"
                      "goodName : %@\n"
                      "region : %@\n"
                      "stateLabel : %@\n"
                      "userImage : %@\n"
                      "userName : %@\n"
                      "duration:%ld\n"
                      "intentions:%ld\n"
                      "isActive:%d\n"
                      "isAnoy:%d\n"
                      "isStep:%d\n"
                      "millisecond:%ld\n"
                      "price:%ld\n"
                      "quantity:%ld\n"
                      "views:%ld"
                      ,self.id
                      ,self.deadlineStr, self.goodName, self.region,
                      self.stateLabel, self.userImage, self.userName,
                      self.duration, self.intentions, self.isActive,
                      self.isAnoy, self.isStep, self.millisecond,
                      (long)self.price, self.quantity, (long)self.views];
    
    return desc;
    
}


@end
