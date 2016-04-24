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


//@property (strong, nonatomic)  UIImageView *phoneImageView;
//@property (strong, nonatomic)  UILabel *titleLabel;
//@property (strong, nonatomic)  UILabel *detailLabel;
//@property (strong, nonatomic)  ArrowView *arrawView;
@property (copy, nonatomic) NSString* arrawString;
//@property (strong, nonatomic)  UIView *bottomLine;
//@property (strong, nonatomic)  UILabel *statusLabel;
//@property (strong, nonatomic)  M80AttributedLabel *timeLeftLabel;

+(CGFloat)cellHeight;


@end
