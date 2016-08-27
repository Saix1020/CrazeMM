//
//  BrandHeadView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BrandHeadView.h"

@implementation BrandHeadView

-(void)awakeFromNib
{
    self.expandButton.tintColor = [UIColor grayColor];
    [self.expandButton exchangeImageAndText];
}


@end
