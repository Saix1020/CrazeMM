//
//  AvataCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AvataCell.h"
#import "CDFInitialsAvatar.h"

@implementation AvataCell

-(void)awakeFromNib
{
    [self.avataImageView roundImageWithBordWidth:3.0 andBordColor:[UIColor whiteColor]];
}


@end
