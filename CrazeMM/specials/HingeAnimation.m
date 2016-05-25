//
//  HingeAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/20.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "HingeAnimation.h"

@implementation HingeAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@.2,@.4,@.6,@.8,@1];
    
    NSArray * timeFunctions = @[
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],

                                ];
    
    CATransform3D  originTransform = _targetView.layer.transform;
    
    CGRect oldFrame = _targetView.frame;
    _targetView.layer.anchorPoint = CGPointMake(0, 0);
    _targetView.frame = oldFrame;
    
    NSArray * values = @[
                         [NSValue valueWithCATransform3D:originTransform],
                         [NSValue valueWithCATransform3D: CATransform3DRotate(originTransform, deg(80), 0, 0, 1)
                          ],
                         [NSValue valueWithCATransform3D: CATransform3DRotate(originTransform, deg(60), 0, 0, 1)
                          ],
                         [NSValue valueWithCATransform3D: CATransform3DRotate(originTransform, deg(80), 0, 0, 1)
                          ],
                         [NSValue valueWithCATransform3D: CATransform3DRotate(originTransform, deg(60), 0, 0, 1)
                          ],
                         [NSValue valueWithCATransform3D: CATransform3DTranslate(originTransform, 0, 700, 0)]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.values = values;
    transformAnimation.timingFunctions = timeFunctions;
    
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@1,@1,@1,@1,@0];
    
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
    _animationGroup.duration = _params.duration;
}

@end
