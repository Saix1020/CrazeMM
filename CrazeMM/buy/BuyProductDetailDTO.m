//
//  BuyProductDetailDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyProductDetailDTO.h"

@implementation BuyProductDetailDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        if (dict[@"addr"]) {
            self.addrDto = [[AddrDTO alloc] initWith:dict[@"addr"]];
            if(IsNilOrNull(self.region) || self.region.length==0){
                self.region = [NSString stringWithFormat:@"%@ %@", self.addrDto.region, self.addrDto.street];
            }
        }
    }
    return self;
}
@end
