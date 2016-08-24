//
//  BaseHttpRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking+PromiseKit.h"
#import "NSDictionary+HttpHelp.h"
#import "RestURL.h"

typedef void(^httpRequestCallback)(id ,AFHTTPSessionManager*);
typedef void (^errorCallback)(NSError *error);

#define kHttpChallenge @"189MM-NeedLogin"

@class BaseHttpResponse;

@interface BaseHttpRequest : NSObject

@property (nonatomic) BOOL needToken;
@property (nonatomic, copy) NSString* method;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) NSMutableDictionary* params;
@property (nonatomic, readonly) NSString* tokenName;
@property (nonatomic, strong) BaseHttpResponse* response;
@property (nonatomic, strong) AFHTTPSessionManager* manager;

@property (nonatomic, weak) UIViewController* caller;
-(Class)responseClass;

-(AFPromise*)request;
-(AFPromise*)request2;
-(AFPromise*)requestWithErrorCallback:(errorCallback)callback;


-(AFPromise*)requestWithAcceptContentTypes:(NSSet*)AcceptContentTypes;

+(AFPromise*)httpRequestError:(NSString*)errorString;



@end

@interface BaseHttpResponse : NSObject



@property (nonatomic, readonly) BOOL ok;
@property (nonatomic, readonly) NSString* errorTitle;
@property (nonatomic, readonly) NSString* errorMsg;
@property (nonatomic, readonly) NSDictionary* data;
@property (nonatomic, readonly) NSString* errorDetail;
@property (nonatomic, strong) NSDictionary* all;

-(instancetype)initWith:(NSDictionary*)response;
-(void)parserResponse;

//-(instancetype)initWith:(NSDictionary*)response;

@end
