//
//  NSError+Utils.m
//  CrazeMM
//
//  Created by saix on 16/5/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSError+Utils.h"

@implementation NSError (Utils)

-(BOOL)needLogin
{
    AFHTTPRequestOperation* request = self.userInfo[AFHTTPRequestOperationErrorKey];
    if (request) {
        NSHTTPURLResponse* response = request.response;
        if (response.statusCode == 401 && (response.allHeaderFields[@"login"] && [response.allHeaderFields[@"login"] isEqualToString:@"unLogin"])) {
            return YES;
        }
    }
    return NO;
}

@end
