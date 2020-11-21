//
//  ProductWithNumberView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductWithNumberView.h"

@implementation ProductWithNumberView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
//    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
//    self.layer.borderWidth = 1.f;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.width = 68;
    self.height = 64;
}

@end
