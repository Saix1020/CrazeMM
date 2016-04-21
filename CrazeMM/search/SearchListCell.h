//
//  SearchListCell.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelWithSeperatorLine.h"


@interface SearchListCell : UITableViewCell


@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *priceLabel;
@property (strong, nonatomic)  UIView *seperatorLine;
@property (strong, nonatomic)  UILabel *arrivalTime;
@property (strong, nonatomic)  UILabel *scopeLabel;
@property (strong, nonatomic)  UILabel *companyLabel;
@property (strong, nonatomic)  UILabel *leftTimeLabel;
@property (strong, nonatomic)  UILabel *typeLabel;
@property (strong, nonatomic)  LabelWithSeperatorLine *previewAndTransctionsLabels;

+(CGFloat)cellHeight;

@end
