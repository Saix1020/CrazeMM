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

@interface PersonalPhoneViewContoller ()

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) InfoLabelCell* orignalPhoneCell;
@property (nonatomic, strong) InfoFieldCell* originalCodeCell;
@property (nonatomic, strong) InfoFieldCell* newxCodeCell;
@property (nonatomic, strong) InfoFieldCell* newxPhoneCell;

@property (nonatomic, strong) NSArray* cellArray;

@end


@implementation PersonalPhoneViewContoller

+(CGFloat)titleWidth
{
    return [@"原手机号" boundingWidthWithFont:[UIFont systemFontOfSize:16.f]].width;
}

-(InfoLabelCell*)orignalPhoneCell
{
    if (!_orignalPhoneCell) {
        _orignalPhoneCell = [[InfoLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_orignalPhoneCell"];
        
        _orignalPhoneCell.titleLabel.text = @"原手机号";
        _orignalPhoneCell.titleWidth = [PersonalPhoneViewContoller titleWidth];
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

-(void)saveChanges:(UIButton*)button
{
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息修改";
    self.tableView.backgroundColor = [UIColor tableViewBackgroundColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.cellArray = @[self.orignalPhoneCell, self.originalCodeCell,
                  self.newxPhoneCell, self.newxCodeCell, self.confirmCell];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    @weakify(self);
    RACSignal* enableSaveButtonSignal = [RACSignal combineLatest:@[self.originalCodeCell.infoField.rac_textSignal, self.newxCodeCell.infoField.rac_textSignal, self.newxPhoneCell.infoField.rac_textSignal
                                                                   ]
                                                          reduce:^id(NSString* originalCode, NSString* newCode, NSString* newPhone){
                                                              return @(originalCode.length>0 && newCode.length>0
                                                              && newPhone.length>0);
                                                          }];
    
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
