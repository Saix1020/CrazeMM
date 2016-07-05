//
//  WithDrawAlertView.m
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithDrawAlertView.h"

@interface WithDrawAlertView ()

@property (nonatomic, strong) UITextField* hiddenTextField;
@property (nonatomic, strong) NSArray* textFields;
@end


@implementation WithDrawAlertView

-(UITextField*)hiddenTextField
{
    if (!_hiddenTextField) {
        _hiddenTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self addSubview:_hiddenTextField];
        _hiddenTextField.keyboardType = UIKeyboardTypeNumberPad;
        _hiddenTextField.delegate = self;
    }
    
    return _hiddenTextField;
}

-(void)awakeFromNib
{
//    self.firstNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.secondNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.thirdNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.fourthNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.fifthNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    self.sixthNumField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    
//    self.firstNumField.delegate = self;
//    self.secondNumField.delegate = self;
//    self.thirdNumField.delegate = self;
//    self.fourthNumField.delegate = self;
//    self.fifthNumField.delegate = self;
//    self.sixthNumField.delegate = self;
    [self.hiddenTextField becomeFirstResponder];
    
    self.textFields = @[
                        self.firstNumField,
                        self.secondNumField,
                        self.thirdNumField,
                        self.fourthNumField,
                        self.fifthNumField,
                        self.sixthNumField
                        ];
    
    for (UITextField* textField in  self.textFields) {
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.f];
//        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.secureTextEntry = YES;
        textField.userInteractionEnabled = NO;
    }

    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setAmount:(float)amount
{
    _amount = amount;
    self.totalAmount.text = [NSString stringWithFormat:@"总金额: ￥%.02f", amount];
}

-(NSString*)password
{
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",
            self.firstNumField.text,
            self.secondNumField.text,
            self.thirdNumField.text,
            self.fourthNumField.text,
            self.fifthNumField.text,
            self.sixthNumField.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString* finnalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (finnalString.length>=6) {
        if ([self.delegate respondsToSelector:@selector(DidFinishInput:)]) {
            [self.delegate DidFinishInput:finnalString];
        }
        return NO;
    }
    
    NSMutableArray* characters = [[NSMutableArray alloc] initWithArray:@[@"", @"", @"", @"", @"", @""]];
    for (NSUInteger index =0; index<finnalString.length; ++index) {
        characters[index] = [finnalString substringWithRange:NSMakeRange(index, 1)];
    }
    
    [characters enumerateObjectsUsingBlock:^(NSString* str, NSUInteger idx, BOOL *stop){
        UITextField* textField = [self.textFields objectAtIndex:idx];
        textField.text = str;
    }];
    
    return YES;
}

-(void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
}



@end
