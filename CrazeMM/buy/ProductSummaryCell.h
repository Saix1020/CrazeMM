//
//  ProductSummaryCell.h
//  CrazeMM
//
//  Created by saix on 16/4/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrowView.h"
#import "M80AttributedLabel.h"

@interface ProductSummaryCell : UITableViewCell


@property (strong, nonatomic)  UIImageView *phoneImageView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *priceLabel;
@property (strong, nonatomic)  ArrowView *arrowView;
@property (strong, nonatomic)  UIView *bottomLine;
@property (strong, nonatomic)  UILabel *statusLabel;
@property (strong, nonatomic) UIView* timeBackgroundView;
@property (strong, nonatomic)  UILabel *timeLeftLabel;
@property (strong, nonatomic) UIImageView* clockIcon;

@property (nonatomic, copy) NSString* cellType;

@property (copy, nonatomic) NSString* arrawString;


+(CGFloat)cellHeight;


@end
