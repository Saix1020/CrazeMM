//
//  BaseHttpRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    AF_OPERATION_POST_MM,
    AF_OPERATION_GET_MM,
    AF_OPERATION_PATCH_MM,
    AF_OPERATION_DELETE_MM,
    AF_OPERATION_HEAD_MM,
    AF_OPERATION_PUT_MM
} AF_OPERATION_KIND_MM;


typedef void(^httpRequestCallback)(id ,AFHTTPRequestOperation*);

#import "AFNetWorking.h"
#import "NSDictionary+HttpHelp.h"




@interface BaseHttpRequest : NSObject
@property (nonatomic) BOOL needToken;
@property (nonatomic, copy) NSString* token;
@property (nonatomic, copy) NSString* method;
@property (nonatomic, readonly) AF_OPERATION_KIND_MM operator;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) NSDictionary* params;

-(AFPromise*)request;
@end

