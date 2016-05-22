//
//  AddressDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface AddressDTO : BaseDTO

//{"ok":true,"addr":[{"street":"山西路68号27FAB座","contact":"周墨宣","mobile":"15301598286","id":17,"region":"江苏-南京-鼓楼区"},{"street":"天润城64-102","contact":"周墨宣","mobile":"15301598286","id":16,"region":"江苏-南京-玄武区"}]}

@property (nonatomic, copy) NSString* street;
@property (nonatomic, copy) NSString* contact;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* region;
//@property (nonatomic, copy) NSString* zipCode;



@end
