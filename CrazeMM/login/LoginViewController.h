//
//  LoginViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestViewController.h"

@interface LoginViewController : UIViewController<SuggestVCDelegate>

@property (nonatomic, strong) UIViewController* fromVC;
@property (nonatomic, strong) UIViewController* nextVC;
@end
