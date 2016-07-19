//
//  SignViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SignViewController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"
#import "HttpMobileExistCheckRequest.h"
#import "HttpGenMobileVcodeRequest.h"
#import "HttpCheckMessageCodeRequest.h"
#import "HttpSignupRequest.h"
#import "LoginViewController.h"


#define kLeadingPad 16.f
#define kTailingPad 16.f


@interface SignViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *phoneIcon;
@property (weak, nonatomic) IBOutlet UILabel *phonePreLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pinTextFiled;
//@property (weak, nonatomic) IBOutlet UIButton *pinButton;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) UIImageView* passwordLeftView;
@property (strong, nonatomic) UIButton* passwordRightView;

@property (strong, nonatomic) UIView *line1;
@property (strong, nonatomic) UIView *line2;
@property (strong, nonatomic) UIView *line3;

@property (strong, nonatomic) RACDisposable* pinButtonDispose;
@property (nonatomic) NSInteger pinButtonFronzenLeftTime;

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
    [self.passwordRightView setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [self.passwordRightView sizeToFit];
    @weakify(self)
    self.passwordRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        @strongify(self);
        NSString *tempString = self.passwordField.text;
        self.passwordField.text = @"";
        
        self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
        if (self.passwordField.secureTextEntry) {
            [self.passwordRightView setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];

        }
        else {
            self.passwordField.font = [UIFont systemFontOfSize:17];
            [self.passwordRightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];

        }
        self.passwordField.text = tempString;
        
        return [RACSignal empty];
    }];
    
    self.passwordField.rightView = self.passwordRightView;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordField.secureTextEntry = YES;
    
    [self.finishButton bs_configureAsDefaultStyle];
    self.finishButton.enabled = NO;
    self.finishButton.backgroundColor = RGBCOLOR(200, 200, 200);
    [self.finishButton setTitle:@"完成注册" forState:UIControlStateNormal] ;
    [self.finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.finishButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateHighlighted];
    
    self.phonePreLabel.text = @"中国 +86";
    self.phoneTextField.placeholder = @"请输入手机号码";
    
    [self.phonePreLabel sizeToFit];
    
    [self.pinButton bs_configureAsDefaultStyle];
    [self.pinButton setTitle:@"  获取验证码" forState:UIControlStateNormal];
    [self.pinButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //self.pinButton.backgroundColor = [UIColor clearColor];
//    self.pinButton.enabled = NO;
    [self.pinButton addTarget:self action:@selector(pinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.pinTextFiled.placeholder = @"请输入验证码";
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)]];

    
    // WTF, I can't disable button in rac_command!!!!
//    @weakify(self)
//    self.pinButton2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
//       
//        @strongify(self);
//        self.pinButtonFronzenLeftTime = 10;
//        
//        self.pinButtonDispose = [[MMTimer sharedInstance].oneSecondSignal subscribeNext:^(id x){
//            self.pinButtonFronzenLeftTime--;
//            if (self.pinButtonFronzenLeftTime == 0) {
//                [self.pinButtonDispose dispose];
//                self.pinButton2.enabled = YES;
////                self.pinButton.userInteractionEnabled = YES;
//            }
//            [self.pinButton2 setTitle:[NSString stringWithFormat:@"%ld", (long)self.pinButtonFronzenLeftTime] forState:UIControlStateDisabled];
//        }];
//        [self.pinButton2 setEnabled:NO];
//
//        return [RACSignal empty];
//    }];
    
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.pinTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    RACSignal *validPhoneSignal = [self.phoneTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          @strongify(self);
                                          return @([self isValidPhoneNumber:text]);
                                      }];
    RACSignal *validPinSignal = [self.pinTextFiled.rac_textSignal
                                      map:^id(NSString *text) {
                                          @strongify(self);
                                          return @([self isValidPin:text]);
                                      }];
    
    RACSignal *validPasswordSignal = [self.passwordField.rac_textSignal
                                 map:^id(NSString *text) {
                                     @strongify(self);
                                     return @([self isPasswordValid:text]);
                                 }];
    
    
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validPinSignal, validPhoneSignal, validPasswordSignal]
                      reduce:^id(NSNumber*pinValid, NSNumber *phoneValid, NSNumber *passordValid){
                          return @([pinValid boolValue] && [phoneValid boolValue] && [passordValid boolValue]);
                      }];
    [signUpActiveSignal subscribeNext:^(NSNumber* signupActive){
        @strongify(self);
        self.finishButton.enabled = [signupActive boolValue];
        if(!self.finishButton.enabled){
            self.finishButton.backgroundColor = [UIColor light_Gray_Color];;
            [self.finishButton setTitleColor: RGBCOLOR(150, 150, 150)  forState:UIControlStateDisabled];
            
        }
        else {
            self.finishButton.backgroundColor = [UIColor greenTextColor];
            [self.finishButton setTitleColor: [UIColor whiteColor]  forState:UIControlStateNormal];
            
        }
    }];
    
    
    [self.finishButton addTarget:self action:@selector(finishSignup:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(BOOL)isPasswordValid:(NSString*)password
{
    return password.length > 0;
}

-(BOOL)isValidPin:(NSString*)pin
{
    NSString *parten = @"^\\d{6}$";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* match = [reg matchesInString:pin options:NSMatchingReportCompletion range:NSMakeRange(0, [pin length])];
    
    if (match.count == 0){
        return NO;
    }
    
    return YES;

}

-(BOOL)isValidPhoneNumber:(NSString*)phoneNumber
{
    if (phoneNumber.length != 11) {
        return NO;
    }
    NSString *parten = @"^[1-9]\\d{10}$";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* match = [reg matchesInString:phoneNumber options:NSMatchingReportCompletion range:NSMakeRange(0, [phoneNumber length])];
    
    if (match.count == 0){
        return NO;
    }

    return YES;
}

-(void)finishSignup:(UIButton*)sender
{
    
    HttpCheckMessageCodeRequest* checkMessageCode = [[HttpCheckMessageCodeRequest alloc] initWithMobileCode:self.pinTextFiled.text andMobile:self.phoneTextField.text];
    HttpSignupRequest* signup = [[HttpSignupRequest alloc] initWithMobile:self.phoneTextField.text
                                                          andCaptchaPhone:self.pinTextFiled.text
                                                              andPassword:self.passwordField.text];
    [self showProgressIndicatorWithTitle:@"正在注册..."];
    [checkMessageCode request]
    .then(^(id responseObject){

        if (checkMessageCode.response.ok) {
            return [signup request];
        }
        else {
            return [BaseHttpRequest httpRequestError:checkMessageCode.response.errorMsg];

        }
    })
    .then(^(id responseObject){

        if (checkMessageCode.response.ok) {
            [self showAlertViewWithMessage:@"注册成功, 欢迎使用189疯狂买卖"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessBroadCast object:nil userInfo:nil];
            
            NSArray* controllers = self.navigationController.viewControllers;
            NSMutableArray* newVCs = [[NSMutableArray alloc] init];
            
            for (UIViewController* vc in controllers) {
                if ([vc isMemberOfClass:[LoginViewController class]]) {
                    if (((LoginViewController*)vc).nextVC) {
                        [newVCs addObject:((LoginViewController*)vc).nextVC];
                    }
                }
                else {
                    [newVCs addObject:vc];
                }
            }
            self.navigationController.viewControllers = [newVCs copy];
            
            [UserCenter defaultCenter].userName = self.phoneTextField.text;
            [[UserCenter defaultCenter] setLogined];
            // store the user name
            NSMutableArray* accountHistoryArray = [[[NSUserDefaults standardUserDefaults] valueForKey:@"AccountHistory"] mutableCopy];
            if(accountHistoryArray == nil){
                accountHistoryArray = [[NSMutableArray alloc] init];
            }
            NSInteger index = [accountHistoryArray indexOfObject:self.phoneTextField.text];
            if (index == NSNotFound) {
                [accountHistoryArray insertObject:self.phoneTextField.text atIndex:0];
            }
            else {
                NSString* userName = accountHistoryArray[index];
                [accountHistoryArray removeObject:userName];
                [accountHistoryArray insertObject:userName atIndex:0];
            }
            [[NSUserDefaults standardUserDefaults] setObject:accountHistoryArray forKey:@"AccountHistory"];

            [self.navigationController popViewControllerAnimated:YES];
            
            return (AnyPromise*)responseObject;
        }
        else {
            return [BaseHttpRequest httpRequestError:signup.response.errorMsg];
            
        }
    })
    .catch(^(NSError *error){

        [self showAlertViewWithMessage:error.localizedDescription];
        
        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
    })
    .finally(^(){

        [self dismissProgressIndicator];
    });
}

-(void)pinButtonClicked:(UIButton*)sender
{
    
    self.pinButton.enabled = NO;

    NSString* phoneNumber = [self.phoneTextField.text copy];
    if (![self isValidPhoneNumber:phoneNumber]) {
        [self showAlertViewWithMessage:@"请输入正确的11位手机号码"];
        self.pinButton.enabled = YES;

        return;
    }
    
    HttpMobileExistCheckRequest* mobileExistCheckrequest = [[HttpMobileExistCheckRequest alloc] initWithMobile:phoneNumber];
    HttpGenMobileVcodeRequest* genMobileVcodeRequest = [[HttpGenMobileVcodeRequest alloc] initWithMobile:phoneNumber];

//    [self showProgressIndicatorWithTitle:@"正在获取手机验证码..."];

    @weakify(self);
    [mobileExistCheckrequest request]
    .then(^(id responseObject){

        NSLog(@"%@", responseObject);
        if (mobileExistCheckrequest.response.ok) {
            return [genMobileVcodeRequest request];
        }
        else {
            
            return [BaseHttpRequest httpRequestError:mobileExistCheckrequest.response.errorMsg];
        }
    })
    .then(^(id responseObject){
         NSLog(@"%@", responseObject);
        if (genMobileVcodeRequest.response.ok) {
            
            [self showAlertViewWithMessage:@"获取手机验证码成功"];
            
            self.pinButtonFronzenLeftTime = 60;
            [self.pinButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", (long)self.pinButtonFronzenLeftTime] forState:UIControlStateDisabled];
            
            self.pinButtonDispose = [[MMTimer sharedInstance].oneSecondSignal
                                     subscribeNext:^(id x){
                                         @strongify(self);
                                         self.pinButtonFronzenLeftTime--;
                                         if (self.pinButtonFronzenLeftTime == 0) {
                                             [self.pinButtonDispose dispose];
                                             self.pinButton.enabled = YES;
                                         }
                
                                         [self.pinButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", (long)self.pinButtonFronzenLeftTime] forState:UIControlStateDisabled];
                                         self.pinButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                                     }];
            
            return (AnyPromise*)responseObject;
        }
        else {
            return [BaseHttpRequest httpRequestError:genMobileVcodeRequest.response.errorMsg];
        }
    })
    .catch(^(NSError *error){

        self.pinButton.enabled = YES;
        [self showAlertViewWithMessage:error.localizedDescription];

    })
    .finally(^(){

//        [self dismissProgressIndicator];
    });

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    CGFloat maxWidth = bounds.size.width - kLeadingPad - kTailingPad;
    
    self.phoneIcon.frame = CGRectMake(0, 0, 14, 20);
    self.phoneTextField.frame = CGRectMake(0, 0, 0, 40);
    self.phonePreLabel.height = 40;
    self.phoneIcon.x = kLeadingPad;
    self.phonePreLabel.x = self.phoneIcon.right + 4.f;
    self.phoneTextField.x = self.phonePreLabel.right + 4.f;
    self.phoneTextField.width = self.view.width - kTailingPad - self.phoneTextField.x;
    self.phoneIcon.centerY = self.phonePreLabel.centerY = self.phoneTextField.centerY = 50;
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

-(void)singleTap
{
    UIScrollView* scrollView = (UIScrollView*)self.view;
    [[scrollView TPKeyboardAvoiding_findFirstResponderBeneathView:scrollView] resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIScrollView* scrollView = (UIScrollView*)self.view;
    [[scrollView TPKeyboardAvoiding_findFirstResponderBeneathView:scrollView] resignFirstResponder];

}

-(void)dealloc
{
    NSLog(@"Dealloc SignViewController!");
}

@end
