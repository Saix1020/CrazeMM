//
//  BuyProductView.m
//  CrazeMM
//
//  Created by saix on 16/4/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyProductView.h"

@implementation BuyProductView

-(void)awakeFromNib
{
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self.subButton setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
    [self.subButton setTitle:@"" forState:UIControlStateNormal];
    [self.addButton setImage:[UIImage imageNamed:@"plus-1"] forState:UIControlStateNormal];
    [self.addButton setTitle:@"" forState:UIControlStateNormal];
    self.addButton.tintColor = [UIColor whiteColor];
    self.subButton.tintColor = [UIColor whiteColor];
    self.addButton.backgroundColor = [UIColor light_Gray_Color];
    self.subButton.backgroundColor = [UIColor light_Gray_Color];
    
    [self.cancelButton setTitle:@"" forState:UIControlStateNormal];
    [self.cancelButton setImage:[UIImage imageNamed:@"cancel_x"] forState:UIControlStateNormal];
    self.cancelButton.tintColor = [UIColor whiteColor];
    self.cancelButton.backgroundColor = [UIColor light_Gray_Color];
    self.cancelButton.layer.cornerRadius = self.cancelButton.width/2;
    
    self.descTextView.layer.borderWidth = 1;
    self.descTextView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.amountTextField.layer.borderWidth = 1;
    self.amountTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    [self.determineButton setTitle:@"确定" forState:UIControlStateNormal];
    
//    self.amountLabel.text = @"";
    self.amountTextField.text = @"10";
    self.amountTextField.textColor = [UIColor grayColorL2];
    
    self.amountLabel.textColor = [UIColor grayColorL2];
    self.descLabel.textColor = [UIColor grayColorL2];
    self.descTextView.textColor = [UIColor grayColorL2];
    
    self.price = 10200.f;
    [self fomartAmountPrice];
    

}

-(void)fomartAmountPrice
{
    self.amountPrice.text = @"";
    
    UIFont* middleFont = [UIFont systemFontOfSize:16];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    UIColor* grayColor = [UIColor grayColorL2];
    UIColor* redColor = [UIColor redColor];
    
    NSString* amount = [NSString stringWithFormat:@"%.2f", self.price * [self.amountTextField.text intValue]];
    NSArray* amounts = [amount componentsSeparatedByString:@"."];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"[ 总价"];
    [attributedText m80_setFont:smallFont];
    [attributedText m80_setTextColor:grayColor];
    [self.amountPrice appendAttributedText:attributedText];
    
    [self.amountPrice appendText:@" "];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:smallFont];
    [attributedText m80_setTextColor:redColor];
    [self.amountPrice appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:amounts[0]];
    [attributedText m80_setFont:middleFont];
    [attributedText m80_setTextColor:redColor];
    [self.amountPrice appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@".%@", amounts[1]]];
    [attributedText m80_setFont:smallFont];
    [attributedText m80_setTextColor:redColor];
    [self.amountPrice appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@" "];
    [attributedText m80_setFont:middleFont];
    [attributedText m80_setTextColor:grayColor];
    [self.amountPrice appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"]"];
    [attributedText m80_setFont:smallFont];
    [attributedText m80_setTextColor:grayColor];
    [self.amountPrice appendAttributedText:attributedText];
}

@end
