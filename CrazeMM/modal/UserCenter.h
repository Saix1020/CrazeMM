//
//  UserCenter.h
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    eUserUnLogin,         //用户未登录
    eLoginByPhoneUnBound, //手机登录、手机未绑定、易付宝未激活
    eLoginByEmailUnBound, //邮箱登录、邮箱未激活、手机位激活、易付宝未激活
    eLoginByEmailPhoneUnBound, //邮箱登录、邮箱已激活、手机未激活、易付宝未激活
    eLoginByPhoneUnActive,//手机登录、手机已绑定、易付宝未激活
    eLoginByEmailUnActive,//邮箱登录、邮箱已激活、手机已激活、易付宝未绑定
    eLoginByPhoneActive,  //手机登录、手机已绑定、易付宝已激活
    eLoginByEmailActive   //邮箱登录、邮箱已绑定、易付宝已激活
    
}eEfubaoStatus;

@interface UserCenter : NSObject

@property (nonatomic, readonly) BOOL isLogined;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, readonly) NSString* userNameInKeychain;
@property (nonatomic, readonly) NSString* passwordInKeychain;
@property (nonatomic, readonly) BOOL accountSaved;
@property (nonatomic, copy) NSString* cookie;
@property (nonatomic) BOOL isFakeLogouted;



+ (UserCenter *)defaultCenter;
//
-(void)setLogined;
-(void)setLogouted;
-(void)setFakeLogouted;



-(void)saveToKeychainWithUserName:(NSString*)user andPassword:(NSString*)password;
//-(NSString*)getUserFromKeychain;
//-(NSString*)getPasswordFromKeychain;
-(void)resetKeychainItem;
@end
