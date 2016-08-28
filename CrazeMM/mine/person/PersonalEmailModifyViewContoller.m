//
//  PersonalEmailModifyViewContoller.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PersonalEmailModifyViewContoller.h"
#import "InfoLabelCell.h"
#import "InfoFieldCell.h"
#import "HttpGenEmailVcode.h"
#import "HttpGenEmailVcodeForUser.h"
#import "HttpRegisterNewEmail.h"

@interface PersonalEmailModifyViewContoller ()

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) InfoLabelCell* orignalEmailCell;
@property (nonatomic, strong) InfoFieldCell* originalCodeCell;
@property (nonatomic, strong) InfoFieldCell* newxEmailCell;
@property (nonatomic, strong) InfoFieldCell* newxCodeCell;

@property (nonatomic, strong) NSArray* cellArray;

@property (nonatomic, readonly) NSString* orignalEmail;


@end

@implementation PersonalEmailModifyViewContoller

-(CGFloat)titleWidth
{
    return [@"原邮箱" boundingWidthWithFont:[UIFont systemFontOfSize:16.f]].width;
}

-(NSString*)orignalEmail
{
    return [UserCenter defaultCenter].email;
}

-(InfoLabelCell*)orignalEmailCell
{
    if (!_orignalEmailCell) {
        _orignalEmailCell = [[InfoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_orignalEmailCell"];
        
        _orignalEmailCell.titleLabel.text = @"原邮箱";
        _orignalEmailCell.titleWidth = [self titleWidth];
        _orignalEmailCell.infoLabel.text = self.orignalEmail;
        
    }
    
    return _orignalEmailCell;
}

-(InfoFieldCell*)originalCodeCell
{
    if (!_originalCodeCell) {
        _originalCodeCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_originalCodeCell"];
        _originalCodeCell.titleLabel.text = @"验证码";
        _originalCodeCell.needButton = YES;
        _originalCodeCell.infoField.keyboardType = UIKeyboardTypeNumberPad;
        _originalCodeCell.titleWidth = [self titleWidth];
        
        [_originalCodeCell addTarget:self action:@selector(genMobileVcode:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _originalCodeCell;
}



-(InfoFieldCell*)newxCodeCell
{
    if (!_newxCodeCell) {
        _newxCodeCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_newxCodeCell"];
        _newxCodeCell.titleLabel.text = @"验证码";
        _newxCodeCell.needButton = YES;
        _newxCodeCell.infoField.keyboardType = UIKeyboardTypeNumberPad;
        _newxCodeCell.titleWidth = [self titleWidth];
        [_newxCodeCell addTarget:self action:@selector(genMobileVcode:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _newxCodeCell;
}

-(InfoFieldCell*)newxEmailCell
{
    if (!_newxEmailCell) {
        _newxEmailCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_newxEmailCell"];
        _newxEmailCell.titleLabel.text = @"新邮箱";
        _newxEmailCell.needButton = NO;
        _newxEmailCell.titleWidth = [self titleWidth];
        
    }
    
    return _newxEmailCell;
}

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
        [_confirmButton setTitle:@"确认修改" forState:UIControlStateDisabled];
        
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _confirmButton.frame = CGRectMake(16.f, 40.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        [_confirmCell addSubview:self.confirmButton];
        
        [_confirmButton addTarget:self action:@selector(saveChanges:) forControlEvents:UIControlEventTouchUpInside];
        _confirmCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _confirmButton.enabled = NO;
        _confirmCell.backgroundColor = [UIColor clearColor];
        
    }
    return _confirmCell;
}

-(void)genMobileVcode:(TimeoutButton*)button
{
    if(button == self.originalCodeCell.button){
        button.startTimer = YES;
        HttpGenEmailVcodeForUserRequest* request = [[HttpGenEmailVcodeForUserRequest alloc] init];
        [request request].then(^(id responseObj){
            
            HttpGenEmailVcodeForUserResponse* response = (HttpGenEmailVcodeForUserResponse*)request.response;
            if(response.ok){
                [self showAlertViewWithMessage:response.description];
            }
            else {
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }
    else {
        if(self.orignalEmail.length!=0){
            if(self.originalCodeCell.value.length!=6){
                [self showAlertViewWithMessage:@"请输入原邮箱6位数字验证码"];
                return;
            }
        }
        if(![self.newxEmailCell.value isValidEmail]){
            [self showAlertViewWithMessage:@"请输入新的正确格式邮箱地址"];
            return;

        }
        
        NSString* email = self.newxEmailCell.value;
        
        HttpEmailExistCheckRequest* existCheckRequest = [[HttpEmailExistCheckRequest alloc] initWithEmail:email];
        [existCheckRequest request].then(^(id responseObj){
            HttpEmailExistCheckResponse* existCheckResponse = (HttpEmailExistCheckResponse*)existCheckRequest.response;
            if(existCheckResponse.ok){
                button.startTimer = YES;
                HttpGenEmailVcodeRequest* genRequest = [[HttpGenEmailVcodeRequest alloc] initWithEmail:email];
                [genRequest request].then(^(id responseObj2){
                    HttpGenEmailVcodeResponse* genResponse = (HttpGenEmailVcodeResponse*)genRequest.response;
                    if(genResponse.ok){
                        [self showAlertViewWithMessage:genResponse.description];
                    }
                    else {
                        [self showAlertViewWithMessage:genResponse.errorMsg];
                    }
                })
                .catch(^(NSError* error){
                    [self showAlertViewWithMessage:error.localizedDescription];
                });
            }
            else {
                [self showAlertViewWithMessage:existCheckResponse.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
        
    }
}

-(void)saveChanges:(UIButton*)button
{
    HttpRegisterNewEmailRequest* request = [[HttpRegisterNewEmailRequest alloc] initWithNewEmail:self.newxEmailCell.value andCaptchaEmailNew:self.newxCodeCell.value andCaptchaEmailOrignal:self.originalCodeCell.value];
    [request request].then(^(id responseObj){
        if (request.response.ok) {
            @weakify(self);
            [self showAlertViewWithMessage:@"邮箱修改成功" withCallback:^(id x){
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"绑定邮箱修改";
    self.tableView.backgroundColor = [UIColor tableViewBackgroundColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(self.orignalEmail.length == 0){
        self.cellArray = @[self.newxEmailCell, self.newxCodeCell, self.confirmCell];
    }
    else {
        self.cellArray = @[self.orignalEmailCell, self.originalCodeCell,
                           self.newxEmailCell, self.newxCodeCell, self.confirmCell];
    }
    
    self.navigationController.confirmString = @"确定放弃修改吗?";
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    @weakify(self);
    NSArray* allTextSignals;
    RACSignal* enableSaveButtonSignal;
    if(self.orignalEmail.length == 0){
        allTextSignals = @[self.newxCodeCell.infoField.rac_textSignal, self.newxEmailCell.infoField.rac_textSignal];
        enableSaveButtonSignal = [RACSignal combineLatest:allTextSignals
                                                   reduce:^id(NSString* newCode, NSString* newEmail){
                                                       return @(newCode.length==6
                                                       && [newEmail isValidEmail]);
                                                   }];
        
    }
    else {
        allTextSignals = @[self.originalCodeCell.infoField.rac_textSignal, self.newxCodeCell.infoField.rac_textSignal, self.newxEmailCell.infoField.rac_textSignal];
        enableSaveButtonSignal = [RACSignal combineLatest:allTextSignals
                                                   reduce:^id(NSString* originalCode, NSString* newCode, NSString* newEmail){
                                                       return @(originalCode.length==6 && newCode.length==6
                                                       && [newEmail isValidEmail]);
                                                   }];
        
    }
    
    [enableSaveButtonSignal subscribeNext:^(NSNumber* enable){
        @strongify(self);
        self.confirmButton.enabled = [enable boolValue];
        if(![enable boolValue]){
            self.confirmButton.backgroundColor = [UIColor buttonDisableBackgroundColor];
            [self.confirmButton setTitleColor: [UIColor buttonDisableTextColor]  forState:UIControlStateDisabled];
            
        }
        else {
            self.confirmButton.backgroundColor = [UIColor buttonEnableBackgroundColor];
            [self.confirmButton setTitleColor: [UIColor buttonEnableTextColor]  forState:UIControlStateNormal];
            
        }
    }];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.cellArray.count-1) {
        return 80.f;
    }
    
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = self.cellArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
