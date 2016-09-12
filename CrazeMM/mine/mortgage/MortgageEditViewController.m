//
//  MortgageEditViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageEditViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "SelectionViewController.h"
#import "HttpStock.h"


@interface MortgageEditViewController ()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) UITableView* selectionTableView;
@property (nonatomic, strong) RACDisposable* watcher;
@property (nonatomic) NSNumber* enableSubEditX;

@end

@implementation MortgageEditViewController

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _additionalInfo = [[UILabel alloc]initWithFrame:CGRectMake(8.f, 8.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 16.f)];
        _additionalInfo.text = @"注：抵押货品将在放款后自动生成供货信息进行出售";
        _additionalInfo.font = [UIFont systemFontOfSize:15.f];
        _additionalInfo.adjustsFontSizeToFitWidth = YES;
        _additionalInfo.numberOfLines = 1;
        _additionalInfo.enabled = NO;
        _additionalInfo.textColor = [UIColor grayColor];
        [_confirmCell addSubview:self.additionalInfo];

        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"提交" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 32.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        _confirmButton.enabled = NO;
        @weakify(self);
        RACSignal* enableLoginSignal = [RACSignal
                                        combineLatest:@[
                                                        self.quantityCell.textFieldCell.rac_textSignal,
                                                        self.inpriceCell.textFieldCell.rac_textSignal,
                                                        self.outpriceCell.textFieldCell.rac_textSignal,
                                                        RACObserve(self, enableSubEditX)
                                                        ]
                                        reduce:^(NSString *quantity, NSString *inprice, NSString *outprice, NSNumber *enableSubEdit) {
                                            return @(quantity.length > 0 && inprice.length > 0 && outprice.length>0 && enableSubEdit.boolValue);
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
        
        [_confirmButton addTarget:self action:@selector(saveNewMortgage:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmCell;
}

-(AddrRegionCell*) depotCell
{
    if (!_depotCell) {
        _depotCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _depotCell.titleLabel.text = @"仓库";
    }
    return _depotCell;
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

-(AddrRegionCell*)cVNCell
{
    if (!_cVNCell) {
        _cVNCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _cVNCell.titleLabel.text = @"配置";//@"颜色/容量/制式";
        _cVNCell.titleLabel.adjustsFontSizeToFitWidth = NO;
        _cVNCell.regionLabel.text = @"请选择颜色/容量/制式";
        _cVNCell.regionLabel.adjustsFontSizeToFitWidth = NO;
        
        //        _standardCell.chooseButton.hidden = YES;
        //        _standardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return _cVNCell;
}

-(AddrRegionCell*)priceCell
{
    if (!_priceCell) {
        _priceCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _priceCell.titleLabel.text = @"抵押单价";
        
        _priceCell.chooseButton.hidden = YES;
        //        _standardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return _priceCell;
}

-(AddrRegionCell*)interestRateCell
{
    if (!_interestRateCell) {
        _interestRateCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _interestRateCell.titleLabel.text = @"日利率";
        
        _interestRateCell.chooseButton.hidden = YES;
        //        _standardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return _interestRateCell;
}

-(AddrRegionCell*)durationCell
{
    if (!_durationCell) {
        _durationCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _durationCell.titleLabel.text = @"抵押天数";
        
        _durationCell.chooseButton.hidden = YES;
        //        _standardCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return _durationCell;
}

-(AddrCommonCell*)quantityCell
{
    if (!_quantityCell) {
        _quantityCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _quantityCell.titleLabel.text = @"数量";
        _quantityCell.textFieldCell.placeholder = @"请输入抵押数量";
        _quantityCell.textFieldCell.keyboardType = UIKeyboardTypeNumberPad;
        
    }
    
    return _quantityCell;
}

-(AddrCommonCell*)inpriceCell
{
    if (!_inpriceCell) {
        _inpriceCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _inpriceCell.titleLabel.text = @"原价";
        _inpriceCell.textFieldCell.placeholder = @"请输入入手单价";
        _inpriceCell.textFieldCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
    }
    
    return _inpriceCell;
}

-(AddrCommonCell*)outpriceCell
{
    if (!_outpriceCell) {
        _outpriceCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _outpriceCell.titleLabel.text = @"出手价";
        _outpriceCell.textFieldCell.placeholder = @"请输入出手单价";
        _outpriceCell.textFieldCell.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
    }
    
    return _outpriceCell;
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
    self.navigationItem.title = @"申请抵押";
    
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
                       self.depotCell,
                       self.brandCell,
                       self.modelCell,
                       self.cVNCell,
                       self.priceCell,
                       self.interestRateCell,
                       self.durationCell,
                       self.quantityCell,
                       self.inpriceCell,
                       self.outpriceCell,
                       self.confirmCell
                       ];
    self.selectionDataSource = [[NSMutableArray alloc] init];
    
    HttpDepotQueryRequest *request = [[HttpDepotQueryRequest alloc]init];
    [request request]
    .then(^(id responseObj){
        HttpDepotQueryResponse *response = (HttpDepotQueryResponse*)request.response;
        if (response.ok) {
            self.depots = response.depotDtos;
            if (self.depots.count>0) {
                self.depotCell.value = ((DepotDTO *)self.depots.firstObject).name;
            }
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    HttpMortgageBrandRequest* brandRequest = [[HttpMortgageBrandRequest alloc] init];
    [brandRequest request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpMortgageBrandResponse* response = (HttpMortgageBrandResponse*)brandRequest.response;
        if (response.ok) {
            self.goodBrands = response.brandDtos;
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });

    self.enableModelEdit = NO;
    self.enableCVNEdit = NO;
    
}

-(void)saveNewMortgage:(UIButton*)sender
{
    [self.view endEditing:YES];
    
    @weakify(self);
    [self showAlertViewWithMessage:@"您确认发布该抵押信息吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        MortgageCreateInfo* mortgageCreateInfo = [[MortgageCreateInfo alloc] init];
                        for (DepotDTO* depotDto in self.depots) {
                            if ([depotDto.name isEqualToString:self.depotCell.regionLabel.text]) {
                                mortgageCreateInfo.depotId = depotDto.id;
                            }
                        }
                        
                        mortgageCreateInfo.mgId = self.currentMortgageDetail.id;
                        mortgageCreateInfo.quantity = [self.quantityCell.textFieldCell.text integerValue];
                        mortgageCreateInfo.inprice = [self.inpriceCell.textFieldCell.text floatValue];
                        mortgageCreateInfo.outprice = [self.outpriceCell.textFieldCell.text floatValue];

                        HttpSaveMortgageRequest* request = [[HttpSaveMortgageRequest alloc] initWithMortgageInfo:mortgageCreateInfo];
                        [request request]
                        .then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                if ([self.delegate respondsToSelector:@selector(editMortgageSuccess)]) {
                                    [self showAlertViewWithMessage:@"抵押信息发布成功"];
                                    //[self.delegate editMortgageSuccess];
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

-(void)setCurrentMortgageDetail:(MortgageInfoDTO *)currentGoodDetail
{
    _currentMortgageDetail = currentGoodDetail;
    self.priceCell.regionLabel.text = [[NSString alloc] initWithFormat:@"%.0f" , currentGoodDetail.price];
    self.interestRateCell.regionLabel.text = [[NSString alloc] initWithFormat:@"%.4f" , currentGoodDetail.interestRate];
    self.durationCell.regionLabel.text = [[NSString alloc] initWithFormat:@"%ld" ,currentGoodDetail.duration];
    
}

- (void) resetCellLabels
{
    self.modelCell.regionLabel.text = @"请选择型号";
    self.cVNCell.regionLabel.text = @"请选择颜色/容量/制式";
    self.priceCell.regionLabel.text = @"";
    self.durationCell.regionLabel.text = @"";
    self.interestRateCell.regionLabel.text = @"";
}

-(void)setEnableModelEdit:(BOOL)enableModelEdit
{
    _enableModelEdit = enableModelEdit;
    self.modelCell.regionLabel.textColor = enableModelEdit?[UIColor blackColor]:[UIColor lightGrayColor];
    
    //self.enableSubEditX = @(enableModelEdit);
    
}

-(void)setEnableCVNEdit:(BOOL)enableCVNEdit
{
    _enableCVNEdit = enableCVNEdit;
    self.cVNCell.regionLabel.textColor = enableCVNEdit?[UIColor blackColor]:[UIColor lightGrayColor];
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        else if (indexPath.row == kRowMConfirm) {
            return 72.f;
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
        MortgageBrandDTO* dto = self.selectionDataSource[indexPath.row];
        cell.textLabel.text = dto.name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionViewController* selectionVC;
    self.editingRow = indexPath.row;
    [self.selectionDataSource removeAllObjects];
    NSInteger selectedIndex = NSNotFound;
    NSInteger index;
    
    switch (indexPath.row) {
        case kRowMDepot:
        {
            for (index=0; index<self.depots.count; ++index) {
                DepotDTO* dto = self.depots[index];
                [self.selectionDataSource addObject:dto.name];
                if ([dto.name isEqualToString:self.depotCell.regionLabel.text]) {
                    selectedIndex = index;
                    //break;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择仓库"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
            
        }
            break;
        
        case kRowMBrand:
        {
            for (index=0; index<self.goodBrands.count; ++index) {
                MortgageBrandDTO* dto = self.goodBrands[index];
                [self.selectionDataSource addObject:dto.name];
                if ([dto.name isEqualToString:self.brandCell.regionLabel.text]) {
                    selectedIndex = index;
                    //break;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择品牌"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
            
        case kRowMModel:
        {
            if (!self.enableModelEdit) {
                break;
            }
            for (index=0; index<self.goodModels.count; ++index) {
                MortgageGoodDTO* dto = self.goodModels[index];
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
        case kRowMCVN:
        {
            if (!self.enableCVNEdit) {
                break;
            }
            for (index=0; index<self.cVNInfos.count; ++index) {
                //[self.selectionDataSource addObject:self.cVNInfos[index]];
                if ([self.cVNInfos[index] isEqualToString:self.cVNCell.regionLabel.text]) {
                    selectedIndex = index;
                    break;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.cVNInfos andSelectedIndex:selectedIndex andTitle:@"请选择颜色/容量/制式"];
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
        case kRowMDepot:
        {
            DepotDTO* dto = self.depots[selectedIndex];
            if([self.depotCell.regionLabel.text isEqualToString:dto.name]){
                return;
            }
            
            else {
                HttpMortgageBrandRequest* brandRequest = [[HttpMortgageBrandRequest alloc] init];
                [brandRequest request]
                .then(^(id responseObj){
                    NSLog(@"%@", responseObj);
                    HttpMortgageBrandResponse* response = (HttpMortgageBrandResponse*)brandRequest.response;
                    if (response.ok) {
                        self.goodBrands = response.brandDtos;
                    }
                })
                .catch(^(NSError* error){
                    [self showAlertViewWithMessage:error.localizedDescription];
                });
                
                self.enableModelEdit = NO;
                self.enableCVNEdit = NO;
                self.enableSubEditX = @(NO);
                self.brandCell.regionLabel.text = @"请选择品牌";
                [self resetCellLabels];

            }
            
        }
            
            
        case kRowMBrand:
        {
            MortgageBrandDTO* dto = self.goodBrands[selectedIndex];
            if([self.brandCell.regionLabel.text isEqualToString:dto.name]){
                return;
            }
            
            self.enableSubEditX = @(NO);
            
            [self resetCellLabels];
            self.brandCell.regionLabel.text = dto.name;
            HttpMortgageGoodRequest* request = [[HttpMortgageGoodRequest alloc] initWithBrandId:dto.id];
            self.enableModelEdit = NO;
            self.enableCVNEdit = NO;
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
                HttpMortgageGoodResponse* response = (HttpMortgageGoodResponse*)request.response;
                if (response.ok) {
                    self.goodModels = response.goodDtos;
                    self.enableModelEdit = YES;
                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            });
        }
            break;
            
        case kRowMModel:
        {
            MortgageGoodDTO* dto = self.goodModels[selectedIndex];
            
            if ([self.modelCell.regionLabel.text isEqualToString:dto.model]) {
                return;
            }
            self.enableSubEditX = @(NO);

            self.modelCell.regionLabel.text = dto.model;
            HttpMortgageInfoRequest* request = [[HttpMortgageInfoRequest alloc] initWithGoodId:dto.id];
            self.enableCVNEdit = NO;
            
            self.cVNCell.regionLabel.text = @"请选择颜色/容量/制式";
            self.priceCell.regionLabel.text = @"";
            self.durationCell.regionLabel.text = @"";
            self.interestRateCell.regionLabel.text = @"";

            
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
                HttpMortgageInfoResponse* response = (HttpMortgageInfoResponse*)request.response;
                if (response.ok) {
                    
                    self.mortgageInfos = response.infoDtos;
                    if (self.cVNInfos)
                    {
                        [self.cVNInfos removeAllObjects];
                    }
                    else
                    {
                      self.cVNInfos = [[NSMutableArray alloc] init];
                    }
                    
                    for (MortgageInfoDTO* infoDto in response.infoDtos ) {
                        NSString* cVNString  = [[NSString alloc] initWithFormat:@"%@ %@ %@", infoDto.goodColor, infoDto.goodVolume, infoDto.goodNetwork];
                        
                        NSLog(@"%@", cVNString);
                        [self.cVNInfos addObject:cVNString];
                    }
                    self.enableCVNEdit = YES;

                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            });
        }
            break;

            
        case kRowMCVN:
        {
            self.cVNCell.regionLabel.text = self.cVNInfos[selectedIndex];
            self.currentMortgageDetail = self.mortgageInfos[selectedIndex];
            
            self.enableSubEditX = @(YES);

        }
            break;
        default:
            break;
    }
    
}



-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}


@end
