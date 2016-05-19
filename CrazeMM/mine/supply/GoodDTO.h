//
//  GoodBrandDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface GoodBrandDTO : BaseDTO

@property (nonatomic, copy) NSString* name;

@end



//{"volume":["32G","64G"],"color":["皓月银","钛银灰","流光金","陶瓷白","玫瑰金"],"model":"P9","id":1692,"network":["全网通","电信版","移动版","联通版","全网通高配版"]}
@interface GoodInfoDTO : BaseDTO

@property (nonatomic, copy) NSArray* volume;
@property (nonatomic, copy) NSArray* color;
@property (nonatomic, copy) NSArray* network;
@property (nonatomic, copy) NSString* model;



@end