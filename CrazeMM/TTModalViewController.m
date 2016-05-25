//
//  TTModalViewController.m
//  Pods
//
//  Created by titengjiang on 16/3/10.
//
//

#import "TTModalViewController.h"

@interface TTModalViewController ()

@end

@implementation TTModalViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark status bar style
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return [[UIApplication sharedApplication] statusBarStyle];
}

/**
 *  It is very important , if not the new window will make the statusbar hidden
 *
 *  @return 
 */
-(BOOL)prefersStatusBarHidden
{
    
    return [[UIApplication sharedApplication] isStatusBarHidden];
}



@end
