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
#import "ProductMiddleCell.h"
#import "ProductLastCell.h"




#define DEBUG_MODE

@interface ProductViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView* buttomView;
@property (nonatomic, strong) M80AttributedLabel* timeLabel;
@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) UIButton* orderButton;

@property (nonatomic, strong) BuyProductView* buyProductView;
@property (nonatomic, strong) ProductDetailCell* productDetailCell;

@property (nonatomic, strong) UIImageView* imageView;//just for debug
@property (nonatomic, strong) TTModalView* modalView;

@property (nonatomic, strong) UIImageView* mockShareView;

@end

@implementation ProductViewController

-(BuyProductView*)buyProductView
{
    if(!_buyProductView){
        _buyProductView = self.buyProductView =  [[[NSBundle mainBundle]loadNibNamed:@"BuyProductView" owner:nil options:nil] firstObject];
        [self.view addSubview:_buyProductView];
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
        UIImageView* clockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        clockView.image = [UIImage imageNamed:@"clock_white"];
        _timeLabel.textAlignment = kCTTextAlignmentCenter;
        [_timeLabel appendView:clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
        [_timeLabel appendText:@" "];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"10天18小时20分钟"];
        [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[UIColor whiteColor]];
        [_timeLabel appendAttributedText:attributedText];

    }
    
    return _timeLabel;
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
                    
                    buyProductView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input){
                        
                        [self.modalView dismiss];
                        return [RACSignal empty];
                    }];
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

    
//    self.webView = [[UIWebView alloc] init];
//    NSString *pathImg = [[NSBundle mainBundle] pathForResource:@"product_debug" ofType:@"png"];
//    [self.view addSubview:self.webView];
//    NSURL *url = [NSURL fileURLWithPath:pathImg];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
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
        if (self.productDisplayMode == kDisplayMode0) {
            return [ProductLadderCell cellHeight];
        }
        else {
            return [ProductDetailCell cellHeight];
        }
    }
    else if(indexPath.row == 3){
        return [ProductMiddleCell cellHeight];
    }
    else {
        return [ProductLastCell cellHeight];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.row%2 == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeadViewCell"];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        return cell;
    }
    
    if (indexPath.row == 1) {
        if(self.productDisplayMode == kDisplayMode0){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductLadderCell" owner:nil options:nil] firstObject];
            
        }
        else {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:nil options:nil] firstObject];
            
        }
    }
    else if(indexPath.row == 3){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductMiddleView" owner:nil options:nil] firstObject];
    }
    else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductLastCell" owner:nil options:nil] firstObject];

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
