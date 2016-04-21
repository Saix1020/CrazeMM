//
//  LabelWithSeperatorLine.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "LabelWithSeperatorLine.h"

@interface LabelWithSeperatorLine()

@property (nonatomic, strong) NSMutableArray* seperatorLines;
@property (nonatomic, strong) NSMutableArray* stringLabels;

@end


@implementation LabelWithSeperatorLine

-(instancetype)init
{
    self = [super init];
    if(self){
        self.layer.borderWidth = .25f;
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.cornerRadius = 4.f;
    }
    
    return self;
}

-(void)setStrings:(NSArray *)strings
{
    _strings = strings;
    
    for (UIView* line in self.seperatorLines) {
        [line removeFromSuperview];
    }
    for (UIView* label in self.stringLabels) {
        [label removeFromSuperview];
    }

    
    if (strings.count == 0)
        return;
    
    self.seperatorLines = [[NSMutableArray alloc] init];
    self.stringLabels = [[NSMutableArray alloc] init];
    
    for (NSUInteger i= 0; i< strings.count-1; ++i) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
        view.layer.borderWidth = self.layer.borderWidth;
        view.layer.borderColor = self.layer.borderColor;
        [self.seperatorLines addObject:view];
        [self addSubview:view];
    }
    
    for (NSUInteger i= 0; i< strings.count; ++i) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.stringLabels addObject:label];
        [self addSubview:label];
        
        label.adjustsFontSizeToFitWidth = YES;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [strings objectAtIndex:i];
        label.textColor = [UIColor colorWithCGColor:self.layer.borderColor];
        label.font = [UIFont systemFontOfSize:15];
    }

    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.seperatorLines.count == 0){
        return;
    }
    CGFloat width = self.bounds.size.width;
    CGFloat height = ceil(self.bounds.size.height/self.stringLabels.count);
    CGFloat y = height;
    
    for (UIView* line in self.seperatorLines) {
        line.frame = CGRectMake(0, y, width, 1);
        y += height;
    }

    y = 0;
    for (UIView* label in self.stringLabels) {
        label.frame = CGRectMake(0, y, width, height);
        y += height;
    }
}


@end
