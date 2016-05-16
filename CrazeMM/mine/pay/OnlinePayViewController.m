//
//  OnlinePayViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OnlinePayViewController.h"

@interface OnlinePayViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSMutableURLRequest* request;

@end

@implementation OnlinePayViewController

-(instancetype)initWithPayInfoDto:(PayInfoDTO*)payInfoDto
{
    self = [super init];
    if (self) {
        NSURL *url = [[NSURL alloc]  initWithString:@"https://ibsbjstar.ccb.com.cn/app/ccbMain"];
        self.request = [NSMutableURLRequest requestWithURL:url];
        [self.request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
        [self.request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [self.request addValue:@"zh-CN,zh;q=0.8,en;q=0.6" forHTTPHeaderField: @"Content-Type"];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[[payInfoDto formUrlencodedString] dataUsingEncoding:NSUTF8StringEncoding]];
        [self.request setHTTPBody:postBody];
    }
    return self;
}
//-(void)loadView
//{
//    self.view = [[UIWebView alloc] init];
//}

-(UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    
    return _webView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"银联在线支付";
    [self.webView loadRequest:self.request];
//    [self.webView setScalesPageToFit:YES];
    self.webView.delegate = self;
    self.webView.frame = self.view.frame;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + self.tabBarController.view.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView setScalesPageToFit:YES];

}



@end
