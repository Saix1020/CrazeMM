//
//  FadeInRightAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/19.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "FadeInRightAnimation.h"

@implementation FadeInRightAnimation

-(void)start
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;
    CGFloat targetViewWidth= _targetView.frame.size.width;
    
    NSMutableArray * values = [[NSMutableArray alloc] init];
    [@[[NSNumber numberWithFloat:targetViewWidth],@0]enumerateObjectsUsingBlock:
     ^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
         [values addObject:[NSValue valueWithCATransform3D:CATransform3DTranslate(originTransform, [obj floatValue], 0, 0)]];
         
     }];
    transformAnimation.values = values;
    
    
    //opacity animation
    CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes =keyTimes;
    opacityAnimation.values = @[@0,@1];
    
    
    CAAnimationGroup * animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[transformAnimation,opacityAnimation];
    animationGroup.delegate= self;
    animationGroup.duration = _params.duration;
    animationGroup.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [_targetView.layer addAnimation:animationGroup forKey:@""];
    
}
@end
