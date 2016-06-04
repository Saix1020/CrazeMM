//
//  UIBezierPath+Arrow.m
//  CGM_Collector
//
//  Created by Nathaniel Hamming on 2015-01-14.
//  Copyright (c) 2015 eHealth. All rights reserved.
//

#import "UIBezierPath+Arrow.h"

#define kArrowPointCount 7

@implementation UIBezierPath (Arrow)

+ (UIBezierPath *)bezierPathWithArrowFromPoint:(CGPoint)tailPoint
                                       toPoint:(CGPoint)tipPoint
                                     tailWidth:(CGFloat)tailWidth
                                     headWidth:(CGFloat)headWidth
                                    headLength:(CGFloat)headLength {
    CGFloat length = hypotf(tipPoint.x - tailPoint.x, tipPoint.y - tailPoint.y);
    
    CGPoint points[kArrowPointCount];
    [self getAxisAlignedArrowPoints:points
                          forLength:length
                          tailWidth:tailWidth
                          headWidth:headWidth
                         headLength:headLength];
    
    CGAffineTransform transform = [self transformForTailPoint:tailPoint
                                                     tipPoint:tipPoint
                                                       length:length];
    
    CGMutablePathRef cgPath = CGPathCreateMutable();
    CGPathAddLines(cgPath, &transform, points, sizeof points / sizeof *points);
    CGPathCloseSubpath(cgPath);
    
    UIBezierPath *uiPath = [UIBezierPath bezierPathWithCGPath:cgPath];
    CGPathRelease(cgPath);
    return uiPath;
}

+ (void)getAxisAlignedArrowPoints:(CGPoint[kArrowPointCount])points
                        forLength:(CGFloat)length
                        tailWidth:(CGFloat)tailWidth
                        headWidth:(CGFloat)headWidth
                       headLength:(CGFloat)headLength {
    CGFloat tailLength = length - headLength;
    points[0] = CGPointMake(0, tailWidth / 2);
    points[1] = CGPointMake(tailLength, tailWidth / 2);
    points[2] = CGPointMake(tailLength, headWidth / 2);
    points[3] = CGPointMake(length, 0);
    points[4] = CGPointMake(tailLength, -headWidth / 2);
    points[5] = CGPointMake(tailLength, -tailWidth / 2);
    points[6] = CGPointMake(0, -tailWidth / 2);
}

+ (CGAffineTransform)transformForTailPoint:(CGPoint)tailPoint
                                  tipPoint:(CGPoint)tipPoint
                                    length:(CGFloat)length {
    CGFloat cosine = (tipPoint.x - tailPoint.x) / length;
    CGFloat sine = (tipPoint.y - tailPoint.y) / length;
    return (CGAffineTransform){ cosine, sine, -sine, cosine, tailPoint.x, tailPoint.y };
}

@end
