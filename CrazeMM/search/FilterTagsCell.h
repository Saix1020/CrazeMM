//
//  FilterTagsCell.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTagLabel.h"

#define kFilterTagsCellDeltaWidth 50.f

@interface FilterTagsCell : UITableViewCell

@property (nonatomic, copy) NSArray* filterTags;

@property (nonatomic, weak) id<FilterTagLabelDelegate> delegate;

@property (nonatomic, readonly) NSArray* selectedTags;
@property (nonatomic) NSInteger maxWidth;

-(void)reset;

@end


