//
//  MineWrapViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineWrapViewController.h"
#import "MineNoLoginViewController.h"
#import "MineViewController.h"


@interface MineWrapViewController ()

@property (nonatomic, strong) MineNoLoginViewController* nologinMineVC;
@property (nonatomic, strong) MineViewController* mineVC;

@property (nonatomic, strong) UIViewController* currentVC;

@end

@implementation MineWrapViewController

-(MineNoLoginViewController*)nologinMineVC
{
    if (!_nologinMineVC) {
        _nologinMineVC = [[MineNoLoginViewController alloc] init];
        
        [self addChildViewController:_nologinMineVC];
    }
    
    return _nologinMineVC;
}

-(MineViewController*)mineVC
{
    if (!_mineVC) {
        _mineVC = [[MineViewController alloc] init];
        
        [self addChildViewController:_mineVC];
    }
    
    return _mineVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mineVC.view];
    [self.view addSubview:self.nologinMineVC.view];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    
    
    self.currentVC = self.mineVC;
    [self.mineVC didMoveToParentViewController:self];

}

-(void)logout
{
    [[UserCenter defaultCenter] resetKeychainItem];
    [[UserCenter defaultCenter] setLogouted];
    
    //    UIViewController* parentVC = self.parentViewController;
    
    [self transitionFromViewController:self.mineVC  toViewController:self.nologinMineVC duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
    }  completion:^(BOOL finished) {
    }];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (![UserCenter defaultCenter].isLogined) {
        //[self.mineVC didMoveToParentViewController:self];
        
        if (self.currentVC != self.nologinMineVC) {
            [self transitionFromViewController:self.currentVC
                              toViewController:self.nologinMineVC
                                      duration:0
                                       options:UIViewAnimationOptionTransitionFlipFromLeft
                                    animations:^{
            }  completion:^(BOOL finished) {
            }];
        }

        

//        self.mineVC.tableView.frame = self.view.bounds;
//        self.mineVC.tableView.y = self.navigationController.navigationBar.bottom;
    }
    else {
        [self.nologinMineVC didMoveToParentViewController:self];
//        self.nologinMineVC.tableView.frame = self.view.bounds;
//        self.nologinMineVC.tableView.y = self.navigationController.navigationBar.bottom;
    }
}


@end
