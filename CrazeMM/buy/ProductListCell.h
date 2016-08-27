//
//  ProductListCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M80AttributedLabel.h"
#import "ArrowView.h"
#import "ProductDescriptionDTO.h"

@interface ProductListCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *phoneImageView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (copy, nonatomic)  NSString* arrawString;
@property (strong, nonatomic)  UIView *bottomLine;
@property (strong, nonatomic)  UILabel *statusLabel;
@property (strong, nonatomic)  M80AttributedLabel *timeLeftLabel;
@property (strong, nonatomic)  M80AttributedLabel *detailLabel;

@property (strong, nonatomic) ArrowView* arrowView;

@property (strong, nonatomic) ProductDescriptionDTO* productDescDTO;

@property (weak, nonatomic) RACSignal* timeSignal;


+(CGFloat)cellHeight;

@end
