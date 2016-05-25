//
//  NoLoginHeadCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NoLoginHeadCell.h"

@implementation NoLoginHeadCell

-(void)awakeFromNib
{
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_alpha"]];
    imageView.contentMode = UIViewContentModeCenter ;
    self.clipsToBounds = YES;
    
    self.backgroundView = imageView;
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
