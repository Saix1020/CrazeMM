//
//  HttpAddress.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "AddressDTO.h"
#import "AddrDTO.h"

@interface HttpAddressRequest : BaseHttpRequest

@end

@interface HttpAddressResponse : BaseHttpResponse

@property (nonatomic, readonly) NSArray* addr;
@property (nonatomic, strong) NSMutableArray* addresses;

@end

@interface HttpAddressDetailRequest : BaseHttpRequest

@end
@interface HttpAddressDetailResponse : BaseHttpResponse

@property (nonatomic, readonly) NSArray* addr;
@property (nonatomic, strong) NSMutableArray* addresses;

@end

@interface HttpAddressSaveRequest : BaseHttpRequest

-(instancetype)initWithAddrDto:(AddrDTO*)addrDto;

@end
