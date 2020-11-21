//
//  AddrDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface AddrDTO : BaseDTO

//"addr":{"uid":4,"zipCode":"210000","isDefault":false,"phone":null,"street":"山西路68号27FAB座","contact":"周墨宣","mobile":"15301598286","pid":16,"id":17,"region":"江苏-南京-鼓楼区","did":1835,"cid":220},
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger pid;
@property (nonatomic) NSInteger did;
@property (nonatomic) NSInteger cid;
@property (nonatomic) BOOL isDefault;
@property (nonatomic, copy) NSString* zipCode;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* street;
@property (nonatomic, copy) NSString* contact;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* region;

@property (nonatomic, readonly) NSString* address;

@end
