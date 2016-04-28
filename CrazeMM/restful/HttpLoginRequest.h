//
//  HttpLoginRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpLoginRequest : BaseHttpRequest

-(AFPromise*)login;

@end
