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
#import "HttpAddIntention.h"


#define DEBUG_MODE

@interface ProductViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) M80AttributedLabel* timeLabel;

@property (nonatomic, strong) UIImageView* imageView;//just for debug

@property (nonatomic, strong) UIImageView* mockShareView;
@property (nonatomic, strong) ProductLadderCell* productLadderCell;
@property (nonatomic, strong) ProductDetailCell* productDetailCell;
@property (nonatomic, strong) ProductCompanyCell* companyCell;
@property (nonatomic, strong) ProductOtherCompanyCell* otherCompayCell;

@end

@implementation ProductViewController

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
    }
    
    return _buttomView;
}

-(M80AttributedLabel*)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[M80AttributedLabel alloc] init];
        _timeLabel.backgroundColor = RGBCOLOR(133, 133, 133);
        _timeLabel.textAlignment = kCTTextAlignmentCenter;
        [self.buttomView addSubview:_timeLabel];
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
        timeString = @"";
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
    self.sectionNum = 1;
    [self.tableView reloadData];
}

-(TTModalView*)modalView{
    if (!_modalView) {
        _modalView = [[TTModalView alloc] initWithContentView:nil delegate:self];
        
        _modalView.modalWindowFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        _modalView.modalWindowLevel = UIWindowLevelNormal;
        

    }
    return _modalView;
}

-(void)handleOrderWithQuantity:(NSInteger)quantity andMessage:(NSString*)message
{
//    [self.modalView dismiss];
}

-(void)handleBuyWithQuantity:(NSInteger)quantity andMessage:(NSString*)message
{
}

-(void)getProductDetail:(BOOL)needHud
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    
    // disable sharing
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"switch"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    @weakify(self);

    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        self.modalView.presentAnimationStyle = SlideInUp;
        self.modalView.dismissAnimationStyle = SlideOutDown;
        self.modalView.contentView = self.mockShareView;
        self.modalView.isCancelAble = YES;
        [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
            contentView.height = 220.f;
            contentView.x = 0;
            contentView.y = [UIScreen mainScreen].bounds.size.height - contentView.height;
            contentView.width = [UIScreen mainScreen].bounds.size.width;
        }];

        
        return [RACSignal empty];
    }];
    
    self.sectionNum = 0;

}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.buttomView.frame = CGRectMake(0, self.view.bounds.size.height-70, self.view.bounds.size.width, 70);
    self.timeLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.sectionNum = 0;
    [self.tableView reloadData];
    [self getProductDetail:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma -- mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        return 10.f;
    }
    if (indexPath.row==1) {
        if (self.productDetailDto.isStep) {
            return [self.productLadderCell cellHeight];
        }
        else {
            return [self.productDetailCell cellHeight];
        }
    }
    else if(indexPath.row == 3){
        
        //if(self.productDetailDto.
        
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.f;
}

#pragma -- mark TTModalView Delgate
-(void)TTModalViewDidShow:(TTModalView *)TTModalView
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)TTModalViewDidDismiss:(TTModalView *)TTModalView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];    
}



-(void)keyboardWillHide: (NSNotification *)notification
{
//    NSDictionary *userInfo = [notification userInfo];
//    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];

    [UIView animateWithDuration:0.5 animations:^{
        self.modalView.contentView.y = [UIScreen mainScreen].bounds.size.height - self.modalView.contentView.height;
    }];

}

-(void)keyboardWillShow: (NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    [UIView animateWithDuration:0.5 animations:^{
        self.modalView.contentView.y = [UIScreen mainScreen].bounds.size.height - self.modalView.contentView.height - keyboardRect.size.height;
    }];

    
}


@end
