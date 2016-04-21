//
//  LoginViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "LoginViewController.h"
#import "BEMCheckBox.h"

#define kLeadingPad 16.f
#define kTailingPad 16.f


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet BEMCheckBox *rememberMeCheckBox;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UILabel *wechartLabel;
@property (weak, nonatomic) IBOutlet UIButton *wechartButton;

@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIView *line3;

@end

@implementation LoginViewController

-(void)initLines
{
    self.line1 = [[self class] createLine];
    self.line2 = [[self class] createLine];
    self.line3 = [[self class] createLine];
    
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
}

+(UIView*)createLine
{
    UIView* line = [[UIView alloc] init];
    line.layer.borderColor = RGBCOLOR(200, 200, 200).CGColor;
    line.layer.borderWidth = .25f;
    
    return line;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLines];
    
    [self.wechartButton sizeToFit];
    self.wechartButton.userInteractionEnabled = NO;
    [self.registerButton sizeToFit];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGFloat maxWidth = bounds.size.width - kLeadingPad - kTailingPad;
    CGFloat y = 24.f;
    self.logoImage.frame = CGRectMake((bounds.size.width-self.logoImage.frame.size.width)/2,
                                      y, self.logoImage.frame.size.width, self.logoImage.frame.size.height);
    
    
    self.wechartLabel.frame = CGRectMake(kLeadingPad, bounds.size.height-40, maxWidth, 30);
    self.wechartButton.center = CGPointMake(bounds.size.width/2, self.wechartLabel.frame.origin.y-self.wechartButton.frame.size.height/2);
    
    
    self.loginButton.frame = CGRectMake(kLeadingPad, bounds.size.height/2, maxWidth, 40);
    
    self.passwordField.frame = CGRectMake(kLeadingPad, self.loginButton.frame.origin.y-40, maxWidth, 30);
    self.userNameField.frame = CGRectMake(kLeadingPad, self.passwordField.frame.origin.y-40, maxWidth, 30);
    
    self.rememberMeCheckBox.frame = CGRectMake(kLeadingPad, CGRectGetMaxY(self.loginButton.frame)+.8f, maxWidth/2, 20);
    self.registerButton.frame = CGRectMake(bounds.size.width-kTailingPad-self.registerButton.frame.size.width, self.rememberMeCheckBox.frame.origin.y, self.registerButton.frame.size.width, 20);
}



@end
