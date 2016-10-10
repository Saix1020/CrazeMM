//
//  BuySlideDetailViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuySlideDetailViewController : UIViewController<UIWebViewDelegate>

-(instancetype)initWithURL:(NSString*)url andTitle:(NSString*)title;
-(instancetype)initWithURLRequest:(NSURLRequest*)request;


@end
