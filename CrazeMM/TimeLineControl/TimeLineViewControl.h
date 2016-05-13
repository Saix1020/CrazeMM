//
//  TimiLineViewControl.h
//  Klubok
//
//  Created by Roma on 8/25/14.
//  Copyright (c) 2014 908 Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineViewControl : UIView {
    CGFloat viewheight;
    CGFloat timeLabelsHeight;
    CGFloat descLabelsHeight;
}

@property(nonatomic, assign) CGFloat viewheight;
@property(nonatomic, assign) CGFloat timeLabelsHeight;
@property(nonatomic, assign) CGFloat descLabelsHeight;


- (id)initWithTimeArray:(NSArray *)time andTimeDescriptionArray:(NSArray *)timeDescriptions andCurrentStatus:(int)status andFrame:(CGRect)frame;

@end
