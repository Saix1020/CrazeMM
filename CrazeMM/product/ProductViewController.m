//
//  ProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductViewController.h"
#import "LLBootstrap.h"
#import "LoginViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "BuyProductView.h"
#import "TTModalView.h"
#import "M80AttributedLabel.h"
#import "ProductLadderCell.h"
#import "ProductDetailCell.h"
#import "ProductCompanyCell.h"
#import "ProductOtherCompanyCell.h"
#import "PayViewController.h"



#define DEBUG_MODE

@interface ProductViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView* buttomView;
@property (nonatomic, strong) M80AttributedLabel* timeLabel;
@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) UIButton* orderButton;

@property (nonatomic, strong) BuyProductView* buyProductView;

@property (nonatomic, strong) UIImageView* imageView;//just for debug
@property (nonatomic, strong) TTModalView* modalView;

@property (nonatomic, strong) UIImageView* mockShareView;
@property (nonatomic, strong) ProductLadderCell* productLadderCell;
@property (nonatomic, strong) ProductDetailCell* productDetailCell;
@property (nonatomic, strong) ProductCompanyCell* companyCell;
@property (nonatomic, strong) ProductOtherCompanyCell* otherCompayCell;

@end

@implementation ProductViewController

-(BuyProductView*)buyProductView
{
    if(!_buyProductView){
        _buyProductView = self.buyProductView =  [[[NSBundle mainBundle]loadNibNamed:@"BuyProductView" owner:nil options:nil] firstObject];
        [self.view addSubview:_buyProductView];
        @weakify(self);
        _buyProductView.determineButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            [self.modalView dismiss];
            
            PayViewController* payVC = [[PayViewController alloc] init];
            [self.navigationController pushViewController:payVC animated:YES];
            
            return [RACSignal empty];
        }];
        
        _buyProductView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input){
            
            [self.modalView dismiss];
            return [RACSignal empty];
        }];
    }
    
    return _buyProductView;
}

-(UIImageView*)mockShareView
{
    if (!_mockShareView) {
        _mockShareView = [[UIImageView alloc] initWithImage:[@"share_demo" image]];
    }
    
    return _mockShareView;
}


-(UIView*)buttomView
{
    if(!_buttomView){
        _buttomView = [[UIView alloc] init];
        [self.view addSubview:_buttomView];
        _buttomView.backgroundColor = [UIColor clearColor];
        
        [_buttomView addSubview:self.timeLabel];
        [_buttomView addSubview:self.payButton];
        [_buttomView addSubview:self.orderButton];
    }
    
    return _buttomView;
}

-(M80AttributedLabel*)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[M80AttributedLabel alloc] init];
        _timeLabel.backgroundColor = RGBCOLOR(133, 133, 133);
        _timeLabel.textAlignment = kCTTextAlignmentCenter;
        //just for debug
        [self fomartTimeLabel];
    }
    
    return _timeLabel;
}

-(void)fomartTimeLabel
{
    self.timeLabel.text = @"";
    NSString* timeString = @"";
    if (!self.productDetailDto) {
        timeString = @"10天18小时20分钟";
    }
    else {
        if (self.productDetailDto && (self.productDetailDto.active && self.productDetailDto.millisecond>0)) {
            UIImageView* clockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
            clockView.image = [UIImage imageNamed:@"clock_white"];
            [self.timeLabel appendView:clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
            [self.timeLabel appendText:@" "];
            timeString = [NSString leftTimeString:self.productDetailDto.millisecond];
        }
        else {
            timeString = self.productDetailDto.stateLabel;
        }
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:timeString];
    [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
    [attributedText m80_setTextColor:[UIColor whiteColor]];
    [self.timeLabel appendAttributedText:attributedText];
}

-(UIButton*)payButton
{
    if(!_payButton){
        _payButton = [[UIButton alloc] init];
        [_payButton setTitle:@"立刻付款" forState:UIControlStateNormal];
        [_payButton bs_configureAsPrimaryStyle];
        _payButton.layer.cornerRadius = 0;
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.2] forState:UIControlStateHighlighted];
        
        _payButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            if ([UserCenter defaultCenter].isLogined) {
                self.modalView.presentAnimationStyle = SlideInUp;
                self.modalView.dismissAnimationStyle = SlideOutDown;
                self.modalView.contentView = self.buyProductView;
                self.modalView.isCancelAble = YES;
                @weakify(self);
                [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
                    @strongify(self);
                    contentView.x = 0;
                    contentView.y = [UIScreen mainScreen].bounds.size.height - contentView.height;
                    contentView.width = [UIScreen mainScreen].bounds.size.width;
                    
                    BuyProductView* buyProductView = (BuyProductView*)contentView;
                    
                    
                }];

            }
            else {
                LoginViewController* loginVC = [[LoginViewController alloc] init];
                loginVC.fromVC = self;
                [self.navigationController pushViewController:loginVC animated:YES];
            }

            return [RACSignal empty];
        }];
        


    }
    
    return _payButton;
}

-(UIButton*)orderButton
{
    if(!_orderButton){
        _orderButton = [[UIButton alloc] init];
        [_orderButton setTitle:@"加入订货单" forState:UIControlStateNormal];
        [_orderButton bs_configureAsDangerStyle];
        _orderButton.layer.cornerRadius = 0;
        [_orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_orderButton setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.2] forState:UIControlStateHighlighted];
        
        _orderButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal empty];
        }];
        
    }
    
    return _orderButton;
}

-(ProductLadderCell*)productLadderCell
{
    if (!_productLadderCell) {
        _productLadderCell = (ProductLadderCell*)[UINib viewFromNib:@"ProductLadderCell"];
        
    }
    return _productLadderCell;
}

-(ProductDetailCell*)productDetailCell
{
    if (!_productDetailCell) {
        _productDetailCell = (ProductDetailCell*)[UINib viewFromNib:@"ProductDetailCell"];
        
    }
    return _productDetailCell;
}

-(ProductCompanyCell*)companyCell
{
    if (!_companyCell) {
        _companyCell = (ProductCompanyCell*)[UINib viewFromNib:@"ProductCompanyCell"];
        
    }
    return _companyCell;
}

-(ProductOtherCompanyCell*)otherCompayCell
{
    if (!_otherCompayCell) {
        _otherCompayCell = (ProductOtherCompanyCell*)[UINib viewFromNib:@"ProductOtherCompanyCell"];
        _otherCompayCell.hidden = YES;
        
    }
    return _otherCompayCell;
}

-(instancetype)initWithProductDTO:(BaseProductDTO *)dto
{
    self = [super init];
    if(self){
        self.productDto = dto;
    }
    return self;
}

-(void)setProductDetailDto:(BaseProductDetailDTO *)productDetailDto
{
    _productDetailDto = productDetailDto;
    _productDetailDto.goodImage = self.productDto.goodImage;
    [self fomartTimeLabel];
    if(productDetailDto.isStep){
        self.productLadderCell.productDetailDto = productDetailDto;
        
    }
    else {
        self.productDetailCell.productDetailDto = productDetailDto;
    }
    self.companyCell.productDetailDto = productDetailDto;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.productDisplayMode = kDisplayMode0;
    
    self.navigationItem.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"switch"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
//        self.productDisplayMode = self.productDisplayMode == kDisplayMode0 ? kDisplayMode1 : kDisplayMode0;
//        [self.tableView reloadData];
        return [RACSignal empty];
    }];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _modalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];
    
    _modalView.modalWindowFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    _modalView.modalWindowLevel = UIWindowLevelNormal;
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
       
        self.modalView.presentAnimationStyle = SlideInUp;
        self.modalView.dismissAnimationStyle = SlideOutDown;
        self.modalView.contentView = self.mockShareView;
        self.modalView.isCancelAble = YES;
        @weakify(self);
        [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
            @strongify(self);
            contentView.height = 220.f;
            contentView.x = 0;
            contentView.y = [UIScreen mainScreen].bounds.size.height - contentView.height;
            contentView.width = [UIScreen mainScreen].bounds.size.width;
        }];

        
        return [RACSignal empty];
    }];

}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    self.webView.frame = self.view.bounds;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

    self.buttomView.frame = CGRectMake(0, self.view.bounds.size.height-70, self.view.bounds.size.width, 70);
    self.timeLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    self.payButton.frame = CGRectMake(0, 20, self.view.bounds.size.width/2, 50);
    self.orderButton.frame = CGRectMake(self.view.bounds.size.width/2, 20, self.view.bounds.size.width/2, 50);
    
//    [self.view bringSubviewToFront:self.buyProductView];
//    self.buyProductView.frame = [UIScreen mainScreen].bounds;
//    self.buyProductView.y = 100;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

#pragma -- mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        return 10.f;
    }
    if (indexPath.row==1) {
        if (self.productDetailDto.isStep) {
            return [ProductLadderCell cellHeight];
        }
        else {
            return [self.productDetailCell cellHeight];
        }
    }
    else if(indexPath.row == 3){
        return [ProductCompanyCell cellHeight];
    }
    else {
        return [ProductOtherCompanyCell cellHeight];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.row%2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HeadViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeadViewCell"];
        }
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        if(self.productDetailDto.isStep){
            cell = self.productLadderCell;
            self.productLadderCell.productDetailDto = self.productDetailDto;
            
        }
        else {
            cell = self.productDetailCell;
            self.productDetailCell.productDetailDto = self.productDetailDto;
            
        }
    }
    else if(indexPath.row == 3){
        cell = self.companyCell;
    }
    else{
        cell = self.otherCompayCell;

    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    switch (indexPath.section) {
//        case kSectionInfo:
//        {
//            MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
//            [self.navigationController pushViewController:mineSellProductVC animated:YES];
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == kSectionOverview) {
//        return 0.f;
//    }
//    
   return 0.f;
}


@end
