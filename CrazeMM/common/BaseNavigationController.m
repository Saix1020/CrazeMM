//
//  BaseNavigationController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // check if need to auth
    
    if (self.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        viewController.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
}



@end
