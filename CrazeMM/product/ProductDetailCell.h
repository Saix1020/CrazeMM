//
//  ProductDetailCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductDetailDTO.h"
#import "M80AttributedLabel.h"
#import "ArrowView.h"

@interface ProductDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
@property (weak, nonatomic) IBOutlet UILabel *browserLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UIView *browserAndSellLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detalLabel;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet M80AttributedLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *flagLabel;
@property (weak, nonatomic) IBOutlet UILabel *expressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property(nonatomic, strong) ArrowView* arrowView;
@property (weak, nonatomic) IBOutlet UIImageView *traingleView;

@property (nonatomic, strong) BaseProductDetailDTO* productDetailDto;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, readonly) CGFloat cellHeight;

+(CGFloat)cellHeight;

@end
