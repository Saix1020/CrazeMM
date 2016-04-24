//
//  CustomSegment.h
//  suning6iphone
//
//  Created by  liukun on 13-7-23.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonStyle){
    kButtonStyleNomal = 0,
    kButtonStyleV,
    kButtonStyleB
};



@class CustomSegment;
@protocol CustomSegmentDelegate <NSObject>

@optional
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;

@end

@interface CustomSegment : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger prevIndex;
@property (nonatomic, weak) id<CustomSegmentDelegate> delegate;
@property (nonatomic, strong) NSArray *items; // item of NSString

@property (nonatomic) CGFloat lineHeight;
@property (nonatomic, strong) UIColor* selectedColor;

@property (nonatomic, strong) NSArray *buttons;
- (void)setItems:(NSArray *)items andIcons:(NSArray*)icons andStyle:(ButtonStyle)style;


@end
