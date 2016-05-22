//
//  DetailCity.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailArea;

@interface DetailCity : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSArray *arealist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailCityWithDict:(NSDictionary *)dict;


@end
