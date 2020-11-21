//
//  NewWelcomeViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NewWelcomeViewController.h"
#import "HttpLoginRequest.h"
#import "HttpUserInfo.h"

@interface NewWelcomeViewController ()

@end

@implementation NewWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString* user = [UserCenter defaultCenter].userNameInKeychain;
    NSString* password = [UserCenter defaultCenter].passwordInKeychain;
    

    if ([UserCenter defaultCenter].accountSaved) {
        [self showProgressIndicatorWithTitle:@"正在登陆, 请稍等...."];
        HttpLoginRequest* request = [[HttpLoginRequest alloc] initWithUser:user andPassword:password andRemember:YES];
        [request login].then(^(id response){
            [self dismissProgressIndicator];
            request.response = [[HttpLoginResponse alloc] initWith:response];
            
            if (request.response.ok) {
                [sharedApplicationDelegate() getGlobSharedInstances];
                [[UserCenter defaultCenter] setLogined];
//                HttpUserInfoRequest* userInfoRequest = [[HttpUserInfoRequest alloc] init];
//                [userInfoRequest request]
//                .then(^(id responseObj){
//                    NSLog(@"%@", responseObj);
//                    if (request.response.ok) {
//                        HttpUserInfoResponse* userInfoResponse = (HttpUserInfoResponse*)request.response;
//                        [UserCenter defaultCenter].userInfoDto = userInfoResponse.mineUserInfoDto;
//                    }
//                });
            }
            
            [self presentTabBarController];

        }).catch(^(NSError *error){
            NSLog(@"error happened: %@", error.localizedDescription);
            NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
            // TODO should we reset the user and password from keychain?
            [self dismissProgressIndicator];
            [self presentTabBarController];
        });
    }
    else {
        //[self presentTabBarController];
    }
}

-(void)presentTabBarController
{
    self.tabBarController = [[TabBarController alloc] init];
    self.tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.tabBarController setSelectedIndex:0];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:self.tabBarController animated:YES completion:nil];
        });
        
    });
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![UserCenter defaultCenter].accountSaved) {
        self.tabBarController = [[TabBarController alloc] init];
        self.tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.tabBarController animated:YES completion:nil];
    }
}

@end
