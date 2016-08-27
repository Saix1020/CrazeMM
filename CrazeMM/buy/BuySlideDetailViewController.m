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
@end

@implementation BuySlideDetailViewController

-(instancetype)initWithURL:(NSString*)url andTitle:(NSString*)title
{
    self = [super init];
    if(self){
        self.url = url;
        self.webTitle = title;
    }
    return self;
}

-(instancetype)initWithURLRequest:(NSURLRequest*)request;
{
    self = [super init];
    if(self){
        self.request = request;
    }
    return self;
}

-(UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
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
   
    self.navigationItem.title = self.webTitle;
    
    //self.navigationController.toolbarHidden = YES;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + self.tabBarController.view.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.tabBarController setTabBarHidden:NO animated:YES];
//}


@end
