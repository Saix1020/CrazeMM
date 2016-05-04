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
    [self.passwordRightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
    [self.passwordRightView sizeToFit];
    self.passwordRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        NSString *tempString = self.passwordField.text;
        self.passwordField.text = @"";
        
        self.passwordField.secureTextEntry = !self.passwordField.secureTextEntry;
        if (self.passwordField.secureTextEntry) {
            [self.passwordRightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];

        }
        else {
            self.passwordField.font = [UIFont systemFontOfSize:17];
            [self.passwordRightView setImage:[UIImage imageNamed:@"icon_password"] forState:UIControlStateNormal];

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
    
    @weakify(self);
    RACSignal *validUsernameSignal = [self.phoneTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          @strongify(self);
                                          return @([self isValidPhoneNumber:text]);
                                      }];
    
    
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

-(void)pinButtonClicked:(UIButton*)sender
{
    
    if (self.pinTextFiled.text.length != 13) {
        
    }
    
    NSString* phoneNumber = [self.phoneTextField.text copy];
    if (![self isValidPhoneNumber:phoneNumber]) {
        [self showAlertViewWithMessage:@"请输入正确的11位手机号码"];

        return;
    }
    
    
    
    HttpMobileExistCheckRequest* mobileExistCheckrequest = [[HttpMobileExistCheckRequest alloc] initWithMobile:phoneNumber];
    HttpGenMobileVcodeRequest* genMobileVcodeRequest = [[HttpGenMobileVcodeRequest alloc] initWithMobile:phoneNumber];

    [mobileExistCheckrequest request]
    .then(^(id responseObject, AFHTTPRequestOperation *operation){
        NSLog(@"%@", responseObject);
        if (mobileExistCheckrequest.response.ok) {
            return [genMobileVcodeRequest request];
        }
        else {
            
            return [BaseHttpRequest httpRequestError:@"该手机号已注册"];
        }
    })
    .then(^(id responseObject, AFHTTPRequestOperation *operation){
         NSLog(@"%@", responseObject);
        
        if (genMobileVcodeRequest.response.ok) {
            
            [self showAlertViewWithMessage:@"获取手机验证码成功"];
            
            sender.enabled = NO;
            self.pinButtonFronzenLeftTime = 60;
            [self.pinButton setTitle:[NSString stringWithFormat:@"%ld", (long)self.pinButtonFronzenLeftTime] forState:UIControlStateDisabled];
            
            self.pinButtonDispose = [[MMTimer sharedInstance].oneSecondSignal subscribeNext:^(id x){
                self.pinButtonFronzenLeftTime--;
                if (self.pinButtonFronzenLeftTime == 0) {
                    [self.pinButtonDispose dispose];
                    self.pinButton.enabled = YES;
                }
                
                [self.pinButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", (long)self.pinButtonFronzenLeftTime] forState:UIControlStateDisabled];
            }];
            
            return (AnyPromise*)responseObject;
        }
        else {
            return [BaseHttpRequest httpRequestError:genMobileVcodeRequest.response.errorMsg];
        }
    })
    .catch(^(NSError *error){
        [self showAlertViewWithMessage:error.localizedDescription];

        NSLog(@"error happened: %@", error.localizedDescription);
        NSLog(@"original operation: %@", error.userInfo[AFHTTPRequestOperationErrorKey]);
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


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIScrollView* scrollView = (UIScrollView*)self.view;
    [[scrollView TPKeyboardAvoiding_findFirstResponderBeneathView:scrollView] resignFirstResponder];

}

@end
