//
//  ConsigneeAddViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ConsigneeAddViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AddrCommonCell.h"
#import "HttpConsignee.h"

@interface ConsigneeAddViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) AddrCommonCell* nameCell;
@property (nonatomic, strong) AddrCommonCell* identityCell;
@property (nonatomic, strong) AddrCommonCell* mobileCell;
@property (nonatomic, strong) ConsigneeDTO* consigneeDto;

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@end

@implementation ConsigneeAddViewController

-(instancetype)initWithConsigneeDTO:(ConsigneeDTO*)dto
{
    self = [self init];
    if (self) {
        self.consigneeDto = dto;
    }
    return self;
}

-(AddrCommonCell*)nameCell
{
    if (!_nameCell) {
        _nameCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _nameCell.titleLabel.text = @"姓名";
        _nameCell.value = self.consigneeDto.name;
        _nameCell.placehoder = @"请输入姓名";
        _nameCell.textFieldCell.delegate = self;
    }
    
    return _nameCell;
}

-(AddrCommonCell*)identityCell
{
    if (!_identityCell) {
        _identityCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _identityCell.titleLabel.text = @"身份证号";
        _identityCell.value = self.consigneeDto.identity;
        _identityCell.placehoder = @"请输入身份证号";
        _identityCell.textFieldCell.delegate = self;
        _identityCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;


    }
    
    return _identityCell;
}


-(AddrCommonCell*)mobileCell
{
    if (!_mobileCell) {
        _mobileCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _mobileCell.titleLabel.text = @"手机";
        _mobileCell.value = self.consigneeDto.mobile;
        _mobileCell.placehoder = @"请输入手机号码";
        _mobileCell.textFieldCell.delegate = self;
        _mobileCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _mobileCell;
}

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        [_confirmCell addSubview:self.confirmButton];
    }
    
    return _confirmCell;
}

-(UIButton*)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _confirmButton.frame = CGRectMake(16.f, 40.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        [_confirmButton addTarget:self action:@selector(saveConsignee:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _confirmButton;
}

-(void)saveConsignee:(id)sender
{
    [self.view endEditing:YES];
    
    HttpSaveConsigneeRequest* request = [[HttpSaveConsigneeRequest alloc] initWithName:self.nameCell.value
                                                                           andIdentity:self.identityCell.value andMobile:self.mobileCell.value];
    [request request]
    .then(^(id responseObj){
        @weakify(self);
        if (request.response.ok) {
            [self showAlertViewWithMessage:@"保存自提人信息成功" withCallback:^(id x){
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg withCallback:^(id x){
                @strongify(self);
//                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    })
    .catch(^(NSError* error){
        @weakify(self);
        [self showAlertViewWithMessage:error.localizedDescription withCallback:^(id x){
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.consigneeDto) {
        self.navigationItem.title = @"修改自提人信息";
        self.navigationController.confirmString = @"您确定放弃修改吗?";
    }
    else{
        self.navigationItem.title = @"添加自提人";
        self.navigationController.confirmString = @"您确定放弃添加吗?";
    }
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = self.view.frame;
    
    @weakify(self);
    
    RACSignal* enableSaveButtonSignal = [RACSignal combineLatest:@[self.nameCell.textFieldCell.rac_textSignal,
                                                                   self.identityCell.textFieldCell.rac_textSignal,
                                                                   self.mobileCell.textFieldCell.rac_textSignal,
                                                                   ]
                                                          reduce:^id(NSString* name, NSString* identity, NSString* mobile){
                                                              return @(name.length>0 && mobile.length>0);
                                                          }];
    
    [enableSaveButtonSignal subscribeNext:^(NSNumber* enable){
        @strongify(self);
        self.confirmButton.enabled = [enable boolValue];
        if(![enable boolValue]){
            self.confirmButton.backgroundColor = [UIColor light_Gray_Color];
            [self.confirmButton setTitleColor: RGBCOLOR(150, 150, 150)  forState:UIControlStateDisabled];
            
        }
        else {
            self.confirmButton.backgroundColor = [UIColor greenTextColor];
            [self.confirmButton setTitleColor: [UIColor whiteColor]  forState:UIControlStateNormal];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 100.f;
    }
    return 44.f;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    switch (indexPath.row) {
        case 0:
            cell = self.nameCell;
            break;
        case 1:
            cell = self.identityCell;
            break;
        case 2:
            cell = self.mobileCell;
            break;
        case 3:
            cell = self.confirmCell;
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void)

@end
