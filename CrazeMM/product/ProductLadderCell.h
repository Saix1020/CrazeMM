//
//  ProductLadderCell.h
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductDetailDTO.h"
#import "ProductFlageView.h"
#import "M80AttributedLabel.h"
#import "ArrowView.h"

@interface ProductLadderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet ProductFlageView *flageView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel2;
@property (weak, nonatomic) IBOutlet UIView*browserDealView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel3;
@property (weak, nonatomic) IBOutlet UIView *stepPricesView;
@property (weak, nonatomic) IBOutlet UIImageView *triangleView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *price1;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *price2;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *price3;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *stockLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *flagTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UILabel *expressLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseLabel;

@property (strong, nonatomic) ArrowView* arrowView;

@property (strong, nonatomic) BaseProductDetailDTO* productDetailDto;
@property (nonatomic, readonly) CGFloat cellHeight;

+(CGFloat)cellHeight;

@end
