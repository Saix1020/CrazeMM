//
//  MortgageRefundViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithDrawAlertView.h"

@protocol MortgageRefundViewControllerDelegate <NSObject>

-(void)repaySuccess;

@end

@interface MortgageRefundViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WithDrawAlertViewDelegate>
@property (nonatomic, weak) id<MortgageRefundViewControllerDelegate> delegate;

-(instancetype)initWithDtos:(NSArray *)selectedDtos;

@end
