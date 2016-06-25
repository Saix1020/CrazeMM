//
//  PasswordAlertView.m
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PasswordInputView.h"

@interface PasswordInputView ()

@property (nonatomic, strong) UITextField* hiddenTextField;
@property (nonatomic, strong) NSArray* textFields;


@end

@implementation PasswordInputView
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
    [self.hiddenTextField becomeFirstResponder];
    
    self.textFields = @[
                        self.NumFiled1,
                        self.NumFiled2,
                        self.NumFiled3,
                        self.NumFiled4,
                        self.NumFiled5,
                        self.NumFiled6
                        ];
    
    for (UITextField* textField in  self.textFields) {
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:16.f];
        textField.secureTextEntry = YES;
        textField.userInteractionEnabled = NO;
        textField.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        textField.layer.borderWidth = 1.f;
    }
    
}


-(NSString*)password
{
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",
            self.NumFiled1.text,
            self.NumFiled2.text,
            self.NumFiled3.text,
            self.NumFiled4.text,
            self.NumFiled5.text,
            self.NumFiled6.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.text.length >6){
        return NO;
    }
    
    NSString* finnalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([self.delegate respondsToSelector:@selector(inputDidChanged:)]) {
        [self.delegate inputDidChanged:finnalString];
    }
    if (finnalString.length==6) {
        self.NumFiled6.text = string;
        textField.text = finnalString;
        
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

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.height = 116.f;
}

-(void)resetWithTitile:(NSString*)title
{
    [self reset];
    self.promptLabel.text = title;
}

-(void)reset
{
    for (UITextField* textField in  self.textFields) {
        textField.text = @"";
    }
    
    self.hiddenTextField.text = @"";
    
    if ([self.delegate respondsToSelector:@selector(inputDidChanged:)]) {
        [self.delegate inputDidChanged:@""];
    }

}

- (BOOL)resignFirstResponder
{

    return [self.hiddenTextField resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.hiddenTextField becomeFirstResponder];
    });

    return YES;
}

@end
