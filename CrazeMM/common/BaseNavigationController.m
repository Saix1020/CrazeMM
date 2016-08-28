//
//  BaseNavigationController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "SignViewController.h"
#import "BuyListViewController.h"
#import "SupplyListViewController.h"
#import "MineViewController.h"


@implementation BaseNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}

+(BOOL)checkIfNeedAuthedViewController:(UIViewController*)viewController
{
    if ([viewController isMemberOfClass:[LoginViewController class]]
        || [viewController isMemberOfClass:[SignViewController class]]
        || [viewController isMemberOfClass:[BuyListViewController class]]
        || [viewController isMemberOfClass:[SupplyListViewController class]]
        || [viewController isMemberOfClass:[MineViewController class]]) {
        return NO;
    }
    else {
        return YES;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([BaseNavigationController checkIfNeedAuthedViewController:viewController] && ![[UserCenter defaultCenter] isLogined]) {
        LoginViewController* loginVC = [[LoginViewController alloc] init];
        loginVC.nextVC = viewController;
        
        [super pushViewController:loginVC animated:animated];
    }
    
    else {
        [super pushViewController:viewController animated:animated];
    }
    
    if (self.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        viewController.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.view endEditing:YES];
            if (self.confirmString.length>0) {
                [self showAlertViewWithMessage:self.confirmString
                                withOKCallback:^(id x) {
                                    [self popViewControllerAnimated:YES];
                                }
                             andCancelCallback:nil];
            }
            else {
                [self popViewControllerAnimated:YES];
            }
            return [RACSignal empty];
        }];
    }
    
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    self.confirmString = nil;
    [self.view endEditing:YES];
    return [super popViewControllerAnimated:animated];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.confirmString = nil;
    [self.view endEditing:YES];

    return [super popToViewController:viewController animated:animated];
}


- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.confirmString = nil;
    [self.view endEditing:YES];

    NSArray* vcs = [super popToRootViewControllerAnimated:animated];
    if (self.nextViewController) {
        [self pushViewController:self.nextViewController animated:YES];
        self.nextViewController = nil;
    }
    
    return vcs;
}

@end
