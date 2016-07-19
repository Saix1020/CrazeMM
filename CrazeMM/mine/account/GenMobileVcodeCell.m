//
//  GenMobileVcodeCell.m
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "GenMobileVcodeCell.h"

@implementation GenMobileVcodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.submitButton setTintColor:[UIColor UIColorFromRGB:0x04be02]];
    self.submitButton.layer.cornerRadius = 4.f;
    self.submitButton.layer.borderWidth = 1.f;
    self.submitButton.layer.borderColor = [UIColor UIColorFromRGB:0x04be02].CGColor;
}

-(NSString*)vcode
{
    return self.vcodeTextField.text;
}

@end
