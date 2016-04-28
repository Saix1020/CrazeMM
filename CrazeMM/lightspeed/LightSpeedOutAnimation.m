//
//  LightSpeedOutAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/20.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "LightSpeedOutAnimation.h"

@implementation LightSpeedOutAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    CATransform3D  originTransform = _targetView.layer.transform;
    NSArray * values = @[
                         [NSValue valueWithCATransform3D:originTransform],
                         [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DSkewX(originTransform, -30), _targetView.frame.size.width, 0, 0)
                          ]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.values = values;
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@0];
    
    
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
}


@end
