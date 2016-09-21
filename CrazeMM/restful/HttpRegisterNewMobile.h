//
//  HttpRegisterNewMobile.h
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpRegisterNewMobileRequest : BaseHttpRequest

-(instancetype)initWithNewMobile:(NSString*)newMobile andCaptchaMobileNew:(NSString*)captchaMobileNew andCaptchaMobileOrignal:(NSString*)captchaMobileOrignal;

@end

@interface HttpUpdateMobileRequest : BaseHttpRequest

-(instancetype)initWithNewMobile:(NSString*)newMobile andCaptchaMobileNew:(NSString*)captchaMobileNew andCaptchaMobileOrignal:(NSString*)captchaMobileOrignal;

@end