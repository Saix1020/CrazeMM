//
//  ZoomOutDownAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ZoomOutDownAnimation.h"

@implementation ZoomOutDownAnimation


-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.4,@1];
    NSArray<CAMediaTimingFunction *> * timeFunctions  = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault],
                                                          [CAMediaTimingFunction functionWithControlPoints:0.550 : 0.055:0.675 :0.190],[CAMediaTimingFunction functionWithControlPoints:0.175 :0.885 :0.320 :1]];
    
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.timingFunctions  =timeFunctions;
    opacityAnimation.keyTimes = keyTimes;
    opacityAnimation.values = @[@1,@1,@0];
    
    ///transform scale translate animation
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.timingFunctions = timeFunctions;
    transformAnimation.keyTimes =keyTimes;
    
    CATransform3D middleTransform = CATransform3DScale(_targetView.layer.transform, .475, .475, .475);
    
    middleTransform = CATransform3DTranslate(middleTransform, 0,-60 , 0);
    CATransform3D endTransform = CATransform3DScale (_targetView.layer.transform, .1, .1, .1);
    endTransform = CATransform3DTranslate(endTransform, 0, 4000, 0);

    NSArray * scales = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:_targetView.layer.transform],
                        [NSValue valueWithCATransform3D:middleTransform],
                        [NSValue valueWithCATransform3D:endTransform], nil];

    transformAnimation.values= scales;

    

    //animation group
    _animationGroup.animations = @[opacityAnimation,transformAnimation];

    
    
    
    
    
}

@end
