//
//  AddrCommonCell.m
//  CrazeMM
//
//  Created by saix on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrCommonCell.h"

@implementation AddrCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(NSString*)title
{
    return self.titleLabel.text;
}

-(void)setValue:(NSString *)value
{
    self.textFieldCell.text = value;
}

-(NSString*)value
{
    return self.textFieldCell.text;
}

-(void)setPlacehoder:(NSString *)placehoder
{
    self.textFieldCell.placeholder = placehoder;
}

-(NSString*)placehoder
{
    return self.textFieldCell.placeholder;
}


@end
