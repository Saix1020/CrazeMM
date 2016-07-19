//
//  ConsigneeDTO.h
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
//{"consignee":[{"uid":4,"deleted":false,"createTime":"2016-06-27 23:32:17","identity":"321181198210200410","name":"sai","mobile":"18652072427","id":8}],"ok":true}

@interface ConsigneeDTO : BaseDTO
@property (nonatomic) NSInteger uid;
@property (nonatomic) BOOL deleted;

@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* identity;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* mobile;

@end
