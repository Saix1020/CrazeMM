//
//  SupplyViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyViewController.h"

@interface SupplyViewController ()

@end

@implementation SupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的供货 (comming soon)";
    self.view.backgroundColor = [UIColor light_Gray_Color];
    
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}



@end
