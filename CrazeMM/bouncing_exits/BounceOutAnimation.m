//
//  BounceOutAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "BounceOutAnimation.h"

@implementation BounceOutAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.2,@0.5,@0.55,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;

    CATransform3D originTransform = _targetView.layer.transform;
    NSMutableArray * values = [[NSMutableArray alloc] init];
    
    [@[@1,@0.9,@1.1,@1.1,@.3]enumerateObjectsUsingBlock:
     ^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         [values addObject:[NSValue valueWithCATransform3D:CATransform3DScale(originTransform, [obj floatValue], [obj floatValue], [obj floatValue])]];
         
     }];
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@.9,@1.1,@1.1,@0];
    
    //
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}

@end
