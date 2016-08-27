//
//  SupplyDetailDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "BaseProductDetailDTO.h"

//{"afterState":400,"createTime":"2016-06-21 20:05:59","beforeState":100,"id":579,"message":"用户下架供货","newStateLabel":"已下架","sid":1935}


@interface MineSupplyLogDTO : BaseProductLogDTO

@property (nonatomic) NSInteger sid;

@end
//{"deadlineStr":"72小时以上","millisecond":-1,"isSerial":true,"duration":0,"goodName":"步步高-5263 白 4GB 电信版","price":1600.00,"isOriginalBox":true,"id":1935,"state":400,"isBrushMachine":true,"logs":[{"afterState":400,"createTime":"2016-06-21 20:05:59","beforeState":100,"id":579,"message":"用户下架供货","newStateLabel":"已下架","sid":1935},{"afterState":100,"createTime":"2016-06-06 22:24:44","beforeState":0,"id":352,"message":"库存76转手供货保存","newStateLabel":"在售","sid":1935}],"views":5,"isSplit":false,"quantity":10,"active":false,"intentions":3,"message":null,"version":0,"isOriginal":true,"left":10,"createTime":"2016-06-06 22:24:44","isTop":true,"stateLabel":"已下架","region":"不限","user":{"typeName":"个人","id":4,"validateState":300,"username":"xuanxuan"},"isStep":false}
@interface MineSupplyDetailDTO : BaseProductDetailDTO


@end
