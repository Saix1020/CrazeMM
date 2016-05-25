//
//  TadaAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "TadaAnimation.h"

@implementation TadaAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.1,@0.2,@0.3,@0.4,@0.5,@0.6,@0.7,@0.8,@0.9,@1];    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;
    NSValue * originValue = [NSValue valueWithCATransform3D:originTransform];
    
    CATransform3D firstTransform = CATransform3DScale(originTransform, 0.9, 0.9, 0.9);
    firstTransform = CATransform3DRotate(firstTransform, deg(-3), 0, 0, 1);
    NSValue * firstValue = [NSValue valueWithCATransform3D:firstTransform];
    
    CATransform3D secondTransform = CATransform3DScale(originTransform, 1.1, 1.1, 1.1);
    secondTransform = CATransform3DRotate(secondTransform, deg(3), 0, 0, 1);
    NSValue * secondValue = [NSValue valueWithCATransform3D:secondTransform];
    
    CATransform3D thirdTransform = CATransform3DScale(originTransform, 1.1, 1.1, 1.1);
    thirdTransform = CATransform3DRotate(thirdTransform, deg(-3), 0, 0, 1);
    NSValue * thirdValue = [NSValue valueWithCATransform3D:thirdTransform];
 
    transformAnimation.values = @[originValue,firstValue,firstValue,secondValue,thirdValue,secondValue,thirdValue,secondValue,thirdValue,secondValue,originValue];
    
    _animationGroup.animations = @[transformAnimation];

    
    
}
@end
