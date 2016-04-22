//
//  SegmentedCell.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SegmentedCell.h"



@implementation SegmentedCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//}

-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self.segment setItems:_titles];
}

-(CustomSegment*)segment
{
    if(!_segment){
        _segment = [[CustomSegment alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [SegmentedCell cellHight])];
        _segment.selectedColor = [UIColor redColor];
        [self addSubview:_segment];

    }
    return _segment;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.segment.frame = self.bounds;
//    [self.segment layoutIfNeeded];
}

+(CGFloat)cellHight
{
    return 64.f;
}

@end
