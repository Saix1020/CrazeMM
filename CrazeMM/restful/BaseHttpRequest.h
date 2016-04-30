//
//  BaseHttpRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetWorking/AFNetWorking.h>
#import "NSDictionary+HttpHelp.h"
#import <PromiseKit_AFNetworking/AFNetworking+PromiseKit.h>
#import "RestURL.h"
typedef void(^httpRequestCallback)(id ,AFHTTPRequestOperation*);

@class BaseHttpResponse;

@interface BaseHttpRequest : NSObject

@property (nonatomic) BOOL needToken;
@property (nonatomic, copy) NSString* method;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) NSMutableDictionary* params;
@property (nonatomic, readonly) NSString* tokenName;
@property (nonatomic, strong) BaseHttpResponse* response;

-(AFPromise*)request;
-(AFPromise*)request2;

-(AFPromise*)requestWithAcceptContentTypes:(NSSet*)AcceptContentTypes;
@end

@interface BaseHttpResponse : NSObject

-(instancetype)initWith:(NSDictionary*)response;


@property (nonatomic, readonly) BOOL ok;
@property (nonatomic, readonly) NSString* errorTitle;
@property (nonatomic, readonly) NSString* errorMsg;
@property (nonatomic, readonly) NSDictionary* data;
@property (nonatomic, readonly) NSString* errorDetail;
@property (nonatomic, strong) NSDictionary* all;

//-(instancetype)initWith:(NSDictionary*)response;

@end
