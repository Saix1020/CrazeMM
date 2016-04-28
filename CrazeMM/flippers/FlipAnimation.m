//
//  FlipAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FlipAnimation.h"

@implementation FlipAnimation

-(void)prepare
{
    CATransform3D  originTransform = _targetView.layer.transform;
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.4,@0.5,@0.8,@1];
    NSArray<CAMediaTimingFunction *> * timeFunctions  = @[
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],                                                          [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                                          ];


    NSArray * values = @[
                         [NSValue valueWithCATransform3D: CATransform3DConcat(CATransform3DPerspective(originTransform,400), CATransform3DRotate(originTransform, deg(-360), 0, 1, 0))
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(-190), 0, 1, 0), 0, 0, 150)
                          ],
                         [NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DRotate(CATransform3DPerspective(originTransform,400), deg(-170), 0, 1, 0), 0, 0, 150)
                          ],
                         [NSValue valueWithCATransform3D:
                          CATransform3DScale(CATransform3DPerspective(originTransform,400), 0.9, 0.9, 0.9)
                          ],
                         [NSValue valueWithCATransform3D:(CATransform3DPerspective(originTransform,400))
                          ]
                         ];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.timingFunctions = timeFunctions;
    transformAnimation.values = values;
    
    
    
    _animationGroup.animations = @[transformAnimation];
    _animationGroup.duration = _params.duration;
    
    
}

@end
