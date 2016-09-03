//
//  StockListCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
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
    
    NSString* firstComponent = [NSString stringWithFormat:@"总数: %ld ", self.mineStockDto.total];
    
//    NSString* secondComopent;
//    
//    switch (self.mineStockDto.state) {
//        case 100:
//            break;
//        case 200: //已入库
//            if (self.mineStockDto.insale>0) {
//                secondComopent = [NSString stringWithFormat:@"在售: %ld ", self.mineStockDto.insale];
//            }
//            break;
//        case 300:
//            if(self.mineStockDto.outstock>0){
//                secondComopent = [NSString stringWithFormat:@"待出库: %ld ", self.mineStockDto.outstock];
//            }
//            break;
//        default:
//            if(self.mineStockDto.aftersale>0){
//                secondComopent = [NSString stringWithFormat:@"已售: %ld ", self.mineStockDto.aftersale];
//            }
//            break;
//            
//            break;
//    }
    
    NSString* thirdComopent = self.mineStockDto.depotName.length>0?[NSString stringWithFormat:@"(%@)", self.mineStockDto.depotName] :@"";

    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:firstComponent
                                           attributes:@{
                                                        NSForegroundColorAttributeName: self.numberLabel.textColor,
                                                        NSFontAttributeName : [UIFont systemFontOfSize:14.f]
                                                        
                                                        }];
//    if (secondComopent.length>0) {
//        
//        UIColor* color;
//        if (self.mineStockDto.state == 500) { //历史
//            color = [UIColor blueColor];
//        }
//        else {
//            color = [UIColor redColor];
//        }
//        [attributedText appendAttributedString:[
//                                                [NSAttributedString alloc] initWithString:secondComopent
//                                                attributes:@{
//                                                             NSForegroundColorAttributeName: color,
//                                                             NSFontAttributeName : [UIFont systemFontOfSize:12.f]                                                      }]];
//    }
    
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
//    NSMutableString* string = [[NSMutableString alloc]init];
//    if (self.mineStockDto.isSerial) {
//        [string appendString:@"带串码 "];
//    }
//    if (self.mineStockDto.isOriginal) {
//        [string appendString:@"原装 "];
//    }
//    if (self.mineStockDto.isOriginalBox) {
//        [string appendString:@"原封箱 "];
//    }
//    if (self.mineStockDto.isBrushMachine) {
//        [string appendString:@"已刷机"];
//    }
    self.statusLabel.text = @"";
    NSString* secondComopent;
    
    switch (self.mineStockDto.state) {
        case 100:
            break;
        case 200: //已入库
            if (self.mineStockDto.inmortgage>0) {
                secondComopent = [NSString stringWithFormat:@"已抵押: %ld ", self.mineStockDto.inmortgage];
            }
            else {
                secondComopent = [NSString stringWithFormat:@"可售: %ld ", self.mineStockDto.presale];
            }
            break;
        case 300:
//            if(self.mineStockDto.outstock>0){
                secondComopent = [NSString stringWithFormat:@"待出库: %ld ", self.mineStockDto.outstock];
//            }
            break;
        default:
//            if(self.mineStockDto.aftersale>0){
                secondComopent = [NSString stringWithFormat:@"已售: %ld ", self.mineStockDto.aftersale];
//            }
            break;
    }
    
    if (secondComopent.length>0) {
        
        UIColor* color;
        if (self.mineStockDto.state == 500) { //历史
            color = [UIColor blueColor];
        }
        else if(self.mineStockDto.state == 300){ //待入库
            color = [UIColor redColor];
        }
        else {
            color = [UIColor grayColor];
        }
        
        self.statusLabel.attributedText = [[NSAttributedString alloc] initWithString:secondComopent
                                                                          attributes:@{
                                                                                       NSForegroundColorAttributeName: color,
                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:12.f]                                                      }];
    }

    if (self.statusLabel.text.length>0) {
        self.statusLabel.hidden = NO;
        self.topSpaceContraint.constant = 23;
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
    self.priceLabel.text = [NSString stringWithFormat:@"入手单价: ￥%.02f", mineStockDto.inprice];
    [self fomartPriceLabel];
    [self fomartNumberLabel];
    self.selectCheckBox.on = mineStockDto.selected;
    self.stockLabel.text = mineStockDto.depotName;
    if(mineStockDto.stateLabel.length>0){
        self.flagLabel.text = [NSString stringWithFormat:@" %@ ", mineStockDto.stateLabel];
    }
    if (mineStockDto.state == 200 && mineStockDto.inmortgage>0) {
        self.flagLabel.text = [NSString stringWithFormat:@" %@/ 抵押 ", self.flagLabel.text];
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
