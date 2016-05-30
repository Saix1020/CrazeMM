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
#import "ZZPopoverWindow.h"
#import "SignViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "HttpLoginRequest.h"
#import "HttpRandomCodeRequest.h"
#import "SignWithPicCapViewController.h"


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
@property (strong, nonatomic) SignViewController* signVC;
@property (strong, nonatomic) SignWithPicCapViewController* signWithPicVC;

@property (nonatomic, strong) ZZPopoverWindow* popover;
@property (nonatomic, strong) UIScrollView* trueView;

@property (nonatomic) BOOL keyboardShowing;

@end

@implementation LoginViewController

//-(void)loadView
//{
//    
//    
//}
//-(void)awakeFromNib
//{
////    [super loadView];
//    
//    self.trueView = [[UIScrollView alloc] init];
//    //    UIView* t = self.view;
//    [self.view.superview addSubview:self.trueView];
//    [self.view removeFromSuperview];
//    [self.trueView addSubview:self.view];
//    self.view = self.trueView;
//}

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
    @weakify(self)
    self.navigationItem.title = @"会员登录";
    if (self.navigationController.viewControllers.count>1 && (self.navigationItem.leftBarButtonItem == nil || self.navigationItem.leftBarButtonItems.count>0)) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];

    }
    
    [self initLines];
    self.rememberMeCheckBox.on = YES;
    
    [self.loginButton bs_configureAsDefaultStyle];
    self.loginButton.enabled = false;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal] ;
    [self.registerButton setTitle:@"快速注册" forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.registerButton setTitleColor:RGBCOLOR(150, 150, 150) forState:UIControlStateNormal];
    [self.registerButton setImage:[UIImage imageNamed:@"fast_register"] forState:UIControlStateNormal];
    self.registerButton.tintColor = [UIColor redColor];
    
    self.rememberMeCheckBox.boxType = BEMBoxTypeSquare;
    self.rememberMeCheckBox.onFillColor = [UIColor clearColor];
    self.rememberMeCheckBox.onAnimationType = BEMAnimationTypeOneStroke;
    self.rememberMeCheckBox.animationDuration = 0.f; 
    self.rememberMeCheckBox.lineWidth = 1;
    
    self.rememberMeLabel.text = @"下次自动登录";
    self.rememberMeLabel.textColor = RGBCOLOR(150, 150, 150);
    
    self.wechartLabel.textColor = RGBCOLOR(40, 40, 40);
    self.wechartLabel.text = @"微信登录";
    //wechart login not support now
    self.wechartLabel.hidden = YES;
    self.wechartIcon.hidden = YES;
    self.line3.hidden = YES;
    
    self.userNameRightView = [[UIButton alloc] init];
    [self.userNameRightView setImage:[UIImage imageNamed:@"icon_pulldown"] forState:UIControlStateNormal];
    self.userNameField.rightView = self.userNameRightView;
    [self.userNameRightView sizeToFit];
    self.userNameField.rightViewMode = UITextFieldViewModeAlways;

    
    self.passwordRightView = [[UIButton alloc] init];
    [self.passwordRightView setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.passwordRightView setTitleColor:RGBCOLOR(150, 150, 150) forState:UIControlStateNormal];
    [self.passwordRightView setTitleColor:[UIColor colorWithRed:150 green:150 blue:150 alpha:0.4] forState:UIControlStateHighlighted];
    
    self.passwordRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        @strongify(self);
        [self showAlertViewWithMessage:@"请使用电脑端页面找回密码: http://www.189mm.com/ui/findPassword_ui"];
        return [RACSignal empty];
    }];
    [self.passwordRightView sizeToFit];
    self.passwordField.rightView = self.passwordRightView;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.userNameField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"] highlightedImage:[UIImage imageNamed:@"icon_user"]];
    self.passwordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"] highlightedImage:[UIImage imageNamed:@"icon_password"]];
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    self.registerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
//        [self.registerButton becomeFirstResponder];
        
        self.signVC = [[SignViewController alloc] init];
        [self.navigationController pushViewController:self.signVC animated:YES];
        
//        self.signWithPicVC = [[SignWithPicCapViewController alloc] init];
//                [self.navigationController pushViewController:self.signWithPicVC animated:YES];

        return [RACSignal empty];
    }];
    
    RACSignal *validUsernameSignal = [RACObserve(self, userNameField.text)
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
                          @strongify(self);
                          // for we can choose the user name from suggestion table view
                          // we check self.userNameField.text here
                          return  @([self isValidUsername:self.userNameField.text] && [passwordValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        @strongify(self);
        self.loginButton.enabled = [signupActive boolValue];
        if(!self.loginButton.enabled){
            self.loginButton.backgroundColor = [UIColor light_Gray_Color];
            [self.loginButton setTitleColor: RGBCOLOR(150, 150, 150)  forState:UIControlStateDisabled];
        }
        else {
            self.loginButton.backgroundColor = [UIColor greenTextColor];
            [self.loginButton setTitleColor: [UIColor whiteColor]  forState:UIControlStateNormal];

        }
    }];
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id sender){
        
        
        
        @strongify(self);
        // store the user name
        NSMutableArray* accountHistoryArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"AccountHistory"] mutableCopy];
        if(accountHistoryArray == nil){
            accountHistoryArray = [[NSMutableArray alloc] init];
        }
        NSInteger index = [accountHistoryArray indexOfObject:self.userNameField.text];
        if (index == NSNotFound) {
            [accountHistoryArray insertObject:self.userNameField.text atIndex:0];
        }
        else {
            NSString* userName = accountHistoryArray[index];
            [accountHistoryArray removeObject:userName];
            [accountHistoryArray insertObject:userName atIndex:0];
        }
        [[NSUserDefaults standardUserDefaults] setObject:accountHistoryArray forKey:@"AccountHistory"];

//        NSString* userName = [self.userNameField.text copy];
        
        HttpLoginRequest* request = [[HttpLoginRequest alloc] initWithUser:self.userNameField.text
                                                               andPassword:self.passwordField.text
                                                               andRemember:self.rememberMeCheckBox.on];
        [self showProgressIndicatorWithTitle:@"正在登陆..."];
        [request request2].then(^(id responseObject){
//            [self dismissProgressIndicator];

            if (request.response.ok) {
                [UserCenter defaultCenter].userName = self.userNameField.text;
                [[UserCenter defaultCenter] setLogined];
                [self.navigationController popViewControllerAnimated:YES];
                
                if (self.rememberMeCheckBox.on) {
                    [[UserCenter defaultCenter] saveToKeychainWithUserName:self.userNameField.text andPassword:self.passwordField.text];
                }
//                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessBroadCast object:nil userInfo:nil];


            }
            else {
                [self showAlertViewWithMessage:request.response.errorMsg];
            }
            
        }).catch(^(NSError *error){
//            [self dismissProgressIndicator];
            NSLog(@"error happened: %@", error.localizedDescription);
            NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
            [self showAlertViewWithMessage:error.localizedDescription];
        })
        .finally(^(){
            [self dismissProgressIndicator];
        });
        return [RACSignal empty];
    }];
    
    
                      
    self.userNameRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        @strongify(self);
        self.suggestVC = [[SuggestViewController alloc] init];
        NSArray* accountHistoryArray = [[NSUserDefaults standardUserDefaults] arrayForKey:@"AccountHistory"];
        if (accountHistoryArray.count != 0) {
            self.suggestVC.suggestedStrings = accountHistoryArray;
            self.suggestVC.delegate = self;
            self.suggestVC.view.frame = CGRectMake(0, 0, self.userNameField.frame.size.width, self.suggestVC.height);
            self.popover                    = [[ZZPopoverWindow alloc] init];
            self.popover.popoverPosition = ZZPopoverPositionDown;
            self.popover.contentView        = self.suggestVC.view;
            self.popover.animationSpring = NO;
            self.popover.showArrow = NO;
            self.popover.didShowHandler = ^() {
                //self.popover.layer.cornerRadius = 0;
            };
            self.popover.didDismissHandler = ^() {
                //NSLog(@"Did dismiss");
            };
            
            [self.popover showAtView:self.userNameField];
        }
        
        

        
        return [RACSignal empty];
    }];
    
    //[self.userNameField becomeFirstResponder];
    self.loginButton.enabled = false;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)]];

}

-(void)singleTap
{
    UIScrollView* scrollView = (UIScrollView*)self.view;
    [[scrollView TPKeyboardAvoiding_findFirstResponderBeneathView:scrollView] resignFirstResponder];
}

-(BOOL)isValidUsername:(NSString*)name
{
    return name.length>0;
}


-(BOOL)isValidPassword:(NSString*)password
{
    return password.length>0;
}



//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self becomeFirstResponder];
//}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    
    // TODO !!!!
    // use constant value instead of hardcode
    CGRect bounds = self.view.bounds;
    CGFloat maxWidth = bounds.size.width - kLeadingPad - kTailingPad;
    //CGFloat y = 30.f + (self.navigationController.navigationBarHidden?64.f:0);
    CGFloat y = 30.f;
//    self.logoImage.frame = CGRectMake((bounds.size.width-self.logoImage.frame.size.width)/2,
//                                      y, self.logoImage.frame.size.width, self.logoImage.frame.size.height);
    
    self.wechartLabel.frame = CGRectMake(kLeadingPad, self.view.bottom-40-(!self.navigationController.navigationBarHidden?64.f:20), maxWidth, 30);
    self.wechartIcon.center = CGPointMake(bounds.size.width/2, self.wechartLabel.frame.origin.y-self.wechartIcon.frame.size.height/2);
    
    
    self.loginButton.frame = CGRectMake(kLeadingPad, bounds.size.height/2+20-(!self.navigationController.navigationBarHidden?64.f:20.f), maxWidth, 50);
    
    self.passwordField.frame = CGRectMake(kLeadingPad, bounds.size.height/2-36-(!self.navigationController.navigationBarHidden?64.f:20.f), maxWidth, 40);
    self.userNameField.frame = CGRectMake(kLeadingPad, self.passwordField.frame.origin.y-36-16.f, maxWidth, 40);
    
    self.logoImage.frame = CGRectMake((bounds.size.width-self.logoImage.frame.size.width)/2,
                                      (self.userNameField.y)/2-30.f, self.logoImage.frame.size.width, self.logoImage.frame.size.height);

    
    self.registerButton.frame = CGRectMake(bounds.size.width-kTailingPad-self.registerButton.frame.size.width, CGRectGetMaxY(self.loginButton.frame)+4.f, self.registerButton.frame.size.width, 40);
    self.rememberMeLabel.frame = CGRectMake(CGRectGetMaxX(self.rememberMeCheckBox.frame)+4.f, CGRectGetMaxY(self.loginButton.frame)+4.f, self.registerButton.frame.size.width, 40);
    self.rememberMeCheckBox.frame = CGRectMake(kLeadingPad, self.registerButton.frame.origin.y+14.f, 12.f, 12.f);
    
    self.line1.frame = CGRectMake(kLeadingPad, CGRectGetMaxY(self.userNameField.frame), maxWidth, 1);
    self.line2.frame = CGRectMake(kLeadingPad, CGRectGetMaxY(self.passwordField.frame), maxWidth, 1);
    self.line3.frame = CGRectMake(kLeadingPad, self.wechartIcon.frame.origin.y-8.f, maxWidth, 1);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController setTabBarHidden:YES animated:YES];

    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UIScrollView* scrollView = (UIScrollView*)self.view;
    scrollView.contentSize = CGSizeMake(0, 0);

    
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    
//}

#define kOFFSET_FOR_KEYBOARD 140.0f
#define kScroll_OFFSET 80.f

-(void)keyboardWillHide: (NSNotification *)notification
{
    UIScrollView* scrollView = (UIScrollView*)self.view;

    scrollView.contentSize = CGSizeMake(0, 0);
    self.keyboardShowing = NO;
}

-(void)keyboardWillShow: (NSNotification *)notification
{
    UIScrollView* scrollView = (UIScrollView*)self.view;
    if (!self.keyboardShowing) {
        scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height+kOFFSET_FOR_KEYBOARD+(!self.navigationController.navigationBarHidden?0.f:44.f));
        [scrollView setContentOffset:CGPointMake(0, kScroll_OFFSET) animated:YES];
        self.keyboardShowing = YES;
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
//    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    UIScrollView* scrollView = (UIScrollView*)self.view;
    [[scrollView TPKeyboardAvoiding_findFirstResponderBeneathView:scrollView] resignFirstResponder];
    self.keyboardShowing = NO;
    
    //[self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];

}

#pragma -- mark SugguestViewController delegate

-(void)didSelectSuggestString:(NSString*)selectedString
{
    self.userNameField.text = selectedString;
    [self.popover dismiss];
}

-(void)dealloc
{
    NSLog(@"Dealloc LoginViewController");
}

@end
