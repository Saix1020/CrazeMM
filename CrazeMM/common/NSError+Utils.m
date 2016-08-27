//
//  NSError+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSError+Utils.h"

@implementation NSError (Utils)

-(BOOL)needLogin
{
    NSURLSessionTask* request = self.userInfo[AFHTTPRequestOperationErrorKey];
    if (request) {
        NSHTTPURLResponse* response = (NSHTTPURLResponse*)request.response;
        if (response.statusCode == 401 && (response.allHeaderFields[@"login"] && [response.allHeaderFields[@"login"] isEqualToString:@"unLogin"])) {
            return YES;
        }
    }
    return NO;
}

@end
