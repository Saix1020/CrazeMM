//
//  DetailArea.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailArea : NSObject


@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *areaName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailAreaWithDict:(NSDictionary *)dict;

@end
