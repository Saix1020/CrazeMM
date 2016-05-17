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
        NSURL *url = [[NSURL alloc]  initWithString:IBSB_PAY_URL];
        self.request = [NSMutableURLRequest requestWithURL:url];
        [self.request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
        [self.request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [self.request addValue:HTTP_HEADER_REFERER_URL forHTTPHeaderField: @"Origin"];
        [self.request addValue:HTTP_HEADER_REFERER_URL forHTTPHeaderField: @"Referer"];
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"cancel" image] style:UIBarButtonItemStylePlain target:self action:@selector(payCancel:)];
}

-(void)payCancel:(id) sender
{
//    [self showAlertViewWithMessage:(NSString *)]
    [self showAlertViewWithMessage:@"您确认要离开支付页面吗?"
                    withOKCallback:^(id x){
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                 andCancelCallback:^(id x){
                 }];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64.f, 0, 0, 0);
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
