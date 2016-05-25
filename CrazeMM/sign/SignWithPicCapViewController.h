//
//  SignWithPicCapViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignWithPicCapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *pictureCaptchaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *picCapTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCheckTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextPicButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *finishSignupButton;

@end
