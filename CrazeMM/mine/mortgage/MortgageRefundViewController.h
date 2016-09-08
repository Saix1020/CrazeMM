//
//  MortgageRefundViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MortgageRefundViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithDtos:(NSArray *)selectedDtos;

@end
