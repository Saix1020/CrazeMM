//
//  BuyProductDetailDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseProductDetailDTO.h"
#import "AddrDTO.h"

@interface BuyProductDetailDTO : BaseProductDetailDTO

@property (nonatomic, strong) AddrDTO* addrDto;

@end
