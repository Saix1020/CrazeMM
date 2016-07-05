//
//  UIBezierPath+Arrow.h
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
 `UIBezierPath+Arrow` constructs a bezier path for a typical block arrow with filled head.
 */
@interface UIBezierPath (Arrow)

/**
 Constructs a bezier path for an arrow. The tail and tip points define the centre of the tail and tip of the arrow, respectively, and the arrow's path is created in between for the specific constrains.
 
 @param tailPoint The point that indicates the centre of the arrow's tail
 @param tipPoint The point that indicates the tip of the arrow's head
 @param tailWidth Specifies the size of the tail width
 @param headWidth Specifies the size of the head width
 @param headLength Specifies the size of the head length
 
 @return The bezier path of the arrow
 */
+ (UIBezierPath *)bezierPathWithArrowFromPoint:(CGPoint)tailPoint
                                       toPoint:(CGPoint)tipPoint
                                     tailWidth:(CGFloat)tailWidth
                                     headWidth:(CGFloat)headWidth
                                    headLength:(CGFloat)headLength;
@end
