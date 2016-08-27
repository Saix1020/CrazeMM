//
//  OrderStatusCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderStatusCell.h"
#import "UIView+Utils.h"
#import "NSAttributedString+Utils.h"
@implementation OrderStatusCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor UIColorFromRGB:0xfff3f3];
    
    self.button1.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor blackColor];
    
    self.titleArray = @[@{@"name" : @"待付款", @"number" : @(10)},
                        @{@"name" : @"待签收", @"number" : @(10)},
                        @{@"name" : @"其他", @"number" : @(0)}];
    
    [self.button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (int i=0; i<titleArray.count; ++i) {
        UIButton* button;
        switch (i) {
            case 0:
                button = self.button1;
                break;
            case 1:
                button = self.button2;
                break;
            default:
                button = self.button3;
                break;
        }
        
        NSDictionary* dict = titleArray[i];
        NSInteger number = [dict[@"number"] integerValue];
        NSString* name = dict[@"name"];
        
        if (number>=0) {
            button.enabled = YES;

            NSArray* stringWithAttrs = @[
                                         @{
                                             @"string" : name,
                                             @"attributes" : @{
                                                     NSForegroundColorAttributeName : [UIColor dark_Gray_Color],
                                                     NSFontAttributeName : [UIFont systemFontOfSize:12.f]
                                                     }
                                             },
                                         @{
                                             @"string" : [NSString stringWithFormat:@" (%ld)", number],
                                             @"attributes" : @{
                                                     NSForegroundColorAttributeName : [UIColor redColor],
                                                     NSFontAttributeName : [UIFont systemFontOfSize:12.f]
                                                     }
                                             }
                                         ];
            NSAttributedString* attributedString = [NSAttributedString composedAttributedString:stringWithAttrs];
            [button setAttributedTitle:attributedString forState:UIControlStateNormal];
        }
        else{
//            button.enabled = NO;
            [button setAttributedTitle:nil forState:UIControlStateNormal];
            [button setTitle:name forState:UIControlStateNormal];
            [button setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];

        }

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)buttonClicked:(UIButton*)button
{
    if (self.delegate) {
        if (button == self.button1) {
            [self.delegate orderStatusCellButtonClicked:button andButtonIndex:1];
        }
        else if(button == self.button2){
            [self.delegate orderStatusCellButtonClicked:button andButtonIndex:2];

        }
        else if(button == self.button3){
            [self.delegate orderStatusCellButtonClicked:button andButtonIndex:3];
        }
    }
    
}

@end
