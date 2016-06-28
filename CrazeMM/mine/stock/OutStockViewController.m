//
//  OutStockViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OutStockViewController.h"
#import "AddrRegionCell.h"
#import "FirstAddrCell.h"
#import "AddressesViewController.h"
#import "HttpAddress.h"
#import "SecondProductDetailCell.h"
#import "HttpConsignee.h"
#import "ConsigneeListViewController.h"



@interface OutStockViewController ()

@property (nonatomic, copy) NSArray* stockDtos;

@property (nonatomic, strong) AddrRegionCell* typeCell;
@property (nonatomic, strong) FirstAddrCell* addrCell;
@property (nonatomic, strong) FirstAddrCell* consigneeCell;

@property (nonatomic, strong) UITableViewCell* addAddrCell;
@property (nonatomic, strong) SecondProductDetailCell* productDetailCell;

@property (nonatomic, strong) AddressDTO* selectedAddrDto;
@property (nonatomic, copy) NSArray* addresses;

@property (nonatomic, strong) ConsigneeDTO* selectedConsigneeDto;
@property (nonatomic, copy) NSArray* consignees;


@property (nonatomic, readonly) NSInteger type;

@end

@implementation OutStockViewController

-(instancetype)initWithStockDtos:(NSArray *)stockDtos
{
    self = [super init];
    if (self) {
        self.stockDtos = stockDtos;
    }
    return self;
}

-(NSInteger)type
{
    return [self.typeCell.value isEqualToString:@"快递"]?1:0;
}

-(UITableViewCell*)addAddrCell
{
    if (!_addAddrCell) {
        _addAddrCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addAddrCell"];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 0, 0, 0)];
        label.font = [UIFont systemFontOfSize:16.f];
        label.text =  @"请先创建您的收货地址";
        [label sizeToFit];
        label.frame = CGRectMake(8.f, (60.f-label.height)/2, label.width, label.height);
        [_addAddrCell addSubview:label];
//        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
//        [button setImage:[@"arrow_left" image] forState:UIControlStateNormal];
        _addAddrCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    return _addAddrCell;
}

-(AddrRegionCell*)typeCell
{
    if (!_typeCell) {
        _typeCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _typeCell.title = @"提货方式";
        _typeCell.value = @"自提";
        _typeCell.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [_typeCell.chooseButton addTarget:self action:@selector(popPickupWay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _typeCell;
}

-(FirstAddrCell*) addrCell
{
    if (!_addrCell) {
        _addrCell = [[[NSBundle mainBundle]loadNibNamed:@"FirstAddrCell" owner:nil options:nil] firstObject];
        @weakify(self);
        _addrCell.detailButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            AddressesViewController *addrVC = [[AddressesViewController alloc] init];
            [self.navigationController pushViewController:addrVC animated:YES];
            addrVC.delegate = self;
            return [RACSignal empty];
        }];
    }
    return _addrCell;
}

-(FirstAddrCell*) consigneeCell
{
    if (!_consigneeCell) {
        _consigneeCell = [[[NSBundle mainBundle]loadNibNamed:@"FirstAddrCell" owner:nil options:nil] firstObject];
        _consigneeCell.geoIcon.hidden = YES;
        @weakify(self);
        _consigneeCell.detailButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            ConsigneeListViewController* consigneeVC = [[ConsigneeListViewController alloc] init];
            [self.navigationController pushViewController:consigneeVC animated:YES];
            consigneeVC.delegate = self;
            return [RACSignal empty];
        }];
    }
    return _consigneeCell;
}



-(SecondProductDetailCell*)productDetailCell
{
    if (!_productDetailCell) {
        _productDetailCell = [[SecondProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondProductDetailCell"];
        _productDetailCell.stockDTOs = self.stockDtos;
        
    }
    
    return _productDetailCell;
}

-(void)popPickupWay
{
    [self.typeCell popSelection:@[@"自提", @"快递"] andDelegate:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认出库";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self getConsignees];
    [self getOrderAddresses];
}

-(void)getOrderAddresses
{
    HttpAddressRequest* request = [[HttpAddressRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpAddressResponse* response = (HttpAddressResponse*)request.response;
        if (response.ok) {
            self.addresses = response.addresses;
            self.selectedAddrDto = self.addresses.firstObject;
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

-(void)getConsignees
{
    HttpConsigneeRequest* request = [[HttpConsigneeRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpConsigneeResponse* response = (HttpConsigneeResponse*)request.response;
        if (response.ok) {
            self.consignees = response.consigneeDtos;
            self.selectedConsigneeDto = self.consignees.firstObject;
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.row %2 ==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UeslessCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UeslessCell"];
            cell.backgroundColor = [UIColor clearColor];
        }
    }
    else {
        if (indexPath.row/2==0) {
            cell = self.typeCell;
        }
        else if(indexPath.row/2==1) {
            if (self.type == 1) {
                cell = self.addrCell;
                self.addrCell.addrDto = self.selectedAddrDto;
            }
            else {
                cell = self.consigneeCell;
                self.consigneeCell.consigneeDto = self.selectedConsigneeDto;
            }
        }
        else if(indexPath.row/2==2) {
            cell = self.productDetailCell;
        }
        
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 ==0) {
        return 14.f;
    }
    else {
        
        if (indexPath.row/2==0) {
            return 40.f;
        }
        else if(indexPath.row/2==1){
            if (self.type == 1) {
                if (self.addresses.count==0) {
                    return 60.f;
                }
                else {
                    return self.addrCell.height;
                }

            }
            else {
                return self.addrCell.height;
            }
        }
        else if(indexPath.row/2==2) {
            return self.productDetailCell.height;
        }
        
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 ==0) {
        return;
    }
    if (indexPath.row/2==0) {
        [self popPickupWay];
    }
    else if(indexPath.row/2==1){
        if (self.type == 1) {
            AddressesViewController *addrVC = [[AddressesViewController alloc] init];
            [self.navigationController pushViewController:addrVC animated:YES];
            addrVC.delegate = self;
        }
        else {
            ConsigneeListViewController* consigneeVC = [[ConsigneeListViewController alloc] init];
            [self.navigationController pushViewController:consigneeVC animated:YES];
            consigneeVC.delegate = self;
        }
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath
{
//    if (indexPath.row/2==1) {
//        if (self.type == 1) {
//            AddressesViewController *addrVC = [[AddressesViewController alloc] init];
//            [self.navigationController pushViewController:addrVC animated:YES];
//            addrVC.delegate = self;
//        }
//        else {
//            ConsigneeListViewController* consigneeVC = [[ConsigneeListViewController alloc] init];
//            [self.navigationController pushViewController:consigneeVC animated:YES];
//            consigneeVC.delegate = self;
//        }
//    }
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark suggest vc delegate
-(void)didSelectSuggestString:(NSString*)selectedString
{
    self.typeCell.value = selectedString;
    [self.typeCell dismissSelection];
    if (self.type == 1) { //快递
        if (self.addresses.count==0) {
            [self getOrderAddresses];
            return;
        }
    }
    else {
        if (self.consignees.count==0) {
            [self getConsignees];
            return;
        }
    }
    [self.tableView reloadData];
}

#pragma -- mark AddressListViewController Delegate
-(void)didSelectedAddress:(AddrDTO *)address
{
    if (self.type == 1) {
        if (self.selectedAddrDto.id != address.id) {
            self.selectedAddrDto = [[AddressDTO alloc] initWithAddr:address];
        }
    }
    [self.tableView reloadData];
}

#pragma mark
-(void)didSelectedConsignee:(ConsigneeDTO*)consignee
{
    if (self.type == 2) {
        if (self.selectedConsigneeDto.id != consignee.id) {
            self.selectedConsigneeDto = consignee;
        }
    }
    [self.tableView reloadData];
}

@end
