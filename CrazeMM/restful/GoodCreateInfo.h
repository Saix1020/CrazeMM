//
//  GoodCreateInfo.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodDTO.h"
#import "AddressDTO.h"

// TODO !!

@interface GoodCreateInfo : BaseDTO

@property (nonatomic) NSInteger depotId;
@property (nonatomic) NSInteger brand;
@property (nonatomic) NSString* brandName;
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

@property (nonatomic, strong) NSDictionary* stockInfo;
@property (nonatomic, readonly) BOOL isStockedGood;
@property (nonatomic, readonly) NSInteger presale;
@property (nonatomic) NSInteger state;

@property (nonatomic) NSDictionary* addtionalInfo;
//-(instancetype)initWithDict


@property (nonatomic, strong) GoodInfoDTO* brandInfo;
@property (nonatomic) NSInteger addrId;

// for modify
@property (nonatomic) NSInteger lid;
@property (nonatomic) NSInteger version;

// for buy good create
@property (nonatomic, strong) AddressDTO* addr;
@property (nonatomic, strong) NSMutableArray* addrList;
@property (nonatomic, strong) NSDictionary* userDto;


@end

@interface SupplyGoodCreateDto : GoodCreateInfo

@end

@interface BuyGoodCreateDto : GoodCreateInfo

//@property (nonatomic) NSInteger addrId;



@end