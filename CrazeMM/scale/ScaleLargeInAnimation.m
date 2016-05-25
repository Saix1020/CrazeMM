//
//  ScaleLargeInAnimation.m
//  Pods
//
//  Created by titengjiang on 16/3/12.
//
//

#import "ScaleLargeInAnimation.h"

@implementation ScaleLargeInAnimation


-(void)prepare
{
    
    CALayer * layer = _targetView.layer;
    
    CGRect oldBounds = layer.bounds;
    CGRect new_bounds = CGRectMake(0, 0, oldBounds.size.width, 0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    CGRect oldFrame = _targetView.frame;
    _targetView.layer.anchorPoint = CGPointMake(1, 0);
    _targetView.frame = oldFrame;
    
    animation.fromValue = [NSValue valueWithCGRect:new_bounds];
    animation.toValue = [NSValue valueWithCGRect:oldBounds];
    animation.duration = 10.0f;
    [_targetView.layer addAnimation:animation forKey:@""];
    
}

@end
