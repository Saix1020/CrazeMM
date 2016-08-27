//
//  FilterPriceCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FilterPriceCell.h"

@implementation FilterPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    self.maxField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
//    self.maxField.layer.borderWidth = 1.f;
    self.maxField.placeholder = @"最高价";
    
//    self.minField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
//    self.minField.layer.borderWidth = 1.f;
    self.minField.placeholder = @"最低价";
    
    self.maxField.keyboardType = UIKeyboardTypeDecimalPad;
    self.minField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)minPrice
{
    if (self.minField.text.length>0) {
        return [self.minField.text floatValue];
    }
    return -1;
}

-(float)maxPrice
{
    if (self.maxField.text.length>0) {
        return [self.maxField.text floatValue];
    }
    return -1;}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)reset
{
    self.maxField.text = @"";
    self.minField.text = @"";
}

@end
