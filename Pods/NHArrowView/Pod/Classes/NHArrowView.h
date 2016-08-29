//
//  ArrowView.h
//  CGM_Collector
//
//  Created by Nathaniel Hamming on 2015-01-14.
//  Copyright (c) 2015 eHealth. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

/**
 Function to convert degrees to radians
 
 @param degree The degree to convert to radian
 
 @return The radian value for the specific degree
 */
#define DEGREES_TO_RADIANS(degree) ((degree * M_PI) / 180.0 )

/**
 Function to convert radians to degrees
 
 @param radian The radian to convert to radian
 
 @return The degree value for the specific radian
 */
#define RADIANS_TO_DEGREES(radian) ((radian * 180.0) /  M_PI )

/**
 `NHArrowView` is a simple directional arrow with animated rotation. Rotation is achieved with the publically availbale methods and by passing in either the desired degrees or radians with optional animation details. Note that the arrow is originally drawn horizontally in the view's frame with a small margin on the x-coordinates.
 
 Some style aspects of the arrow are customizable, but the arrow itself is drawn as a typical block arrow with filled head. If one would like to adjust the bezier path of the arrow, please refer to UIBezierPath+Arrow category. As well, one could override the draw method of NHArrowView to achieve additional customization.
 */
@interface NHArrowView : UIView

/**
 The stroke color used when drawing the arrow. Can be dynamically updated. Default color is red
 */
@property(nonatomic,strong) UIColor *strokeColor;

/**
 The fill color used when drawing the arrow. Can be dynamically updated. Default color is red
 */
@property(nonatomic,strong) UIColor *fillColor;

/**
 The stroke width used when drawing the arrow. Can be dynamically updated. Default value is 2
 */
@property(nonatomic,assign) CGFloat strokeWidth;

/**
 The head width of the arrow. Can be dynamically updated. Default value is 14
 */
@property(nonatomic,assign) CGFloat headWidth;

/**
 The head length of the arrow. Can be dynamically updated. Default value is 14
 */
@property(nonatomic,assign) CGFloat headLength;

/**
 The tail width of the arrow. Can be dynamically updated. Default value is 7
 */
@property(nonatomic,assign) CGFloat tailWidth;


///---------------------
/// @name Rotation Methods
///---------------------

/**
 Rotates the arrow to provided degree with default animation
 
 @param degree The degree to which the arrow should point
 */
- (void)animatedRotateToDegree:(CGFloat)degree;

/**
 Rotates the arrow to provided radians with default animation
 
 @param rad The radian to which the arrow should point
 */
- (void)animatedRotateToRadian:(CGFloat)rad;

/**
 Rotates the arrow to provided radians with animation as specified
 
 @param rad The radian to which the arrow should point
 @param animated Indicates where the rotation should be animated
 @param duration Indicated the duration of the animation
 */
- (void)rotateToRadian:(CGFloat)rad animated:(BOOL)animated duration:(CGFloat)duration;


/**
 Resets the arrow to its default size and shape. Does not reset the stroke and fill colour of the arrow
 */
- (void)reset;

@end
