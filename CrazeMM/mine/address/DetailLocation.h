//
//  DetailLocation.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailCity;

@interface DetailLocation : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, strong) NSArray *citylist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailLocationWithDict:(NSDictionary *)dict;

@end
