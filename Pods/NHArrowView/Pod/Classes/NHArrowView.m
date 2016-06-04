//
//  ArrowView.m
//  CGM_Collector
//
//  Created by Nathaniel Hamming on 2015-01-14.
//  Copyright (c) 2015 eHealth. All rights reserved.
//

#import "NHArrowView.h"
#import "UIBezierPath+Arrow.h"

#define kDefaultRotationDuration 0.2
#define kMarginX 10.

@interface NHArrowView()
@property(nonatomic,strong) UIBezierPath *path;
@property(nonatomic,assign) CGPoint startingPoint;
@property(nonatomic,assign) CGPoint endingPoint;
@end

@implementation NHArrowView

#pragma mark - lifecycle

- (instancetype)init
{
    [NSException raise:NSInvalidArgumentException
                format:@"%s: Use %@ instead", __PRETTY_FUNCTION__, NSStringFromSelector(@selector(initWithFrame:))];
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup;
{
    self.strokeColor = [UIColor redColor];
    self.fillColor = [UIColor redColor];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setDefaults];
}

- (void)setDefaults;
{
    [self setMultipleTouchEnabled:NO];
    [self animatedRotateToDegree: 0];
    self.startingPoint = CGPointMake(kMarginX, self.frame.size.height / 2.);
    self.endingPoint = CGPointMake(self.frame.size.width - kMarginX, self.frame.size.height / 2.);
    self.strokeWidth = 2.;
    self.tailWidth = 7.;
    self.headWidth = 14.;
    self.headLength = 14.;
}

- (void)reset;
{
    [self setDefaults];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    
    self.path = [UIBezierPath bezierPathWithArrowFromPoint: self.startingPoint
                                                   toPoint: self.endingPoint
                                                 tailWidth: self.tailWidth
                                                 headWidth: self.headWidth
                                                headLength: self.headLength];
    [self.path setLineWidth:self.strokeWidth];
    [self.path stroke];
    [self.path fill];
}

#pragma mark - Rotation methods

- (void)animatedRotateToDegree:(CGFloat)degree;
{
    CGFloat rad = DEGREES_TO_RADIANS(degree);
    [self animatedRotateToRadian: rad];
}

- (void)animatedRotateToRadian:(CGFloat)rad;
{
    [self rotateToRadian: rad animated: YES duration: kDefaultRotationDuration];
}

- (void)rotateToRadian:(CGFloat)rad animated:(BOOL)animated duration:(CGFloat)duration;
{
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rad);
    if (animated) {
        [UIView animateWithDuration: duration
                         animations:^{
                             self.transform = transform;
                         }
         ];
    } else {
        self.transform = transform;
    }
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setStrokeWidth:(CGFloat)strokeWidth
{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

- (void)setTailWidth:(CGFloat)tailWidth
{
    _tailWidth = tailWidth;
    [self setNeedsDisplay];
}

- (void)setHeadLength:(CGFloat)headLength
{
    _headLength = headLength;
    [self setNeedsDisplay];
}

- (void)setHeadWidth:(CGFloat)headWidth
{
    _headWidth = headWidth;
    [self setNeedsDisplay];
}

@end
