//
//  SignViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SignViewController.h"

#define kLeadingPad 16.f
#define kTailingPad 16.f


@interface SignViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (weak, nonatomic) IBOutlet UILabel *phonePreLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) UIImageView* passwordLeftView;
@property (strong, nonatomic) UIButton* passwordRightView;

@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIView *line3;


@end

@implementation SignViewController

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
    
    self.navigationItem.title = @"手机快速注册";
    
    [self initLines];
    
    self.passwordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"] highlightedImage:[UIImage imageNamed:@"icon_password"]];
    self.passwordRightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [self.passwordRightView setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
//    [self.passwordRightView sizeToFit];
    self.passwordField.rightView = self.passwordRightView;
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.finishButton bs_configureAsDefaultStyle];
    self.finishButton.enabled = false;
    self.finishButton.backgroundColor = RGBCOLOR(200, 200, 200);
    [self.finishButton setTitle:@"完成注册" forState:UIControlStateNormal] ;
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.finishButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateHighlighted];
    
    self.phonePreLabel.text = @"中国 +86";
    self.phoneTextField.placeholder = @"请输入手机号码";
    
    [self.phonePreLabel sizeToFit];
    
    [self.pinButton setTitle:@"请获取验证码" forState:UIControlStateNormal];
    [self.pinButton bs_configureAsDefaultStyle];
    [self.pinButton setTitleColor:RGBCOLOR(150, 150, 150) forState:UIControlStateNormal];
    self.pinButton.backgroundColor = [UIColor clearColor];
    self.pinTextFiled.placeholder = @"请输入验证码";

    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGFloat maxWidth = bounds.size.width - kLeadingPad - kTailingPad;
    
    self.phoneIcon.frame = CGRectMake(0, 0, 24, 24);
    self.phoneTextField.frame = CGRectMake(0, 0, 0, 40);
    self.phonePreLabel.height = 40;
    self.phoneIcon.x = kLeadingPad;
    self.phonePreLabel.x = self.phoneIcon.right + 4.f;
    self.phoneTextField.x = self.phonePreLabel.right + 4.f;
    self.phoneTextField.width = self.view.width - kTailingPad - self.phoneTextField.x;
    self.phoneIcon.centerY = self.phonePreLabel.centerY = self.phoneTextField.centerY = 110;
    self.phonePreLabel.centerY -= 2;
    
    self.line1.frame = CGRectMake(kLeadingPad, self.phoneTextField.bottom, maxWidth, 1);
    
    self.pinButton.x = bounds.size.width - kTailingPad - self.pinButton.width;
    self.pinButton.width = 120.f;
    self.pinTextFiled.x = kLeadingPad;
    self.pinTextFiled.width = maxWidth - self.pinButton.width-4.f;
    self.pinTextFiled.height = 40;
    
    self.pinButton.centerY = self.pinTextFiled.centerY = self.phoneTextField.bottom + 30.f;
    self.line2.frame = CGRectMake(kLeadingPad, self.pinTextFiled.bottom, maxWidth, 1);
    self.pinButton.centerY -= 2;
    
    self.passwordField.frame = CGRectMake(kLeadingPad, 0, maxWidth, 40);
    self.passwordField.centerY = self.pinTextFiled.bottom + 30.f;
    self.line3.frame = CGRectMake(kLeadingPad, self.passwordField.bottom, maxWidth, 1);
    
    self.finishButton.frame = CGRectMake(kLeadingPad, self.passwordField.bottom+24.f, maxWidth, 45);
    
    self.backgroundImage.frame = CGRectMake(0, self.finishButton.bottom+40, bounds.size.width, bounds.size.height-(self.finishButton.bottom+40));
}

@end
