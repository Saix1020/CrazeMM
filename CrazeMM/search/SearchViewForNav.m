//
//  searchViewForNav.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchViewForNav.h"

@implementation SearchViewForNav

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.searchBar.frame = self.bounds;
}

@end
