//
//  ProductLastCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductLastCell.h"

@implementation ProductLastCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageView1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView1.layer.borderWidth = .5f;
    self.imageView2.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView2.layer.borderWidth = .5f;
    self.imageView3.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.imageView3.layer.borderWidth = .5f;
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight
{
    return 145.f;
}


@end
