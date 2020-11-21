//
//  ArrowView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ArrowView.h"



@implementation ArrowView

-(void)awakeFromNib
{
    [self commInit];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commInit];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self commInit];
    }
    
    return self;
}

-(void)commInit
{
    self.arrawView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rect_left"]];
    self.textLabel = [[UILabel alloc] init];
    
    self.textLabel.numberOfLines = 1;
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.textColor = [UIColor greenTextColor];
    self.textLabel.text = @"供货";
    [self addSubview:self.arrawView];
    [self addSubview:self.textLabel];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.arrawView.frame = self.bounds;
    self.textLabel.frame = self.bounds;
    self.textLabel.x += (self.width/10);
    self.textLabel.width -= (self.width/10);
    //self.textLabel.height = self.height-2.f;
}

@end
