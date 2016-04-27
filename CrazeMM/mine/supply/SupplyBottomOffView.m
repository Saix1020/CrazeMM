//
//  SupplyBottomOffView.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyBottomOffView.h"

@implementation SupplyBottomOffView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)myInit
{
    [self.confirmButton setTitle:@"下架" forState:UIControlStateNormal];
    
    [self.totalPriceLabel setText:@""];

}


@end
