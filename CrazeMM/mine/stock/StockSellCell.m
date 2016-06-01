//
//  StockSellCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "StockSellCell.h"

@implementation StockSellCell

- (void)awakeFromNib {
    // Initialization code
    self.unitPriceField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.unitPriceField.layer.borderWidth = .5f;
    self.unitPriceField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.totalNumField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.totalNumField.layer.borderWidth = .5f;
    self.totalNumField.text = [NSString stringWithFormat:@"%ld", self.totalCountNum];
    self.totalNumField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.seperateNumField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.seperateNumField.layer.borderWidth = .5f;
    self.seperateNumField.text = @"1";
    self.seperateNumField.keyboardType = UIKeyboardTypeNumberPad;
    
    //totalNumField
    @weakify(self);
    self.addButton1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        
        @strongify(self);
        NSUInteger totalNumber = self.totalCountNum;
        NSUInteger currentNumber = [self.totalNumField.text integerValue];
        
        if (currentNumber  < totalNumber) {
            self.seperateNumField.text = [NSString stringWithFormat:@"%lu", currentNumber+1];
        }
        
        return [RACSignal empty];
    }];
    
    self.subButton1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        
        @strongify(self);
        NSUInteger currentNumber = [self.totalNumField.text integerValue];
        
        if (currentNumber  > 0) {
            self.seperateNumField.text = [NSString stringWithFormat:@"%lu", currentNumber-1];
        }
        
        return [RACSignal empty];
    }];
    
    //seperateNumField
    self.addButton2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        
        @strongify(self);
        NSUInteger totalNumber = [self.totalNumField.text integerValue];
        NSUInteger currentNumber = [self.seperateNumField.text integerValue];
        
        if (currentNumber  < totalNumber) {
            self.seperateNumField.text = [NSString stringWithFormat:@"%lu", currentNumber+1];
        }
        
        return [RACSignal empty];
    }];
    
    self.subButton2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        
        @strongify(self);
        NSUInteger currentNumber = [self.seperateNumField.text integerValue];
        
        if (currentNumber  > 0) {
            self.seperateNumField.text = [NSString stringWithFormat:@"%lu", currentNumber-1];
        }
        
        return [RACSignal empty];
    }];
    
    self.selectCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectCheckBox.onTintColor = [UIColor redColor];
    self.selectCheckBox.onFillColor = [UIColor redColor];
    self.selectCheckBox.boxType = BEMBoxTypeCircle;
    self.selectCheckBox.on = YES  ;
    
    [self fomartTotalPriceLabel];
}

-(void)fomartTotalPriceLabel
{
    self.totalPriceLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    self.backgroundLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    
    self.totalPriceLabel.text = @"";
    self.totalPriceLabel.textAlignment = kCTTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"净赚: "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor grayColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"10200"];
    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:16.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@".00"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    [self.totalPriceLabel appendText:@""];
    self.totalPriceLabel.numberOfLines = 1;
    self.totalPriceLabel.offsetY = -4.f;
    //[self.totalPriceLabel sizeToFit];
    //self.totalPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
}


+(CGFloat)cellHeight
{
    return 150.f;
}

@end
