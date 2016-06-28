//
//  HttpConsignee.h
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "ConsigneeDTO.h"

@interface HttpConsigneeRequest : BaseHttpRequest

@end

@interface HttpConsigneeResponse : BaseHttpResponse

@property (nonatomic, readonly) NSDictionary* consignee;
@property (nonatomic, strong) NSMutableArray* consigneeDtos;

@end

//consignee.name:xs
//consignee.identity:321181198210200410
//consignee.mobile:18652072429

@interface HttpSaveConsigneeRequest : BaseHttpRequest

-(instancetype)initWithName:(NSString*)name andIdentity:(NSString*)identity andMobile:(NSString*)mobile;

@end