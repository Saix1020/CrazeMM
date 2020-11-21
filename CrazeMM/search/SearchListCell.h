//
//  SearchListCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LabelWithSeperatorLine.h"
#import "ArrowView.h"
#import "M80AttributedLabel.h"
#import "SearchResultDTO.h"

@interface SearchListCell : UITableViewCell


//@property (strong, nonatomic)  M80AttributedLabel *titleLabel;
@property (strong, nonatomic)  UILabel *titleLabel;

@property (strong, nonatomic)  UILabel *priceLabel;
@property (strong, nonatomic)  UIView *seperatorLine;
@property (strong, nonatomic)  UILabel *arrivalTime;
@property (weak, nonatomic)  UILabel *stockLabel;
@property (strong, nonatomic)  UILabel *scopeLabel;
@property (strong, nonatomic)  UIImageView *companyImageView;
@property (strong, nonatomic)  UILabel *companyLabel;
@property (strong, nonatomic)  M80AttributedLabel *leftTimeLabel;
@property (strong, nonatomic)  M80AttributedLabel *countdownLabel;
@property (strong, nonatomic)  ArrowView *typeLabel;
@property (strong, nonatomic)  UILabel* createTimeLabel;

@property (strong, nonatomic) NSString* typeName;

@property (strong, nonatomic)  LabelWithSeperatorLine *previewAndTransctionsLabels;
@property (readonly, strong, nonatomic) SearchResultDTO* searchResultDTO;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSString*)type;

-(void)setSearchResultDTO:(SearchResultDTO *)searchResultDTO andTypeName:(NSString*)typeName;

+(CGFloat)cellHeightWithDTO:(SearchResultDTO*)dto;

+(CGFloat)cellHeight;

@end
