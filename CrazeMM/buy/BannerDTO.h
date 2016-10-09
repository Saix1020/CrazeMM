//
//  BannerDTO.h
//  CrazeMM
//
//  Created by saix on 16/10/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface BannerDTO : BaseDTO<NSCoding>

@property (nonatomic, copy) NSString* createTime;
@property (nonatomic) BOOL disabled;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* bgColor;
@property (nonatomic) NSUInteger location;
@property (nonatomic) NSUInteger orderNum;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* desc;

@property (nonatomic, copy) NSData* data;

@end
