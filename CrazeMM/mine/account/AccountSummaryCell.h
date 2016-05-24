//
//  AccountSummaryCell.h
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSummaryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *amountMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *aviliableMoney;
@property (weak, nonatomic) IBOutlet UILabel *fronzenMoney;

@property (nonatomic) CGFloat frozenMoney;
@property (nonatomic) CGFloat money;


+(CGFloat)cellHeight;

@end
