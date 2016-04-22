//
//  SegmentedCell.h
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"


@interface SegmentedCell : UITableViewCell

@property (nonatomic, strong) CustomSegment* segment;
@property (nonatomic, copy) NSArray* titles;

+(CGFloat)cellHight;

@end
