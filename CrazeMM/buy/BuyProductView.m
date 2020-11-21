//
//  BuyProductView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/23.
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
    self.amountTextField.text = @"0";
    self.amountTextField.textColor = [UIColor grayColorL2];
    
    self.amountLabel.textColor = [UIColor grayColorL2];
    self.descLabel.textColor = [UIColor grayColorL2];
    self.descTextView.textColor = [UIColor grayColorL2];
    
    self.price = 10200.f;
    [self fomartAmountPrice];
    
    [self.addButton addTarget:self action:@selector(addOrSubButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.subButton addTarget:self action:@selector(addOrSubButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    self.amountTextField.delegate = self;
    self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.descTextView.delegate = self;
    
//    [RACObserve(self, amountTextField.text) subscribeNext: ^(NSString *newName){
//        if([newName integerValue]>self.productDetailDto.left){
//            self.amountTextField.text = [NSString stringWithFormat:@"%ld", self.productDetailDto.left];
//        }
//        else if([newName integerValue]<=0){
//            self.amountTextField.text = @"1";
//
//        }
//        else {
//            [self fomartAmountPrice];
//
//        }
//    }];
}

-(void)addOrSubButtonClicked:(UIButton*)button
{
    NSInteger amount = [self.amountTextField.text integerValue];
    if (button ==  self.addButton) {
        if (amount >= self.productDetailDto.left) {
            return;
        }
        else {
            self.amountTextField.text = [NSString stringWithFormat:@"%ld", amount+1];
        }
    }
    else if(button == self.subButton){
        if (amount <= 1) {
            return;
        }
        else {
            self.amountTextField.text = [NSString stringWithFormat:@"%ld", amount-1];
        }
    }
    
    [self fomartAmountPrice];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString* finnalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (finnalString.length == 0) {
        textField.text = @"";
    }
    else if ([finnalString integerValue]>self.productDetailDto.left) {
        textField.text = [NSString stringWithFormat:@"%ld", self.productDetailDto.left];;
    }
    else if([finnalString integerValue]<=0){
        textField.text = @"1";

    }
    else {
        textField.text = finnalString;
    }
    [self fomartAmountPrice];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [textField resignFirstResponder];
    [self.descTextView becomeFirstResponder];
    return NO;
}


-(void)fomartAmountPrice
{
    self.amountPrice.text = @"";
    
    UIFont* middleFont = [UIFont systemFontOfSize:16];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    UIColor* grayColor = [UIColor grayColorL2];
    UIColor* redColor = [UIColor redColor];
    NSInteger number = [self.amountTextField.text intValue];
    CGFloat totalPrice = [self.productDetailDto totalPriceWithAmount:number];

    NSString* amount = [NSString stringWithFormat:@"%.02f", totalPrice];
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

-(void)setProductDetailDto:(BaseProductDetailDTO *)productDetailDto
{
    _productDetailDto = productDetailDto;
    self.amountTextField.text = [NSString stringWithFormat:@"%ld", (long)productDetailDto.left];
    self.descTextView.text = @"";

    self.price = productDetailDto.price;
    [self fomartAmountPrice];
    
    if (!productDetailDto.isSplit) {
        self.addButton.enabled = NO;
        self.subButton.enabled = NO;
        self.amountTextField.userInteractionEnabled = NO;
        self.addButton.tintColor = [UIColor whiteColor];
        self.subButton.tintColor = [UIColor whiteColor];

    }
    else {
        self.addButton.enabled = YES;
        self.subButton.enabled = YES;
        self.amountTextField.userInteractionEnabled = YES;
        self.addButton.tintColor = [UIColor darkGrayColor];
        self.subButton.tintColor = [UIColor darkGrayColor];
    }
}

@end
