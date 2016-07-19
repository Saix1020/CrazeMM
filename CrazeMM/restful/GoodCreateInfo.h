//
//  GoodCreateInfo.h
//  CrazeMM
//
//  Created by saix on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodCreateInfo : NSObject


@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger depotId;

@property (nonatomic) NSInteger brand;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger deadline;
@property (nonatomic) NSInteger duration;
@property (nonatomic) CGFloat price;

@property (nonatomic, copy) NSString* color;
@property (nonatomic, copy) NSString* volume;
@property (nonatomic, copy) NSString* network;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isBrushMachine; //
@property (nonatomic) BOOL isSplit;
@property (nonatomic) BOOL isAnoy;
@property (nonatomic) NSInteger addrId;


@end
