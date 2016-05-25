//
//  HttpCheckPictureCaptchaRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpCheckPictureCaptchaRequest.h"

@implementation HttpCheckPictureCaptchaRequest

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.params =  [@{} mutableCopy];;
        
    }
    
    return self;
}


-(instancetype)initWithPicCaptacha:(NSString*)picCaptachaser
{
    self = [self init];
    
    if (self) {
        
        self.params =  [@{
                          @"pictureCaptcha" : picCaptachaser, 
                        } mutableCopy];
        
    }
    
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(CHECK_PIC_CAPTACHA_PATH);
}

-(NSString*)method
{
    return @"POST";
}

@end
