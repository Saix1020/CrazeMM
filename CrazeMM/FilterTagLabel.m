//
//  FilterButton.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FilterTagLabel.h"

@interface FilterTagLabel()

//@property (nonatomic, readwrite) BOOL isSelected;


@end

@implementation FilterTagLabel

-(instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initX];
    }
    return self;
}

-(void)initX
{
    self.isSelected = NO;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSelect)]];
    
    self.font = [UIFont systemFontOfSize:13.f];
    self.clipsToBounds = YES;
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor UIColorFromRGB:0xefefef];
    self.layer.borderColor = [UIColor UIColorFromRGB:0xefefef].CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 4.f;
    
}

-(void)setFilterTag:(NSString *)filterTag
{
    _filterTag = filterTag;
    self.text = filterTag;
}



-(void)toggleSelect
{
    self.isSelected = !self.isSelected;
    
    if (self.isSelected) {
        self.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;

    }
    else{
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor UIColorFromRGB:0xefefef];
        self.layer.borderColor = [UIColor UIColorFromRGB:0xefefef].CGColor;
    }
    
    if ([self.delegate respondsToSelector:@selector(didTaped:)]) {
        [self.delegate didTaped:self];
    }
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (self.isSelected) {
        self.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    else{
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor UIColorFromRGB:0xefefef];
        self.layer.borderColor = [UIColor UIColorFromRGB:0xefefef].CGColor;
    }
}


@end
