//
//  BaseHttpRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"


@implementation BaseHttpRequest


-(AF_OPERATION_KIND_MM)operation
{
    NSDictionary* dict = @{
                           @"POST" : [NSNumber numberWithInt:AF_OPERATION_POST_MM],
                           @"GET" : [NSNumber numberWithInt:AF_OPERATION_GET_MM],
                           @"PATCH" : [NSNumber numberWithInt:AF_OPERATION_PATCH_MM],
                           @"DELETE" : [NSNumber numberWithInt:AF_OPERATION_DELETE_MM],
                           @"HEAD" : [NSNumber numberWithInt:AF_OPERATION_HEAD_MM],
                           @"PUT" : [NSNumber numberWithInt:AF_OPERATION_PUT_MM]
                           };
    
    return [dict[[self.method uppercaseString]] intValue];
}

+(NSDictionary*)getTokenParams
{
    return @{
             @"name":@"login_token"
             };
}


-(AFPromise*)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (self.needToken && !self.token) {
        return [manager GET:COMB_URL(GET_TOKEN_PATH) parameters:[BaseHttpRequest getTokenParams]]
        .then(^(id responseObject, AFHTTPRequestOperation *operation){
            NSLog(@"%@", responseObject);
            if (!responseObject[@"ok"]) {
                return responseObject;
            }
            else {
                NSMutableDictionary* paramsWithToken = [[NSMutableDictionary alloc] initWithDictionary:self.params];
                [paramsWithToken setObject:responseObject[@"login_token"] forKey:@"login_token"];
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

@end
