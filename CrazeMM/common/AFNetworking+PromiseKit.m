//
//  AFNetworking+PromiseKit.m
//  CrazeMM
//
//  Created by saix on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AFNetworking+PromiseKit.h"
const NSString *AFHTTPRequestOperationErrorKey =  @"afHTTPRequestOperationError";
static char AFHTTP_startTasksImmediately_PROPERTY_KEY;

typedef enum {
    AF_OPERATION_POST,
    AF_OPERATION_GET,
    AF_OPERATION_PATCH,
    AF_OPERATION_DELETE,
    AF_OPERATION_HEAD,
    AF_OPERATION_PUT
} AF_OPERATION_KIND;


@implementation NSURLSessionDataTask(Promises)
- (AFPromise *)promise
{
    return [self promiseByStartingImmediately:NO];
}

- (AFPromise *)promiseAndStartImmediately
{
    return [self promiseByStartingImmediately:YES];
}

- (AFPromise *)promiseByStartingImmediately:(BOOL)startImmediately
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        if (startImmediately) {
            [self resume];
        }
    }];
}


@end


@implementation AFHTTPSessionManager (Promises)

- (AFPromise *)GET:(NSString *)URLString parameters:(id)parameters
{
    
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self GET:URLString
       parameters:parameters
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
              resolver(PMKManifold(responseObject, task));
          }
          failure:^(NSURLSessionTask* task, NSError* error){
              id info = error.userInfo.mutableCopy;
              info[AFHTTPRequestOperationErrorKey] = task;
              id newerror = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
              resolver(newerror);
          }];
    }];
}

- (AFPromise *)POST:(NSString *)URLString parameters:(id)parameters
{
    
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self POST:URLString
       parameters:parameters
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
              resolver(PMKManifold(responseObject, task));
          }
          failure:^(NSURLSessionTask* task, NSError* error){
              id info = error.userInfo.mutableCopy;
              info[AFHTTPRequestOperationErrorKey] = task;
              id newerror = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
              resolver(newerror);
          }];
    }];
}
- (AFPromise *)PUT:(NSString *)URLString parameters:(id)parameters
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self PUT:URLString
        parameters:parameters
           success:^(NSURLSessionTask* task, id responseObject){
               resolver(PMKManifold(responseObject, task));
           }
           failure:^(NSURLSessionTask* task, NSError* error){
               id info = error.userInfo.mutableCopy;
               info[AFHTTPRequestOperationErrorKey] = task;
               id newerror = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
               resolver(newerror);
           }];
    }];
}
- (AFPromise *)DELETE:(NSString *)URLString parameters:(id)parameters
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self DELETE:URLString
       parameters:parameters
          success:^(NSURLSessionTask* task, id responseObject){
              resolver(PMKManifold(responseObject, task));
          }
          failure:^(NSURLSessionTask* task, NSError* error){
              id info = error.userInfo.mutableCopy;
              info[AFHTTPRequestOperationErrorKey] = task;
              id newerror = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
              resolver(newerror);
          }];
    }];
}
- (AFPromise *)HEAD:(NSString *)URLString parameters:(id)parameters
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self HEAD:URLString
          parameters:parameters
             success:^(NSURLSessionTask* task){
                 resolver(PMKManifold(nil, task));
             }
             failure:^(NSURLSessionTask* task, NSError* error){
                 id info = error.userInfo.mutableCopy;
                 info[AFHTTPRequestOperationErrorKey] = task;
                 id newerror = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
                 resolver(newerror);
             }];
    }];
}




@end
