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
@property (nonatomic) ButtonStyle buttonStyle;
@property (nonatomic, strong) NSNumber* height;

+(CGFloat)cellHight;

-(void)setTitles:(NSArray *)titles andIcons:(NSArray*)icons;
-(void)setTitles:(NSArray *)titles andIcons:(NSArray*)icons andStyle:(ButtonStyle)style;;

@end
