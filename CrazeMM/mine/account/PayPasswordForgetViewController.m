//
//  PayPasswordForgetViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayPasswordForgetViewController.h"
#import "GenMobileVcodeCell.h"
#import "PasswordInputView.h"
#import "HttpGenMobileVcodeForUser.h"
#import "HttpBalance.h"


@interface PayPasswordForgetViewController ()
@property (nonatomic, strong) GenMobileVcodeCell* inputMobileVcodeCell;

@property (nonatomic, strong) UITableViewCell* genVCodeCell;
@property (nonatomic, strong) UIButton* genVCodeButton;

@property (nonatomic, strong) UITableViewCell* passwordCell;
@property (nonatomic, strong) PasswordInputView* passwordInputView;

@property (nonatomic) NSInteger currentStep;

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) NSString* nPassword;
@property (nonatomic, strong) NSString* cPassword;


@property (nonatomic) NSInteger buttonFronzenLeftTime;

@property (strong, nonatomic) RACDisposable* genVCodeButtonDispose;

@end

@implementation PayPasswordForgetViewController

-(PasswordInputView*)passwordInputView
{
    if (!_passwordInputView) {
        _passwordInputView = (PasswordInputView*)[UINib viewFromNib:@"PasswordInputView"];
        _passwordInputView.delegate = self;
        _passwordInputView.promptLabel.text = @"请输入新的支付密码";
    }
    
    return _passwordInputView;
}

-(UITableViewCell*)passwordCell
{
    if (!_passwordCell) {
        _passwordCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"passwordCell"];
        [_passwordCell.contentView addSubview:self.passwordInputView];
    }
    
    return _passwordCell;
}

-(GenMobileVcodeCell*)inputMobileVcodeCell
{
    if (!_inputMobileVcodeCell) {
        _inputMobileVcodeCell = (GenMobileVcodeCell*)[UINib viewFromNib:@"GenMobileVcodeCell"];
        
        [_inputMobileVcodeCell.submitButton addTarget:self action:@selector(submitVCode:) forControlEvents:UIControlEventTouchUpInside];
        _inputMobileVcodeCell.vcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _inputMobileVcodeCell;
}

-(UITableViewCell*)genVCodeCell
{
    if (!_genVCodeCell) {
        _genVCodeCell = [[UITableViewCell alloc] init];
        
        _genVCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_genVCodeButton setTitle:@"发送验证码到手机" forState:UIControlStateNormal];
        _genVCodeButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_genVCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_genVCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _genVCodeButton.frame = CGRectMake(8.f, 8.f, [UIScreen mainScreen].bounds.size.width-8.f*2, 40.f);
        _genVCodeButton.backgroundColor = [UIColor UIColorFromRGB:0x04be02];
        [_genVCodeCell addSubview:_genVCodeButton];
        _genVCodeButton.enabled = YES;
        
        [_genVCodeButton addTarget:self action:@selector(genMobileVcode:) forControlEvents:UIControlEventTouchUpInside];
        _genVCodeCell.backgroundColor = [UIColor clearColor];
    }
    
    return _genVCodeCell;
}

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 16.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        _confirmButton.enabled = NO;
        [_confirmButton addTarget:self action:@selector(saveNewPassword:) forControlEvents:UIControlEventTouchUpInside];
        _confirmCell.backgroundColor = [UIColor clearColor];
        _confirmCell.hidden = YES;
    }
    
    return _confirmCell;
}

-(void)saveNewPassword:(id)sender
{
    [self.passwordInputView resignFirstResponder];
    [self showProgressIndicatorWithTitle:@"正在修改密码, 请稍等..."];
    HttpBalanceModifyPayPwdRequest* request = [[HttpBalanceModifyPayPwdRequest alloc] initWithCaptchaMobile:self.inputMobileVcodeCell.vcode andNewPassword:self.nPassword andConfirmPassword:self.cPassword];
    [request request]
    .then(^(id responseObj){
        @weakify(self);
        if (request.response.ok) {
            [self showAlertViewWithMessage:@"修改支付密码成功" withCallback:^(id x){
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg withCallback:^(id x){
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    })
    .catch(^(NSError* error){
        @weakify(self);
        [self showAlertViewWithMessage:error.localizedDescription withCallback:^(id x){
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    })
    .finally(^(){
        [self dismissProgressIndicator];
    });
}

-(void)submitVCode:(id)sender
{
    if (self.inputMobileVcodeCell.vcode.length ==6 ) {
        HttpBalanceValidateCodeRequest* request = [[HttpBalanceValidateCodeRequest alloc] initWithVCode:self.inputMobileVcodeCell.vcode];
        [request request]
        .then(^(id responseObj){
            if (request.response.ok) {
                self.currentStep = 2;
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage: request.response.errorMsg];
                // for test
//                self.currentStep = 2;
//                [self.tableView reloadData];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage: error.localizedDescription];
//            self.currentStep = 2;
//            [self.tableView reloadData];
        });
    }
    else {
        [self showAlertViewWithMessage:@"请输入正确的6位数字验证码"];
    }
}

-(void)genMobileVcode:(id)sender
{
    HttpGenMobileVcodeForUserRequest* request = [[HttpGenMobileVcodeForUserRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpGenMobileVcodeForUserResponse* response = (HttpGenMobileVcodeForUserResponse*)request.response;
        if (response.ok) {
            [self showAlertViewWithMessage:response.description];
            self.genVCodeButton.enabled = NO;
            self.genVCodeButton.backgroundColor = [UIColor light_Gray_Color];
            self.buttonFronzenLeftTime = 75;
            [self.genVCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", (long)self.buttonFronzenLeftTime] forState:UIControlStateDisabled];
            @weakify(self);
            self.genVCodeButtonDispose = [[MMTimer sharedInstance].oneSecondSignal
                                     subscribeNext:^(id x){
                                         @strongify(self);
                                         self.buttonFronzenLeftTime--;
                                         if (self.buttonFronzenLeftTime == 0) {
                                             [self.genVCodeButtonDispose dispose];
                                             self.genVCodeButton.enabled = YES;
                                             self.genVCodeButton.backgroundColor = [UIColor UIColorFromRGB:0x04be02];
                                         }
                                         
                                         [self.genVCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新获取", (long)self.buttonFronzenLeftTime] forState:UIControlStateDisabled];
                                         self.genVCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                                     }];
            
        }
        else{
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    @weakify(self)
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self showAlertViewWithMessage:@"放弃设置密码吗?"
                        withOKCallback:^(id x){
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                     andCancelCallback:nil];
        return [RACSignal empty];
    }];

    self.currentStep = 1;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentStep == 1) {
        return 2;
    }
    else if(self.currentStep == 2){
        return 2;
    }
    else if(self.currentStep ==3){
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (self.currentStep==1) {
        if (indexPath.row == 0) {
            cell = self.inputMobileVcodeCell;
        }
        else if(indexPath.row ==1){
            cell = self.genVCodeCell;
        }
    }
//    else if(self.currentStep == 2 ){
//        cell = self.passwordCell;
//        self.passwordInputView.promptLabel.text = @"请输入新的支付密码";
//    }
//    else if(self.currentStep ==3){
        else {
            if (indexPath.row == 0) {
                cell = self.passwordCell;
//                self.passwordInputView.promptLabel.text = @"请再次填写以确认";
            }
            else if(indexPath.row ==1){
                cell = self.confirmCell;
            }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentStep==1) {
        if (indexPath.row == 0) {
            return self.inputMobileVcodeCell.height;
        }
        else if(indexPath.row ==1){
            return 44.f;
        }
        
    }
    else{
        if (indexPath.row == 0) {
            return self.passwordInputView.height;
        }
        else if(indexPath.row ==1){
            return 44.f;
        }
        
    }
    
    return 0;
}


#pragma  mark Password input view delegate
-(void)DidFinishInput:(NSString*)inputString
{
    if(self.currentStep == 2){ //set new password
        self.nPassword = inputString;
        
        self.currentStep = 3;
        self.confirmCell.hidden = NO;
        [self.passwordInputView resetWithTitile:@"请再次填写以确认"];
        [self.passwordInputView becomeFirstResponder];
        
    }
    else if(self.currentStep == 3) { // validate new password
        if ([self.nPassword isEqualToString:inputString]) {
            self.cPassword = inputString;
            self.confirmButton.enabled = YES;
            self.confirmButton.backgroundColor = [UIColor UIColorFromRGB:0x04be02];
        }
        else {
            @weakify(self);
            [self showAlertViewWithMessage:@"两次输入的密码不一致" withCallback:^(id x){
                @strongify(self);
                self.confirmCell.hidden = YES;
                self.currentStep = 2;
                [self.passwordInputView resetWithTitile:@"请输入新的支付密码"];
                [self.passwordInputView becomeFirstResponder];
            }];
        }
    }
    
}

-(void)reloadPasswordInputCell
{
    [self.tableView beginUpdates];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

-(void)inputDidChanged:(NSString *)inputString
{
    if (self.currentStep == 3) {
        if (inputString.length<6) {
            self.confirmButton.enabled = NO;
            self.confirmButton.backgroundColor = [UIColor light_Gray_Color];
        }
    }
}

@end
