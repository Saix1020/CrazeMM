//
//  RegionDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface RegionDTO : BaseDTO
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSMutableArray* cities;
@end


@interface AreaDTO : BaseDTO
@property (nonatomic, copy) NSString* name;
@end

@interface CityDTO : BaseDTO

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSMutableArray* areas;


@end