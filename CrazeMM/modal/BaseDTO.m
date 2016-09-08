//
//  BaseDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@implementation BaseDTO

//+(NSDictionary*)validateDict:(NSDictionary*)dict
//{
//    NSMutableDictionary* d = [dict mutableCopy];
//    
//    for(NSString* key in d.allKeys){
//        id value = d[key];
//        if ([value isKindOfClass:[NSNull class]]) {
//            [d removeObjectForKey:key];
//        }
//    }
//    
//    return d;
//}

-(instancetype)initWith:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
//        dict = [BaseDTO validateDict:dict];
        self.id = [dict[@"id"] integerValue];
    }
    return self;
}
-(NSDictionary *)encode
{
    return nil;
}

-(void)parserResponse
{
    
}

@end


@implementation BaseListDTO

-(float)totalPrice
{
    return 0.f;
}

@end


@implementation BaseLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.uid = [dict[@"uid"] integerValue];
        self.oldState = [dict[@"oldState"] integerValue];
        self.oid = [dict[@"oid"] integerValue];
        self.newState = [dict[@"newState"] integerValue];
        
        self.stateLabelNew = dict[@"newStateLabel"];
        self.createTime = dict[@"createTime"];
    }
    
    return self;
}

@end
