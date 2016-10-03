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


@interface ArrowLabel : UIView
{
    CGPoint origin;//尖角指向的点
    CGPoint point;//构建 label的坐标点
    CGSize size;//<span style="font-family: Arial, Helvetica, sans-serif;">构建 label的大小</span>
    UIFont *font;//label 的字体
    UILabel *label;//用于显示文字的label
    UIBezierPath *path;//用于绘制图的path
}
@property (nonatomic, strong) NSString *title;
-(void)set_path;
-(id) init:(CGPoint) p str:(NSString*) str;
-(void)set_point:(CGPoint)p;
-(void)set_title:(NSString*) str;
-(void)reloadData;

-(void)set_size:(CGSize)s;

@end
