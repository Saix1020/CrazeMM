//
//  FlipInYAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FlipInYAnimation.h"

@implementation FlipInYAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.4,@0.6,@0.8,@1];
    NSArray<CAMediaTimingFunction *> * timeFunctions  = @[
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
                                                          ];
    CATransform3D  originTransform = _targetView.layer.transform;
    
    
    NSArray * values = @[
                         [NSValue valueWithCATransform3D: CATransform3DConcat(CATransform3DPerspective(originTransform,400), CATransform3DRotate(originTransform, deg(90), 0, 1, 0))
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(-20), 0, 1, 0)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(10), 0, 1, 0)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(-5), 0, 1, 0)
                          ],
                         [NSValue valueWithCATransform3D:(CATransform3DPerspective(originTransform,400))
                          ]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.timingFunctions = timeFunctions;
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =@[@0,@0.6,@1];
    opacityAnimation.values = @[@0,@1,@1];
    
    
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
    _animationGroup.duration = _params.duration;
    
}
@end
