//
//  MineSupplyEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSupplyEditViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ZZPopoverWindow.h"
#import "HttpGoodInfoQuery.h"
#import "SelectionViewController.h"
#import "HttpSaveSupplyInfo.h"





@interface MineSupplyEditViewController()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;

@property (nonatomic, strong) UITableView* selectionTableView;
@property (nonatomic, strong) ZZPopoverWindow* popover;


@property (nonatomic, strong) RACDisposable* watcher;

@property (nonatomic) BOOL enableSubEdit;
@property (nonatomic) NSNumber* enableSubEditX;

@end

@implementation MineSupplyEditViewController

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 16.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        _confirmButton.enabled = NO;
        @weakify(self);
        RACSignal* enableLoginSignal = [RACSignal
                                          combineLatest:@[
                                                          self.priceCell.textFieldCell.rac_textSignal,
                                                          self.stockCell.textFieldCell.rac_textSignal,
                                                          self.timeCell.textFieldCell.rac_textSignal,
                                                          RACObserve(self, enableSubEditX)
                                                          ]
                                        reduce:^(NSString *price, NSString *stock, NSString *time, NSNumber *enableSubEdit) {
                                                              return @(price.length > 0 && stock.length > 0 && time.length>0 && enableSubEdit.boolValue);
                                                          }];
        
        [enableLoginSignal subscribeNext:^(NSNumber* enable){
            @strongify(self);
            if (enable.boolValue) {
                self.confirmButton.enabled = YES;
                self.confirmButton.backgroundColor = [UIColor greenTextColor];
            }
            else {
                self.confirmButton.enabled = NO;
                self.confirmButton.backgroundColor = [UIColor light_Gray_Color];

            }
        }];
        
        [_confirmButton addTarget:self action:@selector(saveNewGood:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmCell;
}


-(AddrRegionCell*)brandCell
{
    if (!_brandCell) {
        _brandCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _brandCell.titleLabel.text = @"品牌";
        _brandCell.regionLabel.text = @"请选择品牌";
//        _brandCell.chooseButton.hidden = YES;
//        _brandCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _brandCell;
}
-(AddrRegionCell*)modelCell
{
    if (!_modelCell) {
        _modelCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _modelCell.titleLabel.text = @"型号";
        _modelCell.regionLabel.text = @"请选择型号";

//        _modelCell.chooseButton.hidden = YES;
//        _modelCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return _modelCell;
}
-(AddrRegionCell*)standardCell
{
    if (!_standardCell) {
        _standardCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _standardCell.titleLabel.text = @"制式";
        _standardCell.regionLabel.text = @"请选择制式";

//        _standardCell.chooseButton.hidden = YES;
//        _standardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return _standardCell;
}
-(AddrRegionCell*)colorCell
{
    if (!_colorCell) {
        _colorCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _colorCell.titleLabel.text = @"颜色";
        _colorCell.regionLabel.text = @"请选择颜色";

//        _colorCell.chooseButton.hidden = YES;
//        _colorCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return _colorCell;
}
-(AddrRegionCell*)capacityCell
{
    if (!_capacityCell) {
        _capacityCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _capacityCell.titleLabel.text = @"容量";
        _capacityCell.regionLabel.text = @"请选择容量";

//        _capacityCell.chooseButton.hidden = YES;
//        _capacityCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return _capacityCell;
}
-(AddrRegionCell*)cycleCell
{
    if (!_cycleCell) {
        _cycleCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _cycleCell.titleLabel.text = @"供货周期";
        
//        _cycleCell.chooseButton.hidden = YES;
//        _cycleCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        _cycleCell.regionLabel.text = @"72小时以上";
    }
    
    return _cycleCell;
}

-(SwitchCell*)hasIMEICell
{
    if(!_hasIMEICell){
        _hasIMEICell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _hasIMEICell.titleLabel.text = @"带串码";
        _hasIMEICell.swith.on = YES;
    }
    
    return _hasIMEICell;
}

-(SwitchCell*)isIntactCell
{
    if(!_isIntactCell){
        _isIntactCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _isIntactCell.titleLabel.text = @"原封";
        _isIntactCell.swith.on = YES;
    }
    
    return _isIntactCell;
}
-(SwitchCell*)hasBoxCell
{
    if(!_hasBoxCell){
        _hasBoxCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _hasBoxCell.titleLabel.text = @"原封箱";
        _hasBoxCell.swith.on = YES;
    }
    
    return _hasBoxCell;
}
-(SwitchCell*)isBrushedCell
{
    if(!_isBrushedCell){
        _isBrushedCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _isBrushedCell.titleLabel.text = @"已刷机";
        _isBrushedCell.swith.on = NO;
    }
    
    return _isBrushedCell;
}

-(AddrCommonCell*)priceCell
{
    if (!_priceCell) {
        _priceCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _priceCell.titleLabel.text = @"单价";
        _priceCell.textFieldCell.placeholder = @"请输入单台价格";
        _priceCell.textFieldCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    
    return _priceCell;
}
-(AddrCommonCell*)stockCell
{
    if (!_stockCell) {
        _stockCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _stockCell.titleLabel.text = @"库存";
        _stockCell.textFieldCell.placeholder = @"请输入库存数量";
        _stockCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;

    }
    
    return _stockCell;
}
-(AddrCommonCell*)timeCell
{
    if (!_timeCell) {
        _timeCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _timeCell.titleLabel.text = @"有效时长";
        _timeCell.textFieldCell.placeholder = @"请输入小时数";
        _timeCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;

        _timeCell.textFieldCell.text = @"24";
    }
    
    return _timeCell;
}

-(AddrDefaultCheckboxCell*)otherCell
{
    if (!_otherCell) {
        _otherCell = (AddrDefaultCheckboxCell*)[UINib viewFromNib:@"AddrDefaultCheckboxCell"];
        _otherCell.titleLabel2.hidden = NO;
        _otherCell.checkBox2.hidden = NO;
        
        _otherCell.titlelabel.text = @"可拆分";
        _otherCell.titleLabel2.text = @"匿名";
        _otherCell.checkBox.on = NO;
        _otherCell.checkBox2.on = NO;
        
        _otherCell.seperatorLine.hidden = YES;

    }
    
    return _otherCell;
}


-(UITableView*)selectionTableView
{
    if (!_selectionTableView) {
        _selectionTableView = [[UITableView alloc] init];
        _selectionTableView.backgroundColor = [UIColor whiteColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_selectionTableView setTableFooterView:view];
        _selectionTableView.delegate = self;
        _selectionTableView.dataSource = self;
    }
    
    return _selectionTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建供货信息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"cancel_m" image] style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
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
    
    self.cellArray = @[
                       self.brandCell,
                       self.modelCell,
                       self.colorCell,
                       self.standardCell,
                       self.capacityCell,
                       self.hasIMEICell,
                       self.isIntactCell,
                       self.hasBoxCell,
                       self.isBrushedCell,
                       self.priceCell,
                       self.stockCell,
                       self.cycleCell,
                       self.timeCell,
                       self.otherCell,
                       self.confirmCell
                       ];
    
    self.selectionDataSource = [[NSMutableArray alloc] init];
    HttpBrandQueryRequest* brandRequest = [[HttpBrandQueryRequest alloc] init];
    [brandRequest request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpBrandQueryResponse* response = (HttpBrandQueryResponse*)brandRequest.response;
        if (response.ok) {
            self.goodBrands = response.brandDtos;
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    self.enableSubEdit = NO;
}

-(void)saveNewGood:(UIButton*)sender
{
    [self.view endEditing:YES];
    @weakify(self);
    [self showAlertViewWithMessage:@"您确认发布该供货信息吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        GoodCreateInfo* goodCreateInfo = [[GoodCreateInfo alloc] init];
                        for (GoodBrandDTO* brandDto in self.goodBrands) {
                            if ([brandDto.name isEqualToString:self.brandCell.regionLabel.text]) {
                                goodCreateInfo.brand = brandDto.id;
                            }
                        }
                        
                        goodCreateInfo.id = self.currentGoodDetail.id;
                        goodCreateInfo.quantity = [self.stockCell.textFieldCell.text integerValue];
                        NSInteger cycleStringIndex = [self.cycleStringArray indexOfObject:self.cycleCell.regionLabel.text];
                        switch (cycleStringIndex) {
                            case 0:
                                goodCreateInfo.deadline = 24;
                                break;
                            case 1:
                                goodCreateInfo.deadline = 48;
                                break;
                            case 2:
                                goodCreateInfo.deadline = 72;
                                break;
                            default:
                                goodCreateInfo.deadline = -1;
                                break;
                        }
                        
                        goodCreateInfo.duration = self.timeCell.textFieldCell.text.integerValue;
                        goodCreateInfo.price = self.priceCell.textFieldCell.text.integerValue;
                        goodCreateInfo.color = self.colorCell.regionLabel.text;
                        goodCreateInfo.volume = self.capacityCell.regionLabel.text;
                        goodCreateInfo.network = self.standardCell.regionLabel.text;
                        goodCreateInfo.isSerial = self.hasIMEICell.swith.on;
                        goodCreateInfo.isOriginal = self.isIntactCell.swith.on;
                        goodCreateInfo.isOriginalBox = self.hasBoxCell.swith.on;
                        goodCreateInfo.isBrushMachine = self.isBrushedCell.swith.on;
                        goodCreateInfo.isSplit = self.otherCell.checkBox.on;
                        goodCreateInfo.isAnoy = self.otherCell.checkBox2.on;
                        
                        
                        HttpSaveSupplyInfoRequest* request = [[HttpSaveSupplyInfoRequest alloc] initWithGoodInfo:goodCreateInfo];
                        [request request]
                        .then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                if ([self.delegate respondsToSelector:@selector(editSupplyGoodSuccess)]) {
                                    [self showAlertViewWithMessage:@"供货信息发布成功"];
                                    [self.delegate editSupplyGoodSuccess];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                 andCancelCallback:^(id x){
                     
                 }];
    
    
}

-(NSArray*)cycleStringArray
{
    return @[@"24小时", @"48小时", @"72小时", @"72小时以上"];
}

-(void)cancel:(id)sender
{
    [self.view endEditing:YES];

    @weakify(self);
    [self showAlertViewWithMessage:@"您确认离开吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                 andCancelCallback:^(id x){
                     
                 }];
}

-(void)setCurrentGoodDetail:(GoodInfoDTO *)currentGoodDetail
{
    _currentGoodDetail = currentGoodDetail;
    self.modelCell.regionLabel.text = currentGoodDetail.model;
    self.colorCell.regionLabel.text = currentGoodDetail.color.firstObject;
    self.capacityCell.regionLabel.text = currentGoodDetail.volume.firstObject;
    self.standardCell.regionLabel.text = currentGoodDetail.network.firstObject;

}

-(void)setEnableSubEdit:(BOOL)enableSubEdit
{
    _enableSubEdit = enableSubEdit;
    self.modelCell.regionLabel.textColor = enableSubEdit?[UIColor blackColor]:[UIColor lightGrayColor];
    self.colorCell.regionLabel.textColor = enableSubEdit?[UIColor blackColor]:[UIColor lightGrayColor];
    self.capacityCell.regionLabel.textColor = enableSubEdit?[UIColor blackColor]:[UIColor lightGrayColor];
    self.standardCell.regionLabel.textColor = enableSubEdit?[UIColor blackColor]: [UIColor lightGrayColor];
    
    self.enableSubEditX = @(enableSubEdit);
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
//    [self.view becomeFirstResponder];
    //[self.view findFirstResponder]
}

#pragma -- mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView){
        return self.cellArray.count + 1;

    }
    else {
        return self.selectionDataSource.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableView){
        if (indexPath.row >= self.cellArray.count) {
            return 30.f;
        }
        else if (indexPath.row == kRowConfirm) {
            return 56.f;
        }
        return 44.f;
    }
    else {
        return 44.f;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if(tableView == self.tableView){
        if (indexPath.row >= self.cellArray.count) {
            cell = [[UITableViewCell alloc] init];
        }
        else {
            cell = self.cellArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionCell"];
        }
        GoodBrandDTO* dto = self.selectionDataSource[indexPath.row];
        cell.textLabel.text = dto.name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionViewController* selectionVC;
    self.editingRow = indexPath.row;
    [self.selectionDataSource removeAllObjects];
    NSInteger selectedIndex = NSNotFound;
    NSInteger index;

    switch (indexPath.row) {
        case kRowBrand:
        {
            for (index=0; index<self.goodBrands.count; ++index) {
                GoodBrandDTO* dto = self.goodBrands[index];
                [self.selectionDataSource addObject:dto.name];
                if ([dto.name isEqualToString:self.brandCell.regionLabel.text]) {
                    selectedIndex = index;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择品牌"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
        
        case kRowModel:
        {
            if (!self.enableSubEdit) {
                break;
            }
            for (index=0; index<self.goodInfos.count; ++index) {
                GoodInfoDTO* dto = self.goodInfos[index];
                [self.selectionDataSource addObject:dto.model];
                if ([dto.model isEqualToString:self.modelCell.regionLabel.text]) {
                    selectedIndex = index;
                }
            }
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择型号"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
        case kRowColor:
        {
            if (!self.enableSubEdit) {
                break;
            }
            for (index=0; index<self.currentGoodDetail.color.count; ++index) {
                
                if ([self.currentGoodDetail.color[index] isEqualToString:self.colorCell.regionLabel.text]) {
                    selectedIndex = index;
                    break;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.color andSelectedIndex:selectedIndex andTitle:@"请选择颜色"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];

        }
            break;
        case kRowStandard:
        {
            if (!self.enableSubEdit) {
                break;
            }
            selectedIndex = [self.currentGoodDetail.network indexOfObject:self.standardCell.regionLabel.text];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.network andSelectedIndex:selectedIndex andTitle:@"请选择制式"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
        case kRowCapacity:
        {
            if (!self.enableSubEdit) {
                break;
            }
            selectedIndex = [self.currentGoodDetail.volume indexOfObject:self.capacityCell.regionLabel.text];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.volume andSelectedIndex:selectedIndex andTitle:@"请选择容量"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
            
        case kRowCycle:
        {
            self.selectionDataSource = [self.cycleStringArray mutableCopy];
            selectedIndex = [self.selectionDataSource indexOfObject:self.cycleCell.regionLabel.text];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择供货周期"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma -- mark SelectionViewControllerDelegate
-(void)didSelectItemWithTitle:(NSInteger)selectedIndex
{
    switch (self.editingRow) {
        case kRowBrand:
        {
            GoodBrandDTO* dto = self.goodBrands[selectedIndex];
            self.brandCell.regionLabel.text = dto.name;
            HttpGoodInfoQueryRequest* request = [[HttpGoodInfoQueryRequest alloc] initWithBrandId:dto.id];
            self.enableSubEdit = NO;
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
                HttpGoodInfoQueryResponse* response = (HttpGoodInfoQueryResponse*)request.response;
                if (response.ok) {
                    self.goodInfos = response.goodDtos;
                    if (self.goodInfos.count>0) {
                        self.currentGoodDetail = self.goodInfos.firstObject;
                        self.enableSubEdit = YES;
                    }
                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            });
        }
            break;
            
        case kRowModel:
        {
            self.currentGoodDetail = self.goodInfos[selectedIndex];
        }
            break;
            
        case kRowColor:
        {
            self.colorCell.regionLabel.text = self.currentGoodDetail.color[selectedIndex];
        }
            break;
        
        case kRowStandard:
        {
            self.standardCell.regionLabel.text = self.currentGoodDetail.network[selectedIndex];
        }
            break;
        case kRowCapacity:
        {
            self.capacityCell.regionLabel.text = self.currentGoodDetail.volume[selectedIndex];
        }
            break;
        
        case kRowCycle:
        {
            self.cycleCell.regionLabel.text = self.selectionDataSource[selectedIndex];
        }
            break;
        default:
            break;
    }
    
}


-(void)dealloc
{
    //[self.watcher dispose];
    NSLog(@"dealloc %@", [self class]);
}

@end
