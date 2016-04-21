//
//  LoginViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "LoginViewController.h"
#import "BEMCheckBox.h"
#import "SuggestViewController.h"
#import "ZZPopoverWindow.h";

#define kLeadingPad 16.f
#define kTailingPad 16.f


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet BEMCheckBox *rememberMeCheckBox;

@property (weak, nonatomic) IBOutlet UILabel *rememberMeLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UILabel *wechartLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wechartIcon;

@property (strong, nonatomic) UIButton* userNameRightView;
@property (strong, nonatomic) UIButton* passwordRightView;


@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIView *line3;

@property (strong, nonatomic) SuggestViewController* suggestVC;
@property (nonatomic, strong) ZZPopoverWindow* popover;


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
    [self.loginButton bs_configureAsDefaultStyle];
    self.loginButton.enabled = false;
    self.loginButton.backgroundColor = RGBCOLOR(200, 200, 200);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal] ;
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateHighlighted];
    
    [self.registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.registerButton setTitleColor:RGBCOLOR(150, 150, 150) forState:UIControlStateNormal];
    [self.registerButton setImage:[UIImage imageNamed:@"fast_register"] forState:UIControlStateNormal];
    
    self.rememberMeCheckBox.boxType = BEMBoxTypeSquare;
    self.rememberMeCheckBox.onFillColor = [UIColor clearColor];
    self.rememberMeCheckBox.onAnimationType = BEMAnimationTypeOneStroke;
//    self.rememberMeCheckBox.animationDuration = 0.3f;
    self.rememberMeCheckBox.lineWidth = 1;
    
    self.rememberMeLabel.text = @"下次自动登录";
    self.rememberMeLabel.textColor = RGBCOLOR(150, 150, 150);
    
    self.wechartLabel.textColor = RGBCOLOR(40, 40, 40);
    self.wechartLabel.text = @"微信登录";
    
    self.userNameRightView = [[UIButton alloc] init];
    [self.userNameRightView setImage:[UIImage imageNamed:@"icon_pulldown"] forState:UIControlStateNormal];
    self.userNameField.rightView = self.userNameRightView;
    [self.userNameRightView sizeToFit];
    self.userNameField.rightViewMode = UITextFieldViewModeAlways;

    
    self.passwordRightView = [[UIButton alloc] init];
    [self.passwordRightView setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.passwordRightView setTitleColor:RGBCOLOR(150, 150, 150) forState:UIControlStateNormal];
    [self.passwordRightView setTitleColor:[UIColor colorWithRed:150 green:150 blue:150 alpha:0.4] forState:UIControlStateHighlighted];
    [self.passwordRightView sizeToFit];
    self.passwordField.rightView = self.passwordRightView;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.userNameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"] highlightedImage:[UIImage imageNamed:@"icon_user"]];
    self.passwordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"] highlightedImage:[UIImage imageNamed:@"icon_password"]];
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    
    @weakify(self);
    RACSignal *validUsernameSignal = [self.userNameField.rac_textSignal
                                      map:^id(NSString *text) {
                                          @strongify(self);
                                          return @([self isValidUsername:text]);
                                      }];
    RACSignal *validPasswordSignal = [self.passwordField.rac_textSignal
                                      map:^id(NSString *text) {
                                          @strongify(self);
                                          return @([self isValidPassword:text]);
                                      }];
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                      reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        @strongify(self);
        self.loginButton.enabled = [signupActive boolValue];
        if(!self.loginButton.enabled){
            self.loginButton.backgroundColor = RGBCOLOR(200, 200, 200);

        }
        else {
            self.loginButton.backgroundColor = [UIColor clearColor];

        }
    }];
    
    self.suggestVC = [[SuggestViewController alloc] init];
    self.suggestVC.suggestedStrings = @[@"Sai Xu", @"Zhou Yu", @"XXXXX", @"YYYYYY"];
    self.suggestVC.delegate = self;
                      
    self.userNameRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        @strongify(self);
        self.suggestVC.view.frame = CGRectMake(0, 0, self.userNameField.frame.size.width, self.suggestVC.height);
//        self.suggestVC.view.backgroundColor = RGBCOLOR(150, 150, 150);
        self.popover                    = [[ZZPopoverWindow alloc] init];
        self.popover.popoverPosition = ZZPopoverPositionDown;
        self.popover.contentView        = self.suggestVC.view;
        self.popover.animationSpring = NO;
//        self.popover.backgroundColor = RGBCOLOR(150, 150, 150);
        self.popover.showArrow = NO;
        self.popover.didShowHandler = ^() {
            //self.popover.layer.cornerRadius = 0;
        };
        self.popover.didDismissHandler = ^() {
            //NSLog(@"Did dismiss");
        };
        
        [self.popover showAtView:self.userNameField];

        
        return [RACSignal empty];
    }];
}

-(BOOL)isValidUsername:(NSString*)name
{
    return name.length>0;
}


-(BOOL)isValidPassword:(NSString*)password
{
    return password.length>0;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = bounds.size.width - kLeadingPad - kTailingPad;
    CGFloat y = 100.f;
    self.logoImage.frame = CGRectMake((bounds.size.width-self.logoImage.frame.size.width)/2,
                                      y, self.logoImage.frame.size.width, self.logoImage.frame.size.height);
    
    
    self.wechartLabel.frame = CGRectMake(kLeadingPad, bounds.size.height-40, maxWidth, 30);
    self.wechartIcon.center = CGPointMake(bounds.size.width/2, self.wechartLabel.frame.origin.y-self.wechartIcon.frame.size.height/2);
    
    
    self.loginButton.frame = CGRectMake(kLeadingPad, bounds.size.height/2+20, maxWidth, 50);
    
    self.passwordField.frame = CGRectMake(kLeadingPad, bounds.size.height/2-40, maxWidth, 40);
    self.userNameField.frame = CGRectMake(kLeadingPad, self.passwordField.frame.origin.y-40-16.f, maxWidth, 40);
    
    self.registerButton.frame = CGRectMake(bounds.size.width-kTailingPad-self.registerButton.frame.size.width, CGRectGetMaxY(self.loginButton.frame)+4.f, self.registerButton.frame.size.width, 40);
    self.rememberMeLabel.frame = CGRectMake(CGRectGetMaxX(self.rememberMeCheckBox.frame)+4.f, CGRectGetMaxY(self.loginButton.frame)+4.f, self.registerButton.frame.size.width, 40);
    self.rememberMeCheckBox.frame = CGRectMake(kLeadingPad, self.registerButton.frame.origin.y+14.f, 12.f, 12.f);
    
    self.line1.frame = CGRectMake(kLeadingPad, CGRectGetMaxY(self.userNameField.frame), maxWidth, 1);
    self.line2.frame = CGRectMake(kLeadingPad, CGRectGetMaxY(self.passwordField.frame), maxWidth, 1);
    self.line3.frame = CGRectMake(kLeadingPad, self.wechartIcon.frame.origin.y-8.f, maxWidth, 1);
}

#pragma -- mark SugguestViewController delegate

-(void)didSelectSuggestString:(NSString*)selectedString
{
    self.userNameField.text = selectedString;
    [self.popover dismiss];
}


@end
