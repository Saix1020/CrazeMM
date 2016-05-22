//
//  AddressInfo.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressInfo.h"

@implementation AddressInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_state             forKey:@"state"];
    [aCoder encodeObject:_name            forKey:@"name"];
    [aCoder encodeObject:_phone           forKey:@"phone"];
    [aCoder encodeObject:_province        forKey:@"province"];
    [aCoder encodeObject:_detailAddress   forKey:@"detailAddress"];
    [aCoder encodeObject:_zipCode         forKey:@"zipCode"];

}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.state           = [decoder decodeBoolForKey:@"state"];
        self.name            = [decoder decodeObjectForKey:@"name"];
        self.phone           = [decoder decodeObjectForKey:@"phone"];
        self.province        = [decoder decodeObjectForKey:@"province"];
        self.detailAddress   = [decoder decodeObjectForKey:@"detailAddress"];
        self.zipCode   = [decoder decodeObjectForKey:@"zipCode"];
    }
    return self;
}


@end
