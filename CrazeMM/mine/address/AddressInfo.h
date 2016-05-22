//
//  AddressInfo.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfo : NSObject <NSCoding>

@property (nonatomic, assign) BOOL state;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *zipCode;

@end
