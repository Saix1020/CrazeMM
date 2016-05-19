//
//  AddressEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressEditViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "AddrDefaultCheckboxCell.h"

typedef NS_ENUM(NSInteger, AddrEditingTableViewRow){
    kRowUseless = 0,
    kRowReceiver = 1,
    kRowMobile,
    kRowRegion,
    kRowAddress,
    kRowZip,
    kRowDefaultSetting,
    kRowSave,
    kRowMax
};

@interface AddressEditViewController ()
@property (weak, nonatomic) IBOutlet UIView *lastLine;

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic) BOOL isEditingAddr;

@property (nonatomic, strong) AddrCommonCell* receiverCell;
@property (nonatomic, strong) AddrCommonCell* mobileCell;
@property (nonatomic, strong) AddrCommonCell* addressCell;
@property (nonatomic, strong) AddrCommonCell* zipCell;
@property (nonatomic, strong) AddrRegionCell* regionCell;
@property (nonatomic, strong) AddrDefaultCheckboxCell* defaultCheckboxCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;


@end

@implementation AddressEditViewController

-(AddrCommonCell*)receiverCell
{
    if (!_receiverCell) {
        _receiverCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _receiverCell.titleLabel.text = @"收货人";
        _receiverCell.textFieldCell.text = self.address.contact;
    }
    
    return _receiverCell;
}
-(AddrCommonCell*)mobileCell
{
    if (!_mobileCell) {
        _mobileCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _mobileCell.titleLabel.text = @"联系电话";
        _mobileCell.textFieldCell.keyboardType = UIKeyboardTypePhonePad;
        _mobileCell.textFieldCell.text = self.address.mobile;
    }
    
    return _mobileCell;
}
-(AddrCommonCell*)addressCell
{
    if (!_addressCell) {
        _addressCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _addressCell.titleLabel.text = @"详细地址";
        _addressCell.textFieldCell.text = self.address.street;
    }
    
    return _addressCell;
}
-(AddrCommonCell*)zipCell
{
    if (!_zipCell) {
        _zipCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _zipCell.titleLabel.text = @"邮政编码";
        _zipCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _zipCell;
}

-(AddrRegionCell*)regionCell
{
    if (!_regionCell) {
        _regionCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _regionCell.titleLabel.text = @"所在地区";
        _regionCell.regionLabel.text = self.address.region;
    }
    
    return _regionCell;
}

-(AddrDefaultCheckboxCell*)defaultCheckboxCell
{
    if (!_defaultCheckboxCell) {
        _defaultCheckboxCell = (AddrDefaultCheckboxCell*)[UINib viewFromNib:@"AddrDefaultCheckboxCell"];
        _defaultCheckboxCell.checkBox.boxType = BEMBoxTypeSquare;
    }
    
    return _defaultCheckboxCell;
}

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 40.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
    }
    
    return _confirmCell;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.isEditingAddr = NO;
    }
    
    return self;
}

-(instancetype)initWithAddress:(AddressDTO*)address
{
    self = [super init];
    if (self) {
        self.isEditingAddr = YES;
        self.address = address;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEditingAddr) {
        self.navigationItem.title = @"修改收货地址";
    }
    else {
        self.navigationItem.title = @"新增收货地址";
    }
    
    @weakify(self);
    self.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    self.regionCell.chooseButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        CityListViewController* vc = [[CityListViewController alloc] init];
        vc.delegete = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        return [RACSignal empty];
    }];
    
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
    
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

#pragma -- mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kRowMax;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kRowSave) {
        return 120.f;
    }
    else if(indexPath.row == kRowUseless){
        return 8.f;
    }
    else {
        return 48.f;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    switch (indexPath.row) {
        case kRowUseless:
            cell = [[UITableViewCell alloc] init];
            cell.height = 0;
            break;
        case kRowReceiver:
            cell = self.receiverCell;
            break;
        case kRowMobile:
            cell = self.mobileCell;
            break;
        case kRowRegion:
            cell = self.regionCell;
            break;
        case kRowAddress:
            cell = self.addressCell;
            break;
        case kRowZip:
            cell = self.zipCell;
            break;
        case kRowDefaultSetting:
            cell = self.defaultCheckboxCell;
            break;
        case kRowSave:
        default:
            cell = self.confirmCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




#pragma -- City list vc delegate
- (void)didSelectCityWithName:(NSString *)cityName
{
    self.regionCell.regionLabel.text = cityName;
}

@end
