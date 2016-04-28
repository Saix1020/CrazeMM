//
//  BounceInAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "BounceInAnimation.h"

@implementation BounceInAnimation

-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.2,@0.4,@0.6,@0.8,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.timingFunction  =[CAMediaTimingFunction functionWithControlPoints:0.215 : 0.610:0.355 :1.000];
    
    CATransform3D originTransform = _targetView.layer.transform;
    NSMutableArray * values = [[NSMutableArray alloc] init];

    [@[@.3,@1.1,@.9,@1.03,@.97,@1]enumerateObjectsUsingBlock:
        ^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DScale(originTransform, [obj floatValue], [obj floatValue], [obj floatValue])]];
        
    }];
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.timingFunction  =[CAMediaTimingFunction functionWithControlPoints:0.215 : 0.610:0.355 :1.000];
    opacityAnimation.keyTimes = @[@0,@0.6,@1];
    opacityAnimation.values = @[@0,@1,@1];
    
    //
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
}

@end
