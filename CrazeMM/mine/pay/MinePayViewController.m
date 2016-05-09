//
//  MinePayViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MinePayViewController.h"
#import "FirstAddrCell.h"
#import "SecondProductDetailCell.h"
#import "LastPayMethodCell.h"
#import "TTModalView.h"
#import "PayAlertView.h"
#import "AddressListViewController.h"
#import "PayResultViewController.h"


typedef NS_ENUM(NSInteger, MinePayRow){
    kAddrRow = 1,
    kProductSumRow = 3,
    kPayWayRow = 5,
    kMaxPayRow
};

@interface MinePayViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) FirstAddrCell* addrCell;
@property (nonatomic, strong) SecondProductDetailCell* productDetailCell;
@property (nonatomic, strong) LastPayMethodCell* payWayCell;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) TTModalView* confirmModalView;
@property (nonatomic, strong) PayAlertView* payAlertView;

@end


@implementation MinePayViewController



-(UIButton*)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        @weakify(self);
        _confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            self.confirmModalView.modalWindowFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            self.confirmModalView.presentAnimationStyle = fadeIn;
            self.confirmModalView.dismissAnimationStyle = fadeOut ;
            

            [self.confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
                
                contentView.centerX = self.view.centerX;
                contentView.centerY = self.view.centerY;
                
                
                self.payAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    
                    return [RACSignal empty];
                }];
                
                self.payAlertView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    
                    PayResultViewController* payResultVC = [[PayResultViewController alloc] init];
                    
                    [self.navigationController pushViewController:payResultVC animated:YES];
                    
                    return [RACSignal empty];
                }];

                
            }];
            return [RACSignal empty];
        }];
    }
    return _confirmButton;
}

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:self.confirmButton];
        [self.view addSubview:_bottomView];
    }
    
    return _bottomView;
}


-(FirstAddrCell*) addrCell
{
    if (!_addrCell) {
        _addrCell = [[[NSBundle mainBundle]loadNibNamed:@"FirstAddrCell" owner:nil options:nil] firstObject];
        
        _addrCell.detailButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            AddressListViewController *addrVC = [AddressListViewController new];
            [self.navigationController pushViewController:addrVC animated:YES];
            
            return [RACSignal empty];
        }];

    }
    return _addrCell;
}

-(SecondProductDetailCell*)productDetailCell
{
    if (!_productDetailCell) {
        _productDetailCell = [[SecondProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondProductDetailCell"];
    }
    
    return _productDetailCell;
}


-(LastPayMethodCell*)payWayCell
{
    if (!_payWayCell) {
        _payWayCell = [[[NSBundle mainBundle]loadNibNamed:@"LastPayMethodCell" owner:nil options:nil] firstObject];
    }
    
    return _payWayCell;
}

-(TTModalView*)confirmModalView
{
    if (!_confirmModalView) {
        _confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
        _confirmModalView.isCancelAble = YES;
        _confirmModalView.modalWindowLevel = UIWindowLevelNormal;
        _confirmModalView.contentView = self.payAlertView;
    }
    
    return _confirmModalView;
}

-(PayAlertView*)payAlertView
{
    if (!_payAlertView) {
        _payAlertView = [[[NSBundle mainBundle]loadNibNamed:@"PayAlertView" owner:nil options:nil] firstObject];
        _payAlertView.layer.cornerRadius = 6.f;
    }
    
    return _payAlertView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"确认订单";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.bottomView.frame = CGRectMake(0, self.view.bounds.size.height-45, self.view.bounds.size.width, 45);
    self.confirmButton.frame = self.bottomView.bounds;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return kMaxPayRow;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell;
    if (indexPath.row == kAddrRow) {
        cell = self.addrCell;

    }
    else if(indexPath.row== kProductSumRow){
        cell = self.productDetailCell;

    }
    else if(indexPath.row == kPayWayRow){
        cell = self.payWayCell;
    }
    else {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    return cell;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row== kAddrRow) {
        return [FirstAddrCell cellHeight];

    }
    else if(indexPath.row== kProductSumRow){
        return self.productDetailCell.height;
    }
    else if(indexPath.row == kPayWayRow){
        return [LastPayMethodCell cellHeight];
    }
    
    else {
        return 16.f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row== kAddrRow) {
        AddressListViewController *addrVC = [AddressListViewController new];
        [self.navigationController pushViewController:addrVC animated:YES];
        
    }
    else {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
