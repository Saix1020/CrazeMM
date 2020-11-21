//
//  BuySlideDetailViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuySlideDetailViewController.h"
#import "UITabBarController+HideTabBar.h"

@interface BuySlideDetailViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, strong) NSURLRequest* request;
@property (nonatomic, copy) NSString* webTitle;
@property (nonatomic) BOOL isInternalUrl;

@property (nonatomic, strong) UIButton* cancelButton;

@end

@implementation BuySlideDetailViewController

-(instancetype)initWithURL:(NSString*)url andTitle:(NSString*)title
{
    self = [super init];
    if(self){
        self.url = url;
        self.webTitle = title;
        self.isInternalUrl = [self.url hasPrefix:WEB_HOSTNAME];
    }
    return self;
}

-(instancetype)initWithURLRequest:(NSURLRequest*)request;
{
    self = [super init];
    if(self){
        self.request = request;
        self.isInternalUrl = [self.request.URL.absoluteString hasPrefix:WEB_HOSTNAME];

    }
    return self;
}

-(UIButton*)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-40, 4, 32, 32);
        [_cancelButton setImage:[@"cancel_m" image] forState:UIControlStateNormal];
        _cancelButton.tintColor = [UIColor whiteColor];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

-(void)cancel:(id)sender
{
    if (self.isInternalUrl) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        if (self.navigationController.viewControllers.count>1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        if (self.isInternalUrl) {
            [_webView addSubview:self.cancelButton];
        }
    }
    
    return _webView;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.request) {
        [self.webView loadRequest:self.request];
    }
    else {
        NSURL *url = [NSURL URLWithString:self.url];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    
    
    self.webView.delegate = self;
   
    self.navigationItem.title = self.webTitle;
    
    //self.navigationController.toolbarHidden = YES;
    
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + self.tabBarController.view.bounds.size.height);
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;

    [self.tabBarController setTabBarHidden:YES animated:YES];
//    [self.navigationController setToolbarHidden:YES animated:YES];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;

//    [self.navigationController setToolbarHidden:NO animated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* url = request.URL.absoluteString;
    if ([url hasPrefix:WEB_HOSTNAME] && ([url hasSuffix:@"/buy"] || [url hasSuffix:@"/supply"])) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

@end
