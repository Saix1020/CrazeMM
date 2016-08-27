//
//  InfoLabelCell.h
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoLabelCell : UITableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* infoLabel;
@property (nonatomic, strong) UIView* seperatorLine;

@property (nonatomic) CGFloat titleWidth;

@end
