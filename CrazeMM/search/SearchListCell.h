//
//  SearchListCell.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelWithSeperatorLine.h"
#import "ArrowView.h"
#import "M80AttributedLabel.h"


@interface SearchListCell : UITableViewCell


@property (strong, nonatomic)  M80AttributedLabel *titleLabel;
@property (strong, nonatomic)  M80AttributedLabel *priceLabel;
@property (strong, nonatomic)  UIView *seperatorLine;
@property (strong, nonatomic)  UILabel *arrivalTime;
@property (strong, nonatomic)  UILabel *scopeLabel;
@property (strong, nonatomic)  UIImageView *companyImageView;
@property (strong, nonatomic)  UILabel *companyLabel;
@property (strong, nonatomic)  M80AttributedLabel *leftTimeLabel;
@property (strong, nonatomic)  ArrowView *typeLabel;

@property (strong, nonatomic) NSString* typeName;

@property (strong, nonatomic)  LabelWithSeperatorLine *previewAndTransctionsLabels;

+(CGFloat)cellHeight;

@end
