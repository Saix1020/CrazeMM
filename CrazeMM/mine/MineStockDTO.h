//
//  MineStockDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseProductDTO.h"
#import "DepotDTO.h"
#import "MineSupplyProductDTO.h"

@interface MineStockDTO : MineSupplyProductDTO
@property (nonatomic, strong) DepotDTO* depotDto;

@end
