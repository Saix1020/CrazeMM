//
//  PayRecordDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/8/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

//{"total":".00","feedback":null,"id":34,"createTime":"2016-05-09 00:06:57","payNo":160509003990124,"procSuc":true,"isSuc":false,"state":"100","buid":4,"orderIds":"订单已删除","type":0,"endTime":null,"msg":"暂无信息"},

@interface PayRecordDTO : BaseListDTO

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

@end
