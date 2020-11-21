//
//  MineSupplyProductDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseProductDTO.h"

@interface MineSupplyProductDTO : BaseProductDTO
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger mortgageId;
@end

@interface MineBuyProductDTO : MineSupplyProductDTO


@end
