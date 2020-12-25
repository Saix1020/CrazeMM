//
//  FilterGoodInfo.h
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodDTO.h"
@interface FilterGoodInfo : NSObject

@property (nonatomic, copy) NSArray* colors;
@property (nonatomic, copy) NSArray* networks;
@property (nonatomic, copy) NSArray* volumes;
@property (nonatomic, copy) NSArray<GoodBrandDTO*>* brands;


+ (FilterGoodInfo *)sharedInstance;

@end
