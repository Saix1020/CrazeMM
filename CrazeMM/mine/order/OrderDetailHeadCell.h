//
//  OrderHeadCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

-(void)setTitleLabelColor:(UIColor*)color;

+(CGFloat)cellHeight;
@end
