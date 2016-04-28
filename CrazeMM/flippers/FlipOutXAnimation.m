//
//  FlipOutXAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FlipOutXAnimation.h"

@implementation FlipOutXAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.3,@1];
    CATransform3D  originTransform = _targetView.layer.transform;
    
    
    NSArray * values = @[
                         [NSValue valueWithCATransform3D: CATransform3DPerspective(originTransform,400)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(-20), 1, 0, 0)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(90), 1, 0, 0)
                          ]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.values = values;


    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =@[@0,@0.3,@1];
    opacityAnimation.values = @[@1,@1,@0];
    
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

@end
