//
//  RollInAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/20.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "RollInAnimation.h"

@implementation RollInAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    CATransform3D  originTransform = _targetView.layer.transform;
    NSArray * values = @[
                         [NSValue valueWithCATransform3D: CATransform3DRotate(CATransform3DTranslate(originTransform, -_targetView.frame.size.width, 0, 0), deg(-120), 0, 0, 1)
                          ],
                         [NSValue valueWithCATransform3D:originTransform]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.values = values;
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@0,@1];
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

@end
