//
//  StockListCell.m
//  CrazeMM
//
//  Created by saix on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "StockListCell.h"

@implementation StockListCell

-(void)awakeFromNib
{
    self.selectCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectCheckBox.onTintColor = [UIColor redColor];
    self.selectCheckBox.onFillColor = [UIColor redColor];
    self.selectCheckBox.boxType = BEMBoxTypeCircle;
    self.selectCheckBox.on = NO  ;
    self.selectCheckBox.animationDuration = 0.f;
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    [self.offButton exchangeImageAndText];
    [self.offButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.stockLabel.tintColor = [UIColor UIColorFromRGB:0x444444];
    self.offButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    
    
    [self.pickupButton exchangeImageAndText];
    [self.pickupButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.pickupButton.tintColor = [UIColor UIColorFromRGB:0x444444];

    
    self.containerView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];

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
    
//    self.backgroundView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    //self.backgroundView.hidden = YES;
}

-(void)fomartNumberLabel
{
    
    NSString* firstComponent = [NSString stringWithFormat:@"总数: %ld ", self.mineStockDto.presale+self.mineStockDto.insale];
    
    NSString* secondComopent;
    if (self.mineStockDto.insale>0) {
        secondComopent = [NSString stringWithFormat:@"在售: %ld ", self.mineStockDto.insale];
    }
    else if(self.mineStockDto.outstock>0){
        secondComopent = [NSString stringWithFormat:@"待出库: %ld ", self.mineStockDto.outstock];

    }
    
    NSString* thirdComopent = self.mineStockDto.depotName.length>0?[NSString stringWithFormat:@"(%@)", self.mineStockDto.depotName] :@"";

    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:firstComponent
                                           attributes:@{
                                                        NSForegroundColorAttributeName: self.numberLabel.textColor,
                                                        NSFontAttributeName : [UIFont systemFontOfSize:14.f]
                                                        
                                                        }];
    if (secondComopent.length>0) {
        [attributedText appendAttributedString:[
                                                [NSAttributedString alloc] initWithString:secondComopent
                                                attributes:@{
                                                             NSForegroundColorAttributeName: [UIColor redColor],
                                                             NSFontAttributeName : [UIFont systemFontOfSize:12.f]                                                      }]];
    }
    
    [attributedText appendAttributedString:[
                                            [NSAttributedString alloc] initWithString:thirdComopent
                                            attributes:@{
                                                         NSForegroundColorAttributeName: self.numberLabel.textColor,
                                                         NSFontAttributeName : [UIFont systemFontOfSize:14.f]
                                                         
                                                         }]];
    
    self.numberLabel.text = @"";
    self.numberLabel.attributedText = attributedText;
}

-(void)fomartStatusLabel
{
    NSMutableString* string = [[NSMutableString alloc]init];
    if (self.mineStockDto.isSerial) {
        [string appendString:@"带串码 "];
    }
    if (self.mineStockDto.isOriginal) {
        [string appendString:@"原装 "];
    }
    if (self.mineStockDto.isOriginalBox) {
        [string appendString:@"原封箱 "];
    }
    if (self.mineStockDto.isBrushMachine) {
        [string appendString:@"已刷机"];
    }
    
    if (string.length>0) {
        self.statusLabel.hidden = NO;
        self.statusLabel.text = string;
        self.topSpaceContraint.constant = 25;
    }
    else {
        self.statusLabel.hidden = YES;
        self.statusLabel.text = @"";
        self.topSpaceContraint.constant = 4;

    }
    [self.contentView updateConstraints];

}

-(void)setMineStockDto:(MineStockDTO *)mineStockDto
{
    _mineStockDto = mineStockDto;
    self.titleLabel.text = [NSString stringWithFormat:@"编号: %ld", mineStockDto.id];
    self.dateLabel.text = mineStockDto.updateTime;
    self.productLabel.text = mineStockDto.goodName;
    self.priceLabel.text = [NSString stringWithFormat:@"单台定价: ￥%.02f", mineStockDto.inprice];
    [self fomartPriceLabel];
    [self fomartNumberLabel];
    self.selectCheckBox.on = mineStockDto.selected;
    self.stockLabel.text = mineStockDto.depotName;
    if(mineStockDto.stateLabel.length>0){
        self.flagLabel.text = [NSString stringWithFormat:@" %@ ", mineStockDto.stateLabel];
    }
    
    [self fomartStatusLabel];
}

+(CGFloat)cellHeight
{
    return 160.f;
}

-(void)buttonClicked:(UIButton*)button
{
    if (button == self.offButton){
        if ([self.delegate respondsToSelector:@selector(sellButtonClicked:andSid:)]) {
            [self.delegate sellButtonClicked:button andSid:self.mineStockDto.id];
        }
    }
    else if(button == self.pickupButton) {
        if ([self.delegate respondsToSelector:@selector(pickupButtonClicked:andSid:)]) {
            [self.delegate pickupButtonClicked:button andSid:self.mineStockDto.id];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(buttonClicked:andSid:)]) {
            [self.delegate buttonClicked:button andSid:self.mineStockDto.id];
        }

    }
    
}

-(void)setHiddenButtons:(BOOL)hiddenButtons
{
    _hiddenButtons = hiddenButtons;
    self.offButton.hidden = hiddenButtons;
    self.pickupButton.hidden = hiddenButtons;
}

-(void)setHiddenCheckBox:(BOOL)hiddenButtons
{
    _hiddenCheckBox = hiddenButtons;
    self.selectCheckBox.hidden = hiddenButtons;
    if(hiddenButtons){
        self.titleLeadingConstraint.constant = 8.f;
    }
    else {
        self.titleLeadingConstraint.constant = 32.f;

    }
    [self updateConstraints];
    
}

@end
