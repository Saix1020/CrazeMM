//
//  MortgageInfoDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface MortgageInfoDTO : BaseDTO

@property (nonatomic) NSInteger duration;
@property (nonatomic) CGFloat interestRate;
@property (nonatomic) CGFloat price;
@property (nonatomic, copy) NSString* goodColor;
@property (nonatomic, copy) NSString* goodNetwork;
@property (nonatomic, copy) NSString* goodVolume;

@end
