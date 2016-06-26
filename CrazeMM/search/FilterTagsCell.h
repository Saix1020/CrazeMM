//
//  FilterTagsCell.h
//  CrazeMM
//
//  Created by saix on 16/6/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTagLabel.h"

@interface FilterTagsCell : UITableViewCell

@property (nonatomic, copy) NSArray* filterTags;

@property (nonatomic, weak) id<FilterTagLabelDelegate> delegate;

@property (nonatomic, readonly) NSArray* selectedTags;

-(void)reset;

@end


