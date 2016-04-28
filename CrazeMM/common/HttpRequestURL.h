//
//  HttpRequestURL.h
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#ifndef HttpRequestURL_h
#define HttpRequestURL_h

#define SCHEME @"http://"
#define HOSTNAME @"localhost"

#define COMB_URL(path)     [NSString stringWithFormat:@"%@%@%@", SCHEME, HOSTNAME, (path)]
#define LOGIN_METHORD @"POST"
#define LOGIN_PATH @"/rest/user/login"




#endif /* HttpRequestURL_h */
