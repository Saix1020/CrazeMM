//
//  PayRecordDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/8/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayRecordDTO.h"

@implementation PayRecordDTO

-(instancetype) initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self)
    {
        /*
         @property (nonatomic, copy) NSString* total;
         @property (nonatomic, copy) NSString* feedback;
         @property (nonatomic, copy) NSString* createTime;
         @property (nonatomic, copy) NSString* orderIds;
         @property (nonatomic, copy) NSString* endTime;
         @property (nonatomic, copy) NSString* msg;
         
         @property (nonatomic) NSInteger payNo;
         @property (nonatomic) NSInteger state;
         @property (nonatomic) NSInteger buid;
         @property (nonatomic) NSInteger type;
         @property (nonatomic) BOOL procSuc;
         @property (nonatomic) BOOL isSuc;
         */
        
        self.total = dict[@"total"];
        self.feedback = dict[@"feedback"];
        self.createTime = dict[@"createTime"];
        self.orderIds = dict[@"orderIds"];
        self.endTime = dict[@"endTime"];
        self.msg = dict[@"msg"];
        self.payNo = [dict[@"payNo"] integerValue];
        self.state = [dict[@"state"] integerValue];
        self.buid = [dict[@"buid"] integerValue];
        self.type = [dict[@"type"] integerValue];
        self.procSuc = [dict[@"procSuc"] boolValue];
        self.isSuc = [dict[@"isSuc"] boolValue];
    }
    return self;
}

@end
