//
//  PersonalOtherModifyViewContoller.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PersonalOtherModifyViewContoller.h"
#import "InfoLabelCell.h"
#import "InfoFieldCell.h"
#import "AddrRegionCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegionDTO.h"
#import "HttpAllRegion.h"
#import "UIPlaceHolderTextView.h"


@interface PersonalOtherModifyViewContoller()

@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) InfoFieldCell* userNameCell;
@property (nonatomic, strong) InfoFieldCell* entNameCell;
@property (nonatomic, strong) InfoFieldCell* entHeadCell;
@property (nonatomic, strong) AddrRegionCell* entSexCell;
@property (nonatomic, strong) InfoFieldCell* entIdCell;
@property (nonatomic, strong) InfoFieldCell* entAreaCell;
@property (nonatomic, strong) UITableViewCell* entStreetCell;
@property (nonatomic, strong) UIPlaceHolderTextView* entStreetTextView;

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) NSArray* cellArray;

@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray* regionDto;
@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;
@property (nonatomic, strong) RegionDTO* selectedRegionDto;
@property (nonatomic, strong) CityDTO* selectedCityDto;
@property (nonatomic, strong) AreaDTO* selectedAreaDto;


@end


@implementation PersonalOtherModifyViewContoller

-(CGFloat)titleWidth
{
    return [@"身份证号" boundingWidthWithFont:[UIFont systemFontOfSize:16.f]].width;
}

-(InfoFieldCell*)userNameCell
{
    if (!_userNameCell) {
        _userNameCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_userNameCell"];
        _userNameCell.titleLabel.text = @"用户名";
        _userNameCell.titleWidth = [self titleWidth];
        
        _userNameCell.infoField.placeholder = @"请输入用户名";
    }
    
    return _userNameCell;
}

-(InfoFieldCell*)entNameCell
{
    if (!_entNameCell) {
        _entNameCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_entNameCell"];
        _entNameCell.titleLabel.text = @"企业名称";
        _entNameCell.titleWidth = [self titleWidth];
        
        _entNameCell.infoField.placeholder = @"请输入企业名称";
    }
    
    return _entNameCell;
}

-(InfoFieldCell*)entHeadCell
{
    if (!_entHeadCell) {
        _entHeadCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_entHeadCell"];
        _entHeadCell.titleLabel.text = @"企业法人";
        _entHeadCell.titleWidth = [self titleWidth];
        
        _entHeadCell.infoField.placeholder = @"请输入企业法人";
    }
    
    return _entHeadCell;
}

-(AddrRegionCell*)entSexCell
{
    if (!_entSexCell) {
        _entSexCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
;
        _entSexCell.title = @"性别";
        [_entSexCell setTitleLeadingMarginWithSpace:8.f];
        [_entSexCell formartSeperatorLineConstraintsWithlLeading:-8.f andHeigt:0.5f andTrailing:0];
        [_entSexCell setRegionLabelLeadingWithSpace:16.f];
        _entSexCell.seperatorLine.backgroundColor = [UIColor tableViewSeperatorLineBackgroundColor];
        _entSexCell.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _entSexCell.regionLabel.font = [UIFont systemFontOfSize:16.f];
        _entSexCell.titleLabel.textColor = [UIColor blackColor];
        _entSexCell.regionLabel.textColor = [UIColor blackColor];

    }
    
    return _entSexCell;
}

-(InfoFieldCell*)entIdCell
{
    if (!_entIdCell) {
        _entIdCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_entIdCell"];
        _entIdCell.titleLabel.text = @"身份证号";
        _entIdCell.titleWidth = [self titleWidth];
        
        _entIdCell.infoField.placeholder = @"请输入身份证号";
    }
    
    return _entIdCell;
}

-(InfoFieldCell*)entAreaCell
{
    if (!_entAreaCell) {
        _entAreaCell = [[InfoFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_entAreaCell"];
        _entAreaCell.titleLabel.text = @"所在地区";
        _entAreaCell.titleWidth = [self titleWidth];
        
        _entAreaCell.infoField.placeholder = @"请选择所在地区";
    }
    
    return _entAreaCell;
}

-(UITableViewCell*)entStreetCell
{
    if(!_entStreetCell){
        _entStreetCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_entStreetCell"];
        
        _entStreetTextView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(16.f, 0, [UIScreen mainScreen].bounds.size.width-16.f*2, 64.f)];
        [_entStreetCell.contentView addSubview:_entStreetTextView];
        _entStreetTextView.placeholder = @"请输入详细地址";
        _entStreetTextView.font = [UIFont systemFontOfSize:16.f];
        
        UIView* seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(16.f, 64.f-1.f, [UIScreen mainScreen].bounds.size.width-16.f, 0.5f)];
        seperatorLine.backgroundColor = [UIColor tableViewSeperatorLineBackgroundColor];
        [_entStreetCell addSubview:seperatorLine];
    }
    
    return _entStreetCell;
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

-(void)saveChanges:(id)sender
{
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息修改";
    
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
    
    self.navigationController.confirmString = @"确定放弃修改吗?";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.cellArray = @[self.userNameCell, self.entNameCell, self.entHeadCell, self.entSexCell, self.entIdCell, self.entAreaCell, self.entStreetCell, self.confirmCell];
    
    
    self.entAreaCell.infoField.enabled = NO;
    [HttpAllRegionRequest getAllRegions].then(^(NSArray* allRegions){
        self.regionDto = allRegions;
        [self setupCityPicker];
        self.entAreaCell.infoField.enabled = YES;
//        if (self.address){
//            self.selectedRegionDto = [self findRegion];
//            self.selectedCityDto = [self findCity];
//            self.selectedAreaDto = [self findArea];
//            self.provinceIndex = [self.regionDto indexOfObject:self.selectedRegionDto];
//            self.cityIndex = [self.selectedRegionDto.cities indexOfObject:self.selectedCityDto];
//            self.areaIndex = [self.selectedCityDto.areas indexOfObject:self.selectedAreaDto];
//            
//            [self.cityPicker selectRow:self.provinceIndex inComponent:0 animated:NO];
//            [self.cityPicker selectRow:self.cityIndex inComponent:1 animated:NO];
//            [self.cityPicker selectRow:self.areaIndex inComponent:2 animated:NO];
//            
//            self.entAreaCell.value = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto.name];
//        }
        self.selectedRegionDto = self.regionDto[0];
        self.selectedCityDto = self.selectedRegionDto.cities[0];
        self.selectedAreaDto = self.selectedCityDto.areas[0];
        
        self.entAreaCell.infoField.text = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto.name];
    });

    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    @weakify(self);
    NSArray* allTextSignals;
    RACSignal* enableSaveButtonSignal;
        allTextSignals = @[self.userNameCell.infoField.rac_textSignal,
                           self.entNameCell.infoField.rac_textSignal,
                           self.entHeadCell.infoField.rac_textSignal,
                           self.entIdCell.infoField.rac_textSignal,
                           ];
        enableSaveButtonSignal = [RACSignal combineLatest:allTextSignals
                                                   reduce:^id(NSString* userName, NSString* entName, NSString* entHead, NSString* entId){
                                                       return @(userName.length>0
                                                       && entName.length>0
                                                       && entHead.length>0
                                                       && entId.length>0
                                                       && self.entAreaCell.infoField.text.length>0
                                                       && self.entSexCell.regionLabel.text.length>0);
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




#pragma - mark area pick view
- (void)setupCityPicker {
    _cityPicker = [[UIPickerView alloc] init];
    _cityPicker.delegate = self;
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = [UIColor whiteColor];
    self.entAreaCell.infoField.inputView = _cityPicker;
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
    if (self.selectedCityDto.areas.count>areaIndex) {
        self.selectedAreaDto = self.selectedCityDto.areas[areaIndex];
    }
    else {
        self.selectedAreaDto = nil;
    }
    
    self.entAreaCell.infoField.text = [NSString stringWithFormat:@"%@ %@ %@", self.selectedRegionDto.name, self.selectedCityDto.name, self.selectedAreaDto?self.selectedAreaDto.name:@""];
}




#pragma - mark UITableview delegate
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
    
    if (self.cellArray[indexPath.row] == self.entStreetCell) {
        return 64.f;
    }
    if(self.cellArray[indexPath.row] == self.confirmCell){
        return 88.f;
    }
    
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = (UITableViewCell*)self.cellArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) { // sex row
        [self.entSexCell popSelection:@[@"男", @"女"] andDelegate:self];
    }
}

-(void)didSelectSuggestString:(NSString*)selectedString
{
    self.entSexCell.value = selectedString;
    [self.entSexCell dismissSelection];
}

@end
