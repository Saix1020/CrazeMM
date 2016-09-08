//
//  MortgageRefundCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/9/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MortgageRefundCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalInterest;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIView *garyView;
@property (nonatomic) NSInteger totalNum;
@property (nonatomic) NSInteger price;
@property (nonatomic)CGFloat interest;
@property (nonatomic)CGFloat money;


@end
