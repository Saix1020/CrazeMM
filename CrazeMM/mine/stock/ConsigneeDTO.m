//
//  ConsigneeDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ConsigneeDTO.h"
@implementation ConsigneeDTO

//@property (nonatomic) NSInteger uid;
//@property (nonatomic) BOOL deleted;
//
//@property (nonatomic, copy) NSString* createTime;
//@property (nonatomic, copy) NSString* identity;
//@property (nonatomic, copy) NSString* name;
//@property (nonatomic, copy) NSString* mobile;

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.uid = [dict[@"uid"] integerValue];
        self.deleted = [dict[@"deleted"] boolValue];
        
        self.createTime = dict[@"createTime"];
        self.identity = dict[@"identity"];
        self.name = dict[@"name"];
        self.mobile = dict[@"mobile"];
    }
    
    return self;
}


@end
