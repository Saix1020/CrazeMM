//
//  HttpOrderRemove.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderRemove.h"

@interface HttpOrderRemoveRequest()
@property (nonatomic, copy) NSArray* ids;
@end

@implementation HttpOrderRemoveRequest

-(instancetype)initWithOrderIds:(NSArray *)ids
{
    self = [super init];
    if (self) {
        self.ids = ids;
    }
    return self;
}

-(NSString*)url
{
    NSString* idsString = [NSString stringWithFormat:@"%@/%@", @"/rest/order",[self.ids componentsJoinedByString:@","]];
    return COMB_URL(idsString);
}

-(NSString*)method
{
    return @"DELETE";
}

@end
