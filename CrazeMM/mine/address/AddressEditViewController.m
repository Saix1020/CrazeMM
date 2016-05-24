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
#import "RegionDTO.h"
#import "HttpAllRegion.h"
#import "HttpAddress.h"


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
@property (nonatomic, strong) AddrCommonCell* regionCell;
@property (nonatomic, strong) AddrDefaultCheckboxCell* defaultCheckboxCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray* regionDto;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;
@property (nonatomic, strong) RegionDTO* selectedRegionDto;
@property (nonatomic, strong) CityDTO* selectedCityDto;
@property (nonatomic, strong) AreaDTO* selectedAreaDto;

@end

@implementation AddressEditViewController

-(AddrCommonCell*)receiverCell
{
    if (!_receiverCell) {
        _receiverCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _receiverCell.titleLabel.text = @"收货人";
        _receiverCell.value = self.address.contact;

    }
    
    return _receiverCell;
}
-(AddrCommonCell*)mobileCell
{
    if (!_mobileCell) {
        _mobileCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _mobileCell.titleLabel.text = @"联系电话";
        _mobileCell.value = self.address.mobile;

    }
    
    return _mobileCell;
}
-(AddrCommonCell*)addressCell
{
    if (!_addressCell) {
        _addressCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _addressCell.titleLabel.text = @"详细地址";
        _addressCell.value = self.address.street;
    }
    
    return _addressCell;
}
-(AddrCommonCell*)zipCell
{
    if (!_zipCell) {
        _zipCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _zipCell.titleLabel.text = @"邮政编码";
        _zipCell.value = self.address.zipCode;
    }
    
    return _zipCell;
}

-(AddrCommonCell*)regionCell
{
    if (!_regionCell) {
        _regionCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _regionCell.title = @"所在地区";
        _regionCell.placehoder = @"请选择所在区域";
        _regionCell.tintColor = [UIColor clearColor];
        _regionCell.textFieldCell.delegate = self;
        _regionCell.value = self.address.region;

    }
    
    return _regionCell;
}

-(AddrDefaultCheckboxCell*)defaultCheckboxCell
{
    if (!_defaultCheckboxCell) {
        _defaultCheckboxCell = (AddrDefaultCheckboxCell*)[UINib viewFromNib:@"AddrDefaultCheckboxCell"];
        _defaultCheckboxCell.checkBox.boxType = BEMBoxTypeSquare;
        _defaultCheckboxCell.checkBox.animationDuration = 0.f;
        _defaultCheckboxCell.checkBox.on = self.address.isDefault;
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
//        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
//
//        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 40.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
//        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        
        [_confirmButton addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
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

-(instancetype)initWithAddress:(AddrDTO*)address
{
    self = [super init];
    if (self) {
        self.isEditingAddr = YES;
        self.address = address;
    }
    
    return self;
}

-(void)saveAddress:(id)sender
{
//    @"address.contact" : addrDto.contact,
//    @"address.mobile" : addrDto.mobile,
//    @"address.pid" : @(addrDto.pid),
//    @"address.cid": @(addrDto.cid),
//    @"address.did": @(addrDto.did),
//    @"address.street": addrDto.street,
//    @"address.zipCode" : addrDto.zipCode,
//    @"address.isDefault" : @(addrDto.isDefault)

    AddrDTO* newAddrDTO = [[AddrDTO alloc] init];
    newAddrDTO.contact = self.receiverCell.value;
    newAddrDTO.mobile = self.mobileCell.value;
    newAddrDTO.pid = self.selectedRegionDto.id;
    newAddrDTO.cid = self.selectedCityDto.id;
    newAddrDTO.did = self.selectedAreaDto.id;
    newAddrDTO.street =self.addressCell.value;
    newAddrDTO.zipCode = self.zipCell.value;
    newAddrDTO.isDefault = self.defaultCheckboxCell.checkBox.on;
    if (self.isEditingAddr) {
        // not support yet
        newAddrDTO.uid = self.address.uid;
    }
    else {
        newAddrDTO.uid = -1;
    }
    HttpAddressSaveRequest* request = [[HttpAddressSaveRequest alloc] initWithAddrDto:newAddrDTO];
    [request request]
    .then(^(id responseObj){
        if (!request.response.ok) {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];

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
    
    if (self.isEditingAddr) {
        self.navigationItem.title = @"修改收货地址";
        self.confirmButton.enabled = YES;
    }
    else {
        self.navigationItem.title = @"新增收货地址";
        self.confirmButton.enabled = NO;
    }
    
    @weakify(self);
    self.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    HttpAllRegionRequest* request = [[HttpAllRegionRequest alloc] init];
    self.regionCell.textFieldCell.enabled = NO;
    [request request]
    .then(^(id responseObj){
        if (request.response.ok) {
            HttpAllRegionResponse* response = (HttpAllRegionResponse*)request.response;
            self.regionDto = response.regionDtos;
            
            [self setupCityPicker];
            self.regionCell.textFieldCell.enabled = YES;
            if (self.address){
                self.selectedRegionDto = [self findRegion];
                self.selectedCityDto = [self findCity];
                self.selectedAreaDto = [self findArea];
                self.provinceIndex = [self.regionDto indexOfObject:self.selectedRegionDto];
                self.cityIndex = [self.selectedRegionDto.cities indexOfObject:self.selectedCityDto];
                self.areaIndex = [self.selectedCityDto.areas indexOfObject:self.selectedAreaDto];
                
                [self.cityPicker selectRow:self.provinceIndex inComponent:0 animated:NO];
                [self.cityPicker selectRow:self.cityIndex inComponent:1 animated:NO];
                [self.cityPicker selectRow:self.areaIndex inComponent:2 animated:NO];
                
                self.regionCell.textFieldCell.text = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto.name];
            }
            

        }
        else {
            //[self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        //[self showAlertViewWithMessage:error.localizedDescription];
    });

    
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
//    @weakify(self);
}

-(RegionDTO*)findRegion
{
    NSInteger found = NSNotFound;
    
    for (NSInteger index = 0; index < self.regionDto.count; ++index) {
        AddrDTO* dto = self.regionDto[index];
        if (dto.id == self.address.pid) {
            found = index;
            break;
        }
    }
    return found==NSNotFound?nil : self.regionDto[found];
}

-(CityDTO*)findCity
{
    NSInteger found = NSNotFound;
    RegionDTO* region = [self findRegion];
    if (!region){
        return nil;
    }
    NSArray* cities = region.cities;
    for (NSInteger index = 0; index<cities.count; ++index) {
        CityDTO* city = cities[index];
        if (city.id == self.address.cid){
            found = index;
            break;
        }
    }
    return found == NSNotFound? nil : cities[found];
}

-(AreaDTO*)findArea
{
    CityDTO* city = [self findCity];
    if (!city){
        return nil;
    }
    
    NSArray* ares = city.areas;
    for (NSInteger index = 0; index<ares.count; ++index) {
        AreaDTO* area = ares[index];
        if (area.id == self.address.did){
            return area;
        }
    }
    return nil;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    @weakify(self);
    RACSignal* enableSaveButtonSignal = [RACSignal combineLatest:@[self.receiverCell.textFieldCell.rac_textSignal,
                                                                   self.mobileCell.textFieldCell.rac_textSignal,
                                                                   self.addressCell.textFieldCell.rac_textSignal,
                                                                   self.regionCell.textFieldCell.rac_textSignal,
                                                                   self.zipCell.textFieldCell.rac_textSignal]
                                                          reduce:^id(NSString* receiver, NSString* mobile, NSString* addr,
                                                                     NSString* region, NSString* zipCode){
                                                              return @(receiver.length>0 && mobile.length>0
                                                              && addr.length>0 && region.length>0 && zipCode.length>0);
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupCityPicker {
    _cityPicker = [[UIPickerView alloc] init];
    _cityPicker.delegate = self;
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = [UIColor whiteColor];
    self.regionCell.textFieldCell.inputView = _cityPicker;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger count = 0;
    if (!self.regionDto) {
        return 0;
    }
    
    switch (component) {
        case 0:
            count = self.regionDto.count;
            break;
        case 1:
        {
            NSArray* cities = ((RegionDTO*)self.regionDto[self.provinceIndex]).cities;
            count = cities.count;
        }
            break;
        case 2:
        {
            NSArray* cities = ((RegionDTO*)self.regionDto[self.provinceIndex]).cities;
            NSArray* areas = ((CityDTO*)cities[self.cityIndex]).areas;
            count = areas.count;
        }
            break;
        default:
            break;
    }
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSString *title;
    if (component == 0){
        RegionDTO* region = self.regionDto[row];
        title = region.name;
    }
    else if (component == 1) {
        RegionDTO* region = self.regionDto[self.provinceIndex];
        CityDTO* city = region.cities[row];
        title = city.name;
    }
    else if (component == 2) {
        RegionDTO* region = self.regionDto[self.provinceIndex];
        CityDTO* city = region.cities[self.cityIndex];
        AreaDTO* area = city.areas[row];
        title = area.name;
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
    
    self.selectedRegionDto = self.regionDto[self.provinceIndex];
    self.selectedCityDto = self.selectedRegionDto.cities[self.cityIndex];
    NSInteger areaIndex = [self.cityPicker selectedRowInComponent:2];
    self.areaIndex = areaIndex;
    self.selectedAreaDto = self.selectedCityDto.areas[areaIndex];

    self.regionCell.textFieldCell.text = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto.name];
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




#pragma -- UItextfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        self.selectedRegionDto = self.regionDto[0];
        self.selectedCityDto = self.selectedRegionDto.cities[0];
        self.selectedAreaDto = self.selectedCityDto.areas[0];

        textField.text = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto.name];

    }
}


@end
