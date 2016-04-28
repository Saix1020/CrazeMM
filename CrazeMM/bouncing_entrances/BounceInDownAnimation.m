//
//  BounceInDownAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "BounceInDownAnimation.h"

@implementation BounceInDownAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.6,@0.75,@0.9,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    transformAnimation.timingFunction  =[CAMediaTimingFunction functionWithControlPoints:0.215 : 0.610:0.355 :1.000];
    
    CATransform3D originTransform = _targetView.layer.transform;
    NSMutableArray * values = [[NSMutableArray alloc] init];
    
    [@[@-3000,@25,@-10,@5,@0]enumerateObjectsUsingBlock:
     ^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         [values addObject:[NSValue valueWithCATransform3D:CATransform3DTranslate(originTransform, 0, [obj floatValue], 0)]];
         
     }];
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.timingFunction  =[CAMediaTimingFunction functionWithControlPoints:0.215 : 0.610:0.355 :1.000];
    opacityAnimation.keyTimes = @[@0,@0.6];
    opacityAnimation.values = @[@0,@1];
    
    //
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
}

@end
