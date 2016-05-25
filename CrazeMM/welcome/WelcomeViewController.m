//
//  WelcomeViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WelcomeViewController.h"
#import <LLBootstrapButton/LLBootstrap.h>
#import "TabBarController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.buyButton bs_configureAsDefaultStyle];
    self.buyButton.backgroundColor = [UIColor clearColor];
    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.sellButton bs_configureAsDefaultStyle];
    self.sellButton.backgroundColor = [UIColor clearColor];
    [self.sellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    TabBarController *tabBarController = [[TabBarController alloc] init];
    tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    
    [[self.buyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *buyButton) {
        NSLog(@"Buy clicked");
        
        [tabBarController setSelectedIndex:0];
        
        [self presentViewController:tabBarController animated:YES completion:nil];
        
//        sharedApplicationDelegate().window.rootViewController = tabBarController;
//        [sharedApplicationDelegate().window makeKeyAndVisible];
    }];
    
    [[self.sellButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sellButton) {
        NSLog(@"Sell clicked");
        
//        TabBarController *tabBarController = [[TabBarController alloc] init];
//        tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

        [tabBarController setSelectedIndex:1];
        [self presentViewController:tabBarController animated:YES completion:nil];

//        sharedApplicationDelegate().window.rootViewController = tabBarController;
//        [sharedApplicationDelegate().window makeKeyAndVisible];
    }];
}


@end
