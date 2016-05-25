//
//  LightSpeedInAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/20.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "LightSpeedInAnimation.h"

@implementation LightSpeedInAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.6,@0.8,@1];
    CATransform3D  originTransform = _targetView.layer.transform;
    NSArray * values = @[
                         [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DSkewX(originTransform, -30), _targetView.frame.size.width, 0, 0)                           ],
                         [NSValue valueWithCATransform3D:CATransform3DSkewX(originTransform, 20)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DSkewX(originTransform, -5)
                          ],
                         [NSValue valueWithCATransform3D:originTransform]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.values = values;
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@0,@1,@1,@1];
    
    
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.delegate= self;
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
}

@end
