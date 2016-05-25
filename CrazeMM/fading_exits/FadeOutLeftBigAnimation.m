//
//  FadeOutLeftBigAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FadeOutLeftBigAnimation.h"

@implementation FadeOutLeftBigAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;
    
    NSMutableArray * values = [[NSMutableArray alloc] init];
    [@[@0,@-2000]enumerateObjectsUsingBlock:
     ^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         [values addObject:[NSValue valueWithCATransform3D:CATransform3DTranslate(originTransform, [obj floatValue], 0, 0)]];
         
     }];
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@1,@0];
    
    
    _animationGroup.animations = @[transformAnimation,opacityAnimation];
    _animationGroup.duration = _params.duration;
    _animationGroup.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
}


@end
