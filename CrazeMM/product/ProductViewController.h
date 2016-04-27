//
//  ProductViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProductDisplayMode){
    kDisplayMode0 = 0,
    kDisplayMode1
};

@interface ProductViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) ProductDisplayMode productDisplayMode;


@end
