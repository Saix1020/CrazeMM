//
//  HttpGenEmailVcode.h
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGenEmailVcodeRequest : BaseHttpRequest

@property (nonatomic, copy) NSString* email;

-(instancetype)initWithEmail:(NSString*)email;

@end

@interface HttpGenEmailVcodeResponse : BaseHttpResponse

@property (nonatomic, readonly) NSInteger lessTimes;
@property (nonatomic, readonly) NSInteger seq;


@end

@interface HttpEmailExistCheckRequest : BaseHttpRequest
@property (nonatomic, copy) NSString* email;

-(instancetype)initWithEmail:(NSString*)email;

@end

@interface HttpEmailExistCheckResponse : BaseHttpResponse

@end
