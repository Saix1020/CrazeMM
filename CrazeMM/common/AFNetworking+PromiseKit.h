//
//  AFNetworking+PromiseKit.h
//  CrazeMM
//
//  Created by saix on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AFNetWorking.h"
#import <PromiseKit/PromiseKit.h>


#define AFPromise AnyPromise
FOUNDATION_EXPORT const NSString *AFHTTPRequestOperationErrorKey;


#define kPMKAFResponseObjectKey @"responseObject"
#define kPMKAFResponseTaskKey @"task"
#define kPMKAFResponseOperationKey @"operation"


@interface NSURLSessionDataTask (Promises)

- (AFPromise *)promise;

/**
 @brief Returns a new Promise with a ready to use AFHTTPRequestOperation inside. The operation will immediately start
 */
- (AFPromise *)promiseAndStartImmediately;


/**
 @brief Returns a new Promise with a ready to use AFHTTPRequestOperation inside
 
 If 'startImmediately is 'YES' then the operation will start immediately
 */
- (AFPromise *)promiseByStartingImmediately:(BOOL)startImmediately;
@end



@interface AFHTTPSessionManager (Promises)

- (AFPromise *)GET:(NSString *)URLString parameters:(id)parameters;
- (AFPromise *)POST:(NSString *)URLString parameters:(id)parameters;
- (AFPromise *)PUT:(NSString *)URLString parameters:(id)parameters;
- (AFPromise *)DELETE:(NSString *)URLString parameters:(id)parameters;
- (AFPromise *)HEAD:(NSString *)URLString parameters:(id)parameters;



@end
