//
//  HttpAddress.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "AddressDTO.h"

@interface HttpAddressRequest : BaseHttpRequest

@end

@interface HttpAddressResponse : BaseHttpResponse

@property (nonatomic, readonly) NSArray* addr;
@property (nonatomic, strong) NSMutableArray* addresses;

@end
