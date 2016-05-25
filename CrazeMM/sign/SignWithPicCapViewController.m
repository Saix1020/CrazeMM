//
//  SignWithPicCapViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SignWithPicCapViewController.h"
#import "HttpRandomCodeRequest.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SignWithPicCapViewController ()
@property (strong, nonatomic) UIButton* passwordRightView;

@end

@implementation SignWithPicCapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"手机快速注册";

    
    HttpRandomCodeRequest* request = [[HttpRandomCodeRequest alloc] init];
    [request request].then(^(id response){
        self.pictureCaptchaImageView.image = [UIImage imageWithData:((HttpRandomCodeResponse*)request.response).picData];
    });
    
    self.nextPicButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        [request request].then(^(id response){
            self.pictureCaptchaImageView.image = [UIImage imageWithData:((HttpRandomCodeResponse*)request.response).picData];
        });
        
        return [RACSignal empty];
    }];
    
    [self initAllViews];
}

-(void)initAllViews
{
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxHeigth = [UIScreen mainScreen].bounds.size.height;
    self.line1.width =  maxWidth - 2*16.f;
    self.line2.width = maxWidth - 2*16.f;
    self.line3.width = maxWidth - 2*16.f;
    self.line4.width = maxWidth - 2*16.f;

    self.phoneNumTextField.width = maxWidth-16.f - self.phoneNumTextField.x;
    //self.phoneNumTextField.x = maxWidth-16.f- self.phoneNumTextField.width;
    
//    self.phoneNumTextField.width = 200.f;
    
    self.nextPicButton.x = maxWidth-16.f-self.nextPicButton.width;
    self.pictureCaptchaImageView.x = self.nextPicButton.x - self.pictureCaptchaImageView.width;
    self.picCapTextField.width = self.pictureCaptchaImageView.x-self.picCapTextField.x - 4.f;
    
    self.phoneCheckButton.x = maxWidth - 16.f - self.phoneCheckButton.width;
    self.phoneCheckTextField.width = self.phoneCheckButton.x- self.phoneCheckTextField.x;
    self.phoneCheckButton.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.phoneCheckButton.layer.borderWidth = 1.f;
    self.phoneCheckButton.clipsToBounds = YES;
    self.phoneCheckButton.layer.cornerRadius = 4.f;
    [self.phoneCheckButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.passwordTextField.width = maxWidth - 16.f*2;
    self.finishSignupButton.width = maxWidth - 16.f*2;
    self.backgroundImageView.width = maxWidth;
    
    self.finishSignupButton.clipsToBounds = YES;
    self.finishSignupButton.layer.cornerRadius = 4.f;
    self.finishSignupButton.enabled = NO;
    
    //self.view.  = [[UIImageView alloc] initWithImage:[@"sign_backgroud" image]];
    
    self.passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"] highlightedImage:[UIImage imageNamed:@"icon_password"]];
    
    self.passwordRightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [self.passwordRightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
    [self.passwordRightView sizeToFit];
    self.passwordRightView.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        NSString *tempString = self.passwordTextField.text;
        self.passwordTextField.text = @"";
        
        self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
        if (self.passwordTextField.secureTextEntry) {
            [self.passwordRightView setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateNormal];
            
        }
        else {
            self.passwordTextField.font = [UIFont systemFontOfSize:17];
            [self.passwordRightView setImage:[UIImage imageNamed:@"icon_password"] forState:UIControlStateNormal];
            
        }
        self.passwordTextField.text = tempString;
        
        return [RACSignal empty];
    }];
    
    self.passwordTextField.rightView = self.passwordRightView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.secureTextEntry = YES;
    
//    self.view.backgroundColor = [UIColor ]
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"sign_bg"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"sign_bg"] ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillLayoutSubviews
{
//    TPKeyboardAvoidingScrollView* view = (TPKeyboardAvoidingScrollView*)self.view;
//    view.contentInset = UIEdgeInsetsZero;
    [super viewWillLayoutSubviews];
//    TPKeyboardAvoidingScrollView* view = (TPKeyboardAvoidingScrollView*)self.view;
//    if(!CGSizeEqualToSize(view.contentSize, [UIScreen mainScreen].bounds.size) && !CGSizeEqualToSize(view.contentSize, CGSizeZero)){
//        view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//
//    }

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    TPKeyboardAvoidingScrollView* view = (TPKeyboardAvoidingScrollView*)self.view;
    //view.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, view.contentSize.height);
}


@end
