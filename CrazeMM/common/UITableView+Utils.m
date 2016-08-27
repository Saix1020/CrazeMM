//
//  UITableView+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UITableView+Utils.h"

@implementation UITableView (Utils)

-(void)registerNib:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

@end
