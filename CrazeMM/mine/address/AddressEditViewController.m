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
#import "DetailArea.h"
#import "DetailCity.h"
#import "DetailLocation.h"
#import "AddressInfo.h"
#import "AddressInfoUpdater.h"


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
//@property (weak, nonatomic) IBOutlet UIView *lastLine;

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic) BOOL isEditingAddr;

@property (nonatomic, strong) AddrCommonCell* receiverCell;
@property (nonatomic, strong) AddrCommonCell* mobileCell;
@property (nonatomic, strong) AddrCommonCell* addressCell;
@property (nonatomic, strong) AddrCommonCell* zipCell;
@property (nonatomic, strong) AddrCommonCell* regionCell;
@property (nonatomic, strong) AddrDefaultCheckboxCell* defaultCheckboxCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray *locData;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;


@end

@implementation AddressEditViewController

-(AddrCommonCell*)receiverCell
{
    if (!_receiverCell) {
        _receiverCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _receiverCell.titleLabel.text = @"收货人";
        //_receiverCell.textFieldCell.text = self.address.contact;
    }
    
    return _receiverCell;
}
-(AddrCommonCell*)mobileCell
{
    if (!_mobileCell) {
        _mobileCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _mobileCell.titleLabel.text = @"联系电话";
        _mobileCell.textFieldCell.keyboardType = UIKeyboardTypePhonePad;
        //_mobileCell.textFieldCell.text = self.address.mobile;
    }
    
    return _mobileCell;
}
-(AddrCommonCell*)addressCell
{
    if (!_addressCell) {
        _addressCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _addressCell.titleLabel.text = @"详细地址";
        //_addressCell.textFieldCell.text = self.address.street;
    }
    
    return _addressCell;
}
-(AddrCommonCell*)zipCell
{
    if (!_zipCell) {
        _zipCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _zipCell.titleLabel.text = @"邮政编码";
        _zipCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;
        //_zipCell.textFieldCell.text = self.address.zipCode;
    }
    
    return _zipCell;
}

-(AddrCommonCell*)regionCell
{
    if (!_regionCell) {
        _regionCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _regionCell.titleLabel.text = @"所在地区";
        //_regionCell.textFieldCell.text = self.address.region;
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
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmCell addSubview:self.confirmButton];
        
        @weakify(self);
        _confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            [self dataValidation];
            
            return [RACSignal empty];
        }];
    }
    
    return _confirmCell;
}

- (AddressInfo*)addressInfo {
    if (!_addressInfo) {
        _addressInfo = [[AddressInfo alloc] init];
    }
    return _addressInfo;
}

#pragma mark - init

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

-(instancetype)initWithAddressInfo:(AddressInfo*)addressInfo ofIndex:(NSInteger)infoIndex
{
    self = [super init];
    if (self) {
        self.isEditingAddr = YES;
        self.addressInfo = addressInfo;
        self.infoIndex = infoIndex;
    }
    
    return self;
}

#pragma mark - view load

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEditingAddr) {
        self.navigationItem.title = @"修改收货地址";
    }
    else {
        self.navigationItem.title = @"新增收货地址";
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
    [self loadAddressInfo:self.addressInfo];
    [self setupCityPicker];
    
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
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger count;
    DetailLocation *deLoc = self.locData[[self.cityPicker selectedRowInComponent:0]];
    if (component == 0) {
        count = self.locData.count;
    } else if (component == 1) {
        count = deLoc.citylist.count;
    } else if (component == 2) {
        DetailLocation *deLoc = self.locData[self.provinceIndex];
        DetailCity *deCity = deLoc.citylist[self.cityIndex];
        count = deCity.arealist.count;
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSString *title;
    if (component == 0) {
        title = [self.locData[row] provinceName];
    } else if (component == 1) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        title = [cityList[row] cityName];
    } else if (component == 2) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        NSArray *areaList = [cityList[self.cityIndex] arealist];
        title = [areaList[row] areaName];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.provinceIndex = row;
        self.cityIndex = 0; // 恢复为0
        [self.cityPicker reloadComponent:1];
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:1 animated:YES];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    } else if (component == 1) {
        self.cityIndex = row;
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    }
    
    DetailLocation *province = self.locData[self.provinceIndex];
    DetailCity *city = province.citylist[self.cityIndex];
    NSInteger areaIndex = [self.cityPicker selectedRowInComponent:2];
    DetailArea *area = city.arealist[areaIndex];
    
    self.regionCell.textFieldCell.text = [NSString stringWithFormat:@"%@,%@,%@", province.provinceName, city.cityName, area.areaName];
    //!self.editingLocationBlock ? : self.editingLocationBlock(self.regionCell.regionLabel.text);
}


- (NSArray *)locData {
    if (!_locData) {
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detaillocation" ofType:@"plist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            DetailLocation *loc = [DetailLocation detailLocationWithDict:dict];
            [newArray addObject:loc];
        }
        _locData = newArray;
    }
    return _locData;
}


#pragma mark - 属性
- (void)setupCityPicker {
    _cityPicker = [[UIPickerView alloc] init];
    _cityPicker.delegate = self;
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = [UIColor whiteColor];
    self.regionCell.textFieldCell.inputView = _cityPicker;
}


- (void)loadAddressInfo:(AddressInfo *)addressInfo {
    self.receiverCell.textFieldCell.text= addressInfo.name;
    self.mobileCell.textFieldCell.text = addressInfo.phone;
    self.regionCell.textFieldCell.text = addressInfo.province;
    self.addressCell.textFieldCell.text = addressInfo.detailAddress;
    self.zipCell.textFieldCell.text = addressInfo.zipCode;
    self.defaultCheckboxCell.checkBox.on = addressInfo.state;
}


- (void)updateAddressInfo
{
    self.addressInfo.name = self.receiverCell.textFieldCell.text;
    self.addressInfo.phone = self.mobileCell.textFieldCell.text;
    self.addressInfo.province = self.regionCell.textFieldCell.text;
    self.addressInfo.detailAddress = self.addressCell.textFieldCell.text;
    self.addressInfo.zipCode = self.zipCell.textFieldCell.text;
    self.addressInfo.state = self.defaultCheckboxCell.checkBox.on;
    
    if ( NO == self.isEditingAddr )
    {
        if (NO == self.addressInfo.state)
        {
            [AddressInfoUpdater addInfo:self.addressInfo];
        }
        else
        {
            [AddressInfoUpdater updateInfoforDefaultAddr:self.addressInfo];
        }
    }
    else
    {
        if (NO == self.addressInfo.state)
        {
            [AddressInfoUpdater updateInfoAtIndex:self.infoIndex withInfo:self.addressInfo];
        }
        else
        {
            [AddressInfoUpdater removeInfoAtIndex:self.infoIndex];
            [AddressInfoUpdater updateInfoforDefaultAddr:self.addressInfo];
        }
    }

}

- (void) dataValidation
{
     NSString *message;
    if (0 == self.receiverCell.textFieldCell.text.length)
    {
        message = @"收货人姓名不能是空";
    }
    else if (0 == self.mobileCell.textFieldCell.text.length)
    {
        message = @"收货人手机号码不能是空";
    }
    else if (0 == self.regionCell.textFieldCell.text.length)
    {
        message = @"请选择所在地区";
    }
    else if (0 == self.addressCell.textFieldCell.text.length)
    {
        message = @"地址不能是空";
    }
    else if (0 == self.zipCell.textFieldCell.text.length)
    {
        message = @"邮政编码不能是空";
    }
    
    if (message)
    {
        [self showAlertViewWithMessage:message];
    }
    else
    {
        [self updateAddressInfo];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
