//
//  PersonalPhoneViewContoller.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PersonalPhoneViewContoller.h"
#import "InfoLabelCell.h"
#import "InfoFieldCell.h"
#import "NSString+Utils.h"
#import "HttpGenMobileVcodeForUser.h"
#import "HttpMobileExistCheckRequest.h"
#import "HttpGenMobileVcodeRequest.h"
#import "HttpRegisterNewMobile.h"


@interface PersonalPhoneViewContoller ()

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) InfoLabelCell* orignalPhoneCell;
@property (nonatomic, strong) InfoFieldCell* originalCodeCell;
@property (nonatomic, strong) InfoFieldCell* newxCodeCell;
@property (nonatomic, strong) InfoFieldCell* newxPhoneCell;

@property (nonatomic, strong) NSArray* cellArray;

@property (nonatomic, readonly) NSString* orignalMobile;
@end


@implementation PersonalPhoneViewContoller

+(CGFloat)titleWidth
{
    return [@"原手机号" boundingWidthWithFont:[UIFont systemFontOfSize:16.f]].width;
}

-(NSString*)orignalMobile
{
    return [UserCenter defaultCenter].mobile;
}

-(InfoLabelCell*)orignalPhoneCell
{
    if (!_orignalPhoneCell) {
        _orignalPhoneCell = [[InfoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_orignalPhoneCell"];
        
        _orignalPhoneCell.titleLabel.text = @"原手机号";
        _orignalPhoneCell.titleWidth = [PersonalPhoneViewContoller titleWidth];
        _orignalPhoneCell.infoLabel.text = [self.orignalMobile stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
        
    }
    
    return _orignalPhoneCell;
}

-(InfoFieldCell*)originalCodeCell
{
    if (!_originalCodeCell) {
        _originalCodeCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_originalCodeCell"];
        _originalCodeCell.titleLabel.text = @"验证码";
        _originalCodeCell.needButton = YES;
        _originalCodeCell.infoField.keyboardType = UIKeyboardTypeNumberPad;
        _originalCodeCell.titleWidth = [PersonalPhoneViewContoller titleWidth];
        
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
        _newxCodeCell.titleWidth = [PersonalPhoneViewContoller titleWidth];
        [_newxCodeCell addTarget:self action:@selector(genMobileVcode:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _newxCodeCell;
}

-(InfoFieldCell*)newxPhoneCell
{
    if (!_newxPhoneCell) {
        _newxPhoneCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_newxPhoneCell"];
        _newxPhoneCell.titleLabel.text = @"新手机号";
        _newxPhoneCell.needButton = NO;
        _newxPhoneCell.infoField.keyboardType = UIKeyboardTypeNumberPad;
        _newxPhoneCell.titleWidth = [PersonalPhoneViewContoller titleWidth];

    }
    
    return _newxPhoneCell;
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
        [button startTiming];

        HttpGenMobileVcodeForUserRequest* request = [[HttpGenMobileVcodeForUserRequest alloc] init];
        [request request].then(^(id responseObj){
            
            HttpGenMobileVcodeForUserResponse* response = (HttpGenMobileVcodeForUserResponse*)request.response;
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
        if(self.orignalMobile.length!=0){
            if(self.originalCodeCell.value.length!=6){
                [self showAlertViewWithMessage:@"请输入原手机号6位数字验证码"];
                return;
            }
        }
        
        if(self.newxPhoneCell.value.length!=11){
            [self showAlertViewWithMessage:@"请输入新的正确格式11位手机号"];
            return;

        }
        
        [button startTiming];

        NSString* mobile = self.newxPhoneCell.value;
        HttpMobileExistCheckRequest* existCheckRequest = [[HttpMobileExistCheckRequest alloc] initWithMobile:mobile];
        [existCheckRequest request].then(^(id responseObj){
            HttpMobileExistCheckResponse* existCheckResponse = (HttpMobileExistCheckResponse*)existCheckRequest.response;
            if(existCheckResponse.ok){
                HttpGenMobileVcodeRequest* genRequest = [[HttpGenMobileVcodeRequest alloc] initWithMobile:mobile];
                [genRequest request].then(^(id responseObj2){
                    HttpGenMobileVcodeResponse* genResponse = (HttpGenMobileVcodeResponse*)genRequest.response;
                    if(genResponse.ok){
                        [UserCenter defaultCenter].userInfoDto.mobile = mobile;

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
    BaseHttpRequest* request;
    
    if(self.orignalMobile.length == 0){
        request = [[HttpRegisterNewMobileRequest alloc] initWithNewMobile:self.newxPhoneCell.value
                                                      andCaptchaMobileNew:self.newxCodeCell.value
                                                  andCaptchaMobileOrignal:@""];
    }
    else {
        request = [[HttpRegisterNewMobileRequest alloc] initWithNewMobile:self.newxPhoneCell.value
                                                      andCaptchaMobileNew:self.newxCodeCell.value
                                                  andCaptchaMobileOrignal:self.originalCodeCell.value];
    }
    
    [request request].then(^(id responseObj){
        if (request.response.ok) {
            @weakify(self);
            [self showAlertViewWithMessage:@"手机号码修改成功" withCallback:^(id x){
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
    self.navigationItem.title = @"绑定手机号修改";
    self.tableView.backgroundColor = [UIColor tableViewBackgroundColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if(self.orignalMobile.length == 0){
        self.cellArray = @[self.newxPhoneCell, self.newxCodeCell, self.confirmCell];
    }
    else {
        self.cellArray = @[self.orignalPhoneCell, self.originalCodeCell,
                           self.newxPhoneCell, self.newxCodeCell, self.confirmCell];
    }
    
    self.navigationController.confirmString = @"确定放弃修改吗?";
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    @weakify(self);
    NSArray* allTextSignals;
    RACSignal* enableSaveButtonSignal;
    if(self.orignalMobile.length == 0){
        allTextSignals = @[self.newxCodeCell.infoField.rac_textSignal, self.newxPhoneCell.infoField.rac_textSignal];
        enableSaveButtonSignal = [RACSignal combineLatest:allTextSignals
                                                   reduce:^id(NSString* newCode, NSString* newPhone){
                                                       return @(newCode.length==6
                                                       && newPhone.length==11);
                                                   }];

    }
    else {
        allTextSignals = @[self.originalCodeCell.infoField.rac_textSignal, self.newxCodeCell.infoField.rac_textSignal, self.newxPhoneCell.infoField.rac_textSignal];
        enableSaveButtonSignal = [RACSignal combineLatest:allTextSignals
                                                              reduce:^id(NSString* originalCode, NSString* newCode, NSString* newPhone){
                                                                  return @(originalCode.length==6 && newCode.length==6
                                                                  && newPhone.length==11);
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
