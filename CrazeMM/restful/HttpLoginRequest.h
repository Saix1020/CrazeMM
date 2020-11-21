//
//  HttpLoginRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
@class HttpLoginResponse;
@interface HttpLoginRequest : BaseHttpRequest

@property (nonatomic, copy) NSString* user;
@property (nonatomic, copy) NSString* password;
@property (nonatomic) BOOL remember;

-(AFPromise*)login;

-(instancetype)initWithUser:(NSString*)user andPassword:(NSString*)password andRemember:(BOOL)remember;

@end


@interface HttpLoginResponse : BaseHttpResponse

@end