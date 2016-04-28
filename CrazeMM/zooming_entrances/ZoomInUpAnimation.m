//
//  ZoomInUpAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/21.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomInUpAnimation.h"

@implementation ZoomInUpAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.6,@1];
    NSArray<CAMediaTimingFunction *> * timeFunctions  = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
                                                          [CAMediaTimingFunction functionWithControlPoints:0.550 : 0.055:0.675 :0.190],[CAMediaTimingFunction functionWithControlPoints:0.175 :0.885 :0.320 :1]];
    
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.timingFunctions  =timeFunctions;
    opacityAnimation.keyTimes = keyTimes;
    opacityAnimation.values = @[@0,@1,@1];
    
    ///transform scale translate animation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.timingFunctions = timeFunctions;
    transformAnimation.keyTimes =keyTimes;
    
    CATransform3D startTransform = CATransform3DScale(_targetView.layer.transform, .1, .1, .1);
    startTransform = CATransform3DConcat(startTransform, CATransform3DMakeTranslation(0, 1000, 0));
    CATransform3D middleTransform = CATransform3DScale(_targetView.layer.transform, .475, .475, .475);
    middleTransform = CATransform3DConcat(middleTransform, CATransform3DMakeTranslation(0, -60, 0));
    
    
    
    NSArray * transforms = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:startTransform],
                            [NSValue valueWithCATransform3D:middleTransform],
                            [NSValue valueWithCATransform3D:_targetView.layer.transform], nil];
    
    transformAnimation.values= transforms;
    
    
    
    //animation group
    _animationGroup.animations = @[opacityAnimation,transformAnimation];
}

@end
