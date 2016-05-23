//
//  AddressDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface AddressDTO : BaseDTO


//{"ok":true,"addr":[{"street":"测试地址#12345","contact":"sai","mobile":"18652072345","id":175,"region":"北京-北京-东城区"}]}


@property (nonatomic, copy) NSString* street;
@property (nonatomic, copy) NSString* contact;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* region;
@property (nonatomic, readonly) NSString* address;


@end

//{"ok":true,"addr":[{"zipCode":"200000","applied":true,"mobile":"18652072345","pid":2,"uid":366,"isDefault":false,"deleted":false,"phone":"01088786545","street":"测试地址#12345","contact":"sai","id":175,"region":"北京-北京-东城区","did":500,"cid":52}]}
//@interface AddressDetailDTO : AddressDTO
//
//@property (nonatomic) BOOL applied;
//@property (nonatomic) NSInteger pid;
//@property (nonatomic) NSInteger uid;
//@property (nonatomic) NSInteger did;
//@property (nonatomic) NSInteger cid;
//@property (nonatomic) BOOL deleted;
//@property (nonatomic, copy) NSString* phone;
//@property (nonatomic) BOOL isDefault;
//@property (nonatomic, copy) NSString* zipCode;
//
//@end
