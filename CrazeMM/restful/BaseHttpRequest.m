//
//  BaseHttpRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface BaseHttpRequest ()

@property (nonatomic, readonly) AFHTTPRequestOperationManager *manager;

@end


@implementation BaseHttpRequest

-(AFHTTPRequestOperationManager*)manager
{
    return [AFHTTPRequestOperationManager manager];
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.params =  [@{} mutableCopy];;
        
    }
    
    return self;
}

-(NSMutableDictionary*)getTokenParams
{
    return [@{@"name": self.tokenName} mutableCopy];
}

-(Class)responseClass
{
    return [BaseHttpResponse class];
}

-(NSString*)tokenName
{
    return @"invalid_token_name";
}

-(AFPromise*)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (self.needToken) {
        return [manager GET:COMB_URL(GET_TOKEN_PATH) parameters:[self getTokenParams]]
        .then(^(id responseObject, AFHTTPRequestOperation *operation){
            NSLog(@"%@", responseObject);
            
            self.response = responseObject;
            
            if (!self.response.ok) {
                return responseObject;
            }
            else {
                NSMutableDictionary* paramsWithToken = [[NSMutableDictionary alloc] initWithDictionary:self.params];
                [paramsWithToken setObject:responseObject[self.tokenName] forKey:@"login_token"];
                SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:parameters:", self.method.uppercaseString]);
                if ([manager respondsToSelector:selector]) {
                    return [manager performSelector:selector withObject:self.url withObject:paramsWithToken];
                }
                else {
                    return responseObject;
                }
            }
            
        });

    }
    else {
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:parameters:", self.method.uppercaseString]);
        if ([manager respondsToSelector:selector]) {
            return [manager performSelector:selector withObject:self.url withObject:self.params];
        }
        else {
            return nil;
        }
    }
    
    return nil;
}

-(AFPromise*)request2
{
    if (self.needToken) {
        
        return [self getTokenThenDoRequest];
    }
    else {
        [self.params removeObjectForKey:self.tokenName];
        return [self doResqust];
    }
    
    return nil;
}

//-(AFPromise*)requestWithAcceptContentTypes:(NSSet*)AcceptContentTypes andReponse

-(AFPromise*)requestWithAcceptContentTypes:(NSSet*)AcceptContentTypes
{
    
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.url] sessionConfiguration:configuration];

//    AFHTTPResponseSerializer           二进制格式
//    AFJSONResponseSerializer           JSON
//    AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
//    AFXMLDocumentResponseSerializer (Mac OS X)
//    AFPropertyListResponseSerializer   PList
//    AFImageResponseSerializer          Image
//    AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = AcceptContentTypes;


    return [self doResqustWithSessionManage:manager];
    
//    return [manager GET:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
//        self.response = [[[self responseClass] alloc] initWith:responseObject];
//        return responseObject;
//    });
}

-(AFPromise*)getTokenThenDoRequest
{
    return [self.manager GET:COMB_URL(GET_TOKEN_PATH) parameters:[self getTokenParams]]
    .then(^(id responseObject, AFHTTPRequestOperation *operation){
        if (![responseObject[@"ok"] boolValue]) {
            return [self getTokenFaield:responseObject];
        }
        
        [self.params setObject:responseObject[self.tokenName] forKey:self.tokenName];
        return [self doResqust];
    });
}

-(AFPromise*)getTokenFaield:(id)responseObject
{
    return responseObject;
}

-(AFPromise*)doResqust
{
    if ([self.method.uppercaseString isEqualToString:@"POST"]) {
        return [self doPostRequest];
    }
    else if ([self.method.uppercaseString isEqualToString:@"PUT"]){
        return [self doPutRequst];

    }
    else  if([self.method.uppercaseString isEqualToString:@"DELETE"]){
        return [self doDeleteRequest];
        
    }
    else  if([self.method.uppercaseString isEqualToString:@"HEAD"]){
        return [self doHeadRequest];
        
    }
    else {
        return [self doGetRequest];
    }
}

-(AFPromise*)doPutRequst
{
    return [self.manager PUT:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doPostRequest
{
    return [self.manager POST:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}


-(AFPromise*)doGetRequest
{
    return [self.manager GET:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doDeleteRequest
{
    return [self.manager DELETE:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doHeadRequest
{
    return [self.manager HEAD:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doResqustWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    if ([self.method.uppercaseString isEqualToString:@"POST"]) {
        return [self doPostRequestWithSessionManage:sessionManage];
    }
    else if ([self.method.uppercaseString isEqualToString:@"PUT"]){
        return [self doPutRequstWithSessionManage:sessionManage];
        
    }
    else  if([self.method.uppercaseString isEqualToString:@"DELETE"]){
        return [self doDeleteRequestWithSessionManage:sessionManage];
        
    }
    else  if([self.method.uppercaseString isEqualToString:@"HEAD"]){
        return [self doHeadRequestWithSessionManage:sessionManage];
        
    }
    else {
        return [self doGetRequestWithSessionManage:sessionManage];
    }
}

-(AFPromise*)doPutRequstWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    return [self.manager PUT:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doPostRequestWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    return [self.manager POST:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}


-(AFPromise*)doGetRequestWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    return [sessionManage GET:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doDeleteRequestWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    return [sessionManage DELETE:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}

-(AFPromise*)doHeadRequestWithSessionManage:(AFHTTPSessionManager*)sessionManage
{
    return [sessionManage HEAD:self.url parameters:self.params].then(^(id responseObject, AFHTTPRequestOperation *operation){
        self.response = [[[self responseClass] alloc] initWith:responseObject];
        return responseObject;
    });
}



@end

@implementation BaseHttpResponse

-(instancetype)initWith:(NSDictionary*)response
{
    self = [super init];
    if (self) {
        
        // TODO
        // for some request, its response is not NSDictionary
        self.all = response;
    }
    
    return self;
}


-(NSString*)errorTitle
{
    return @"HTTP Request Failed!";
}

-(NSString*)errorDetail
{
    return nil;
}

-(BOOL)ok
{
    if (!self.all) {
        return NO;
    }
    
    NSString* ok = self.all[@"ok"];
    if (ok) {
        return [ok boolValue];
    }
    else {
        return NO;
    }
}

-(NSString*)errorMsg
{
    if (!self.all) {
        return nil;
    }

    
    NSString* msg = self.all[@"msg"];
    return msg;
}


-(NSDictionary*)data
{
    if (!self.all) {
        return nil;
    }
    
    return self.all[@"data"];
}

@end
