//
//  UINib+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UINib+Utils.h"

@implementation UINib (Utils)

+(UIView*)viewFromNib:(NSString*)nibName
{
    return [[[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil] firstObject];
}

+(UIView*)viewFromNibByClass:(id)class
{
    return [UINib viewFromNib:NSStringFromClass(class)];
}



@end
