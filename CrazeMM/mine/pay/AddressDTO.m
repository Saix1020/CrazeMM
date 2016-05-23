//
//  AddressDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressDTO.h"

@implementation AddressDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.street = dict[@"street"];
        self.region = dict[@"region"];
        self.mobile = dict[@"mobile"];
        self.contact = dict[@"contact"];
    }
    
    return self;
}


-(NSString*)address{
    return [NSString stringWithFormat:@"%@ %@",self.region, self.street];
}

@end

//@implementation AddressDetailDTO
//
////@property (nonatomic) BOOL applied;
////@property (nonatomic) NSInteger pid;
////@property (nonatomic) NSInteger uid;
////@property (nonatomic) NSInteger did;
////@property (nonatomic) NSInteger cid;
////@property (nonatomic) BOOL deleted;
////@property (nonatomic, copy) NSString* phone;
////@property (nonatomic) BOOL isDefault;
////@property (nonatomic, copy) NSString* zipCode;
//
//
//-(instancetype)initWith:(NSDictionary *)dict
//{
//    self = [super initWith:dict];
//    if (self) {
//        self.zipCode = dict[@"zipCode"];
//        self.applied = [dict[@"applied"] boolValue];
//        self.pid = [dict[@"pid"] integerValue];
//        self.uid = [dict[@"pid"] integerValue];
//        self.did = [dict[@"pid"] integerValue];
//        self.cid = [dict[@"pid"] integerValue];
//        self.deleted = [dict[@"deleted"] boolValue];
//        self.isDefault = [dict[@"isDefault"] boolValue];
//        self.phone = dict[@"phone"];
//
//    }
//    
//    return self;
//}
//
//@end
