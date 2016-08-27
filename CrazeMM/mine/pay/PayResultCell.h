//
//  PayResultCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resultIcon;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

+(CGFloat)cellHeigh;

@end
