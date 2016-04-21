//
//  ProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductViewController.h"
#import "LLBootstrap.h"


#define DEBUG_MODE

@interface ProductViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) UIView* buttomView;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) UIButton* orderButton;

@property (nonatomic, strong) UIImageView* imageView;//just for debug



@end

@implementation ProductViewController

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

-(UILabel*)timeLabel
{
    if(!_timeLabel){
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"hh天mm小时dd分钟"];

        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"🕑10天18小时20分钟";
        _timeLabel.backgroundColor = RGBCOLOR(133, 133, 133);
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
//        RACSignal *updateEventSignal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
//        [updateEventSignal subscribeNext:^(id x){
//            _timeLabel.text = [NSString stringWithFormat:@"🕑%@", @"XXXXXXXX"];
//        }];
//        
//        RAC(self, timeLabel) = updateEventSignal;
    }
    
    return _timeLabel;
}

-(UIButton*)payButton
{
    if(!_payButton){
        _payButton = [[UIButton alloc] init];
        [_payButton setTitle:@"立刻购买" forState:UIControlStateNormal];
        [_payButton bs_configureAsPrimaryStyle];
        _payButton.layer.cornerRadius = 0;
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.2] forState:UIControlStateHighlighted];
        
        _payButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
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
    
    self.navigationItem.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallet"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    self.webView = [[UIWebView alloc] init];
    NSString *pathImg = [[NSBundle mainBundle] pathForResource:@"product_debug" ofType:@"png"];
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL fileURLWithPath:pathImg];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
    self.buttomView.frame = CGRectMake(0, self.view.bounds.size.height-80, self.view.bounds.size.width, 80);
    self.timeLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 20);
    self.payButton.frame = CGRectMake(0, 20, self.view.bounds.size.width/2, 60);
    self.orderButton.frame = CGRectMake(self.view.bounds.size.width/2, 20, self.view.bounds.size.width/2, 60);
}

@end
