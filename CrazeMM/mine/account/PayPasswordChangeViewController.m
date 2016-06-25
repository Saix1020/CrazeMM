//
//  PayPasswordChangeViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayPasswordChangeViewController.h"
#import "HttpBalance.h"

@interface PayPasswordChangeViewController ()

@property (nonatomic, strong) UITableViewCell* passwordCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;

@property (nonatomic, strong) PasswordInputView* passwordInputView;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic) NSInteger currentStep;
@property (nonatomic, strong) NSString* oPassword;
@property (nonatomic, strong) NSString* nPassword;
@property (nonatomic, strong) NSString* cPassword;

@end

@implementation PayPasswordChangeViewController


-(PasswordInputView*)passwordInputView
{
    if (!_passwordInputView) {
        _passwordInputView = (PasswordInputView*)[UINib viewFromNib:@"PasswordInputView"];
//        _passwordInputView.width = [UIScreen mainScreen].bounds.size.width;
//        _passwordInputView.height = 116.f;
        _passwordInputView.delegate = self;
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
    HttpBalanceModifyPayPwdRequest* request = [[HttpBalanceModifyPayPwdRequest alloc] initWithOrignalPassword:self.oPassword andNewPassword:self.nPassword andConfirmPassword:self.cPassword];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.currentStep = 1;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    @weakify(self)
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self showAlertViewWithMessage:@"放弃修改密码吗?"
                        withOKCallback:^(id x){
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                     andCancelCallback:nil];
        return [RACSignal empty];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.currentStep==3) {
//        return 2;
//    }
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell;
    if (indexPath.row==0) {
        cell = self.passwordCell;
        if (self.currentStep==1) {
            self.passwordInputView.promptLabel.text = @"请输入旧的支付密码";
        }
        else if (self.currentStep==2) {
            self.passwordInputView.promptLabel.text = @"请输入新的支付密码";
        }
        else if (self.currentStep==3) {
            self.passwordInputView.promptLabel.text = @"请再次填写以确认";
        }
        

    }
    if (indexPath.row == 1) {
        cell = self.confirmCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.passwordInputView.height;
}


#pragma  mark Password input view delegate
-(void)DidFinishInput:(NSString*)inputString
{
    // validate orignal password
    if (self.currentStep == 1) {
        [self.passwordInputView resignFirstResponder];
        HttpBalanceValidatePwdRequest* request = [[HttpBalanceValidatePwdRequest alloc] initWithOrignalPassword:inputString];
        [self showProgressIndicatorWithTitle:@"正在验证支付密码..."];
        [request request]
        .then(^(id responseObj){
            if (request.response.ok) {
                self.oPassword = inputString;
                self.currentStep = 2;
                [self.passwordInputView resetWithTitile:@"请输入新的支付密码"];
            }
            else {
                [self.passwordInputView reset];
                [self showAlertViewWithMessage:request.response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self.passwordInputView reset];
            [self showAlertViewWithMessage:error.localizedDescription];
        })
        .finally(^(){
            [self dismissProgressIndicator];
            [self.passwordInputView becomeFirstResponder];
        });
    }
    else if(self.currentStep == 2){ //set new password
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
