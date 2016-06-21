//
//  SupplyListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyListCell.h"

@implementation SupplyListCell

- (void)awakeFromNib
{
   
    self.selectCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectCheckBox.onTintColor = [UIColor redColor];
    self.selectCheckBox.onFillColor = [UIColor redColor];
    self.selectCheckBox.boxType = BEMBoxTypeCircle;
    self.selectCheckBox.on = NO  ;
    self.selectCheckBox.animationDuration = 0.f;
    
//    [self fomartCompanyLabel];
//    [self fomartTotalPriceLabel];
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    [self fomartPriceLabel];
    
//    CGSize fontSize = [self.shareButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.shareButton.titleLabel.font}];
//    [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.shareButton.imageView.frame.size.width-4.f, 0, self.shareButton.imageView.frame.size.width+4.f)];
//    [self.shareButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];
    
    [self.shareButton exchangeImageAndText];
    [self.offButton exchangeImageAndText];
    [self.shareButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.offButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    //self.shareButton.buttonType =
    
    self.shareButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    
    self.offButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    
//    [self.shareButton setTintColor:[UIColor UIColorFromRGB:0x444444]  forState:UIControlStateNormal];
//    [self.offButton setTitleColor:[UIColor UIColorFromRGB:0x444444]  forState:UIControlStateNormal];
    
    //[self.shareButton setim:<#(nullable UIColor *)#> forState:<#(UIControlState)#>]

    self.flagLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];//
    self.flagLabel.layer.cornerRadius = 4.f;
    self.flagLabel.clipsToBounds = YES;
    self.flagLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];

}


-(void)fomartPriceLabel
{
    NSString* priceString = self.priceLabel.text;
    
    NSArray* subStrings = [priceString componentsSeparatedByString:@" "];
    NSString* firstComponent = subStrings[0];
    NSString* secondComopent = [[subStrings subarrayWithRange:NSMakeRange(1, subStrings.count-1)] componentsJoinedByString:@""];
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:firstComponent
                                           attributes:@{
                                                        NSForegroundColorAttributeName: self.priceLabel.textColor
                                                            }];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:secondComopent attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}]];
    
    self.priceLabel.text = @"";
    self.priceLabel.attributedText = attributedText;
    
    self.backgroundView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    //self.backgroundView.hidden = YES;
}

-(void)setStyle:(SupplyListCellStyle)style
{
    _style = style;
    
    switch (style) {
        case kNomalStyle:
            self.backgroundView.hidden = NO;
            self.shareButton.hidden = NO;
            self.offButton.hidden = NO;
            self.selectCheckBox.hidden = NO;
            [self.offButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            self.offButton.imageView.transform = CGAffineTransformMakeRotation(0);

            [self.offButton setTitle:@"下架" forState:UIControlStateNormal];
            self.flagLabel.text = @" 在售 ";
            break;
        case kOffShelfStyle:
            self.shareButton.hidden = YES;
            self.backgroundView.hidden = NO;
            self.offButton.hidden = NO;
            self.selectCheckBox.hidden = NO;
            [self.offButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            self.offButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            [self.offButton setTitle:@"上架" forState:UIControlStateNormal];
            self.flagLabel.text = @" 已下架 ";
            break;
        case kDealStyle:
            self.backgroundView.hidden = YES;
            self.offButton.hidden = YES;
            self.shareButton.hidden = YES;
            self.selectCheckBox.hidden = YES;
            self.flagLabel.text = @" 已成交 ";
//            self.shareButton.hidden = NO;
//            [self.shareButton setTitle:@"" forState:<#(UIControlState)#>]
            break;
        default:
            break;
    }
    
    
    if (self.selectCheckBox.hidden) {
        self.titleLabelLeadingContraint.constant = -16.f;
    }
    else {
        self.titleLabelLeadingContraint.constant = 8.f;
    }
    [self updateConstraints];
}

-(void)setMineSupplyProductDto:(MineSupplyProductDTO *)mineSupplyProductDto
{
    _mineSupplyProductDto = mineSupplyProductDto;
    
    self.titleLabel.text = [NSString stringWithFormat:@"供货单号: %ld", mineSupplyProductDto.id];
    self.dateLabel.text = mineSupplyProductDto.createTime;
    self.productLabel.text = mineSupplyProductDto.goodName;
    self.numberLabel.text = [NSString stringWithFormat:@"数量: %ld", mineSupplyProductDto.quantity];
    self.priceLabel.text = [NSString stringWithFormat:@"单台定价: ￥%.02f", mineSupplyProductDto.price];
    [self fomartPriceLabel];
    self.selectCheckBox.on = mineSupplyProductDto.selected;
    
    if (self.style == kOffShelfStyle) {
        // issue #1
        NSString* title = mineSupplyProductDto.state==400 ? @"已下架" : @"已过期";
        self.shareButton.hidden = NO;
        self.shareButton.userInteractionEnabled = NO;
        [self.shareButton setTitle:title forState:UIControlStateNormal];
//        self.shareButton.imageView.hidden = YES;
    }
    else {
        self.shareButton.hidden = YES;
        self.shareButton.userInteractionEnabled = YES;
    }
    
}

-(void)setMineStockDto:(MineStockDTO *)mineStockDto
{
    _mineStockDto = mineStockDto;
    self.titleLabel.text = [NSString stringWithFormat:@"编号: %ld", mineStockDto.id];
    self.dateLabel.text = mineStockDto.updateTime;
    self.productLabel.text = mineStockDto.goodName;
    self.numberLabel.text = [NSString stringWithFormat:@"数量: %ld", mineStockDto.presale];
    self.priceLabel.text = [NSString stringWithFormat:@"单台定价: ￥%.02f", mineStockDto.inprice];
    [self fomartPriceLabel];
    self.selectCheckBox.on = mineStockDto.selected;
    [self fomartPriceLabel];
    
    self.shareButton.hidden = NO;
    self.shareButton.userInteractionEnabled = NO;
    [self.shareButton setTitle:mineStockDto.depotDto.name forState:UIControlStateNormal];

}

-(void)fomartStatusLabel
{
    NSMutableString* string = [[NSMutableString alloc]init];
    if (self.mineStockDto.isSerial) {
        [string appendString:@"带串码"];
    }
    if (self.mineStockDto.isOriginal) {
        [string appendString:@"原装"];
    }
    if (self.mineStockDto.isOriginalBox) {
        [string appendString:@"原封箱"];
    }
    if (self.mineStockDto.isBrushMachine) {
        [string appendString:@"已刷机"];
    }
    else {
        [string appendString:@"未刷机"];
    }
    self.statusLabel.text = string;
}

+(CGFloat)cellHeight
{
    return 160.f;
}

-(void)buttonClicked:(UIButton*)button
{
    if (button == self.offButton){
        if ([self.delegate respondsToSelector:@selector(buttonClicked:andType:andSid:)]) {
            [self.delegate buttonClicked:button andType:self.style andSid:self.mineSupplyProductDto.id];
        }
    }
    else if (button == self.shareButton){
        if ([self.delegate respondsToSelector:@selector(buttonClicked:andType:andSid:)]) {
            [self.delegate buttonClicked:button andType:kUnkonwStyle andSid:self.mineSupplyProductDto.id];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}

@end
