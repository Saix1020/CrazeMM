//
//  UserCenter.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UserCenter.h"

#define kIdentifier @"189MMKeyChainIdentifier"
//#define kAccessGroup @"sai.xu.com.citrix.189MM"
#define kUserAndPassword @"189MM-UserAndPassword"

@interface UserCenter()

@property (nonatomic) BOOL isLogined;
@property (nonatomic, strong) KeychainItemWrapper* keyChainWrapper;
@end

@implementation UserCenter

static UserCenter *defaultUserCenter = nil;

+ (UserCenter *)defaultCenter
{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[UserCenter alloc] init];
        }
    }
    return defaultUserCenter;
}

-(void)setLogined
{
    [UserCenter defaultCenter].isLogined = true;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessBroadCast
                                                        object:self];
    self.isFakeLogouted = NO;

}

-(void)setLogouted
{
    [UserCenter defaultCenter].isLogined = false;
    [[UserCenter defaultCenter] resetKeychainItem];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessBroadCast
                                                        object:self];
    self.isFakeLogouted = NO;
}

-(void)setFakeLogouted
{
    [UserCenter defaultCenter].isLogined = false;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessBroadCast
                                                        object:self];
    self.isFakeLogouted = YES;
}

-(KeychainItemWrapper*)keyChainWrapper
{
    if (!_keyChainWrapper) {
        _keyChainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kIdentifier accessGroup:nil];

    }
    return _keyChainWrapper;
}

-(void)saveToKeychainWithUserName:(NSString*)user andPassword:(NSString*)password
{
    [self.keyChainWrapper resetKeychainItem];
    [self.keyChainWrapper setObject:user forKey:(id)kSecAttrAccount];
    [self.keyChainWrapper setObject:password forKey:(id)kSecValueData];
}

//-(void)setCookie:(NSString *)cookie
//{
//    //[self.keyChainWrapper setObject:cookie forKey:(id)kSecValueData];
//    _cookie = cookie;
//}
//
//-(NSString*)cookie
//{
//    //[self.keyChainWrapper setObject:cookie forKey:(id)kSecValueData];
//}

-(NSString*)userNameInKeychain
{
    return [self.keyChainWrapper  objectForKey:(id)kSecAttrAccount];
}

-(NSString*)passwordInKeychain
{
    return [self.keyChainWrapper objectForKey:(id)kSecValueData];
}

-(void)resetKeychainItem
{
    [self.keyChainWrapper resetKeychainItem];
}

-(BOOL)accountSaved
{
    NSString* user = [self userNameInKeychain];
    NSString* password = [self passwordInKeychain];
    
    return (user && password && user.length!=0 && password.length!=0);
}


@end
