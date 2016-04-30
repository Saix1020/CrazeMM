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
#define HOSTNAME @"b.189mm.com"

#define COMB_URL_ALL(path, params)     [NSString stringWithFormat:@"%@%@%@%@%@", SCHEME, HOSTNAME, (path), (params).length>0?@"?" : @"", (params)]
#define COMB_URL(path) COMB_URL_ALL(path, @"")
#define LOGIN_METHORD @"POST"
#define LOGIN_PATH @"/rest/user/login"

#define GET_TOKEN_METHOD @"GET"
#define GET_TOKEN_PATH @"/rest/token"
#define GET_TOKEN_PARAMS @"name=login_token"
#define GET_TOKEN_FULL_URL COMB_URL_ALL(GET_TOKEN_PATH,GET_TOKEN_PARAMS)

#define RANDOM_DATA_PATH @"/ui/random_code"
#define CHECK_PIC_CAPTACHA_PATH @"/rest/checkPictureCaptcha"
#define GEN_MOBILE_VCODE_PATH @"/rest/genMobileVcode"



#endif /* HttpRequestURL_h */
