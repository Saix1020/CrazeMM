//
//  OnlinePayViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OnlinePayViewController.h"
#import "HttpPay.h"
#import "PayResultViewController.h"
#import "OrderListViewController.h"
#import "CommonOrderListViewController.h"

@interface OnlinePayViewController ()

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSMutableURLRequest* request;
@property (nonatomic, strong) RACDisposable* queryPayResultDisposable;
@property (nonatomic) NSInteger queryPayResultSeconds;
@property (nonatomic) BOOL isQueryingPayResult;
@property (nonatomic) BOOL stopQuery;
@property (nonatomic, strong) PayInfoDTO* payInfoDto;
@end

@implementation OnlinePayViewController

-(instancetype)initWithPayInfoDto:(PayInfoDTO*)payInfoDto
{
    self = [super init];
    if (self) {
        self.payInfoDto = payInfoDto;
        NSURL *url = [[NSURL alloc]  initWithString:IBSB_PAY_URL];
        self.request = [NSMutableURLRequest requestWithURL:url];
        [self.request setHTTPMethod:@"POST"];
        NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
        [self.request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [self.request addValue:HTTP_HEADER_ORIGIN_URL forHTTPHeaderField: @"Origin"];
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
    @weakify(self);
    [self showAlertViewWithMessage:@"您确认要离开支付页面吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        
                        if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
                            UIViewController* vc = ((BaseNavigationController*)self.navigationController).markedVC;;
                            
                            if ([vc isKindOfClass:[CommonOrderListViewController class]]) {
                                CommonOrderListViewController* cvc = (CommonOrderListViewController*)vc;
                                if([cvc respondsToSelector:@selector(resetDataSource)]){
                                    [cvc resetDataSource];
                                }
                            }

                            [(BaseNavigationController*)self.navigationController popToMarkedViewControllerAnimated:YES];
                        }
                        else {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        // TODO
                        //[self.navigationController popToRootViewControllerAnimated:YES];
//                        NSArray* vcs = self.navigationController.viewControllers;
//                        if (vcs.count<=2) {
//                            [self.navigationController popToRootViewControllerAnimated:YES];
//                        }
//                        else {
//                            UIViewController* vc = vcs[vcs.count-2];
//                            // we should not back to the pay view controller
//                            // for the order is on paying status.
//                            // also we should refresh the list view.
//                            if ([vc isKindOfClass:NSClassFromString(@"PayViewController")]) {
//                                UIViewController* popVC = vcs[vcs.count-3];
//                                if([popVC isKindOfClass:NSClassFromString(@"OrderDetailViewController")]){
////                                    CommonOrderListViewController* cvc = (CommonOrderListViewController*)popVC;
////                                    [cvc resetDataSource];
//                                }
//                                [self.navigationController popToViewController:popVC animated:YES];
//                            }
//                            else {
//                                [self.navigationController popViewControllerAnimated:YES];
//                            }
//                        }
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
    [self tryQueryPayResult];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.stopQuery = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView setScalesPageToFit:YES];
    self.stopQuery = NO;
    @weakify(self);
    self.queryPayResultSeconds = 0;
    self.queryPayResultDisposable = [[[MMTimer sharedInstance] oneSecondSignal] subscribeNext:^(id x){
        @strongify(self);
        self.queryPayResultSeconds ++;
        
        
//        if (self.queryPayResultSeconds > 10) { // timeout
//            [self.queryPayResultDisposable dispose];
//            [self showAlertViewWithMessage:@"支付超时" withCallback:^(id x){
//                [self.navigationController popViewControllerAnimated:YES];
//                
//            }];
//        }
    } ];
    
    
//    [[[[MMTimer sharedInstance] oneSecondSignal]
//                         takeUntilBlock:^BOOL(id x){
//                             @strongify(self);
//                             return !self.stopQuery;
//                         }]
//                         subscribeNext:^(id x){
//                             @strongify(self);
//                             self.queryPayResultSeconds ++;
//                         }];
}

-(void)tryQueryPayResult
{
    //
    return;
    
    if (!self.stopQuery) {
        @weakify(self);
        HttpPayResultRequest* request = [[HttpPayResultRequest alloc] initWithPayNo:self.payInfoDto.ORDERID];
        [request request]
        .then(^(id responseObj){
            @strongify(self);
            NSLog(@"%@", responseObj);
            HttpPayResultResponse* response = (HttpPayResultResponse*)request.response;
            if (response.ok) {
                if (response.paySuccess) {
                    
                    [self showAlertViewWithMessage:@"支付成功!" withCallback:^(id x){
                        UIViewController* popToVC = nil;
                        for (UIViewController* vc in self.navigationController.viewControllers) {
                            if ([vc isKindOfClass:[OrderListViewController class]]) {
                                [(OrderListViewController*)vc operatorDoneForOrder:self.orderDetailDtos];
                                popToVC = vc;
                                break;
                            }
                            else if([vc isKindOfClass:NSClassFromString(@"ProductViewController")]){
                                popToVC = vc;
                                break;
                            }
                        }
                        if (!popToVC) {
                            [self.navigationController popToRootViewControllerAnimated:YES];
                        }
                        else {
                           [self.navigationController popToViewController:popToVC animated:YES]; 
                        }
                    }];
                    
                }
                else {
                    double delayInSeconds = 1.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self tryQueryPayResult];
                    });
                    

                }
            }
            else {
                double delayInSeconds = 1.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self tryQueryPayResult];
                });

            }
        })
        .catch(^(NSError* error){
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self tryQueryPayResult];
            });
        });
    }
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if ([request.URL.absoluteString hasPrefix:[NSString stringWithFormat:@"%@", HTTP_HEADER_ORIGIN_URL]]) {
        @weakify(self);
        [self showAlertViewWithMessage:@"支付成功!" withCallback:^(id x){
            @strongify(self);
//            UIViewController* popToVC = nil;
//            for (UIViewController* vc in self.navigationController.viewControllers) {
//                if ([vc isKindOfClass:[OrderListViewController class]]) {
//                    [(OrderListViewController*)vc operatorDoneForOrder:self.orderDetailDtos];
//                    popToVC = vc;
//                    break;
//                }
//                else if([vc isKindOfClass:NSClassFromString(@"ProductViewController")]){
//                    popToVC = vc;
//                    break;
//                }
//                else if([vc isKindOfClass:NSClassFromString(@"AccountViewController")]){
//                    popToVC = vc;
//                    break;
//                }
//            }
            
            if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
                UIViewController* vc = ((BaseNavigationController*)self.navigationController).markedVC;;
                
                if ([vc isKindOfClass:[CommonOrderListViewController class]]) {
                    CommonOrderListViewController* cvc = (CommonOrderListViewController*)vc;
                    if([cvc respondsToSelector:@selector(resetDataSource)]){
                        [cvc resetDataSource];
                    }
                }
                
                [(BaseNavigationController*)self.navigationController popToMarkedViewControllerAnimated:YES];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }

            
//            if (!popToVC) {
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//            else {
//                [self.navigationController popToViewController:popToVC animated:YES];
//            }
        }];
        return NO;
    }
    
    return YES;
}

-(void)dealloc
{
    NSLog(@"%@  dealloc", [self class]);
}

@end
