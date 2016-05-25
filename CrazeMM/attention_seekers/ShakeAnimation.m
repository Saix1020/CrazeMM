//
//  ShakeAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "ShakeAnimation.h"

@implementation ShakeAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.1,@0.2,@0.3,@0.4,@0.5,@0.6,@0.7,@0.8,@0.9,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D originTransform = _targetView.layer.transform;
    
    NSValue * zeroTranslateValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(originTransform, 0, 0, 0)];
    NSValue * leftTranslateValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(originTransform, -10, 0, 0)];
    NSValue * rightTranslateValue =[NSValue valueWithCATransform3D: CATransform3DTranslate(originTransform, 10, 0, 0)];
    
    transformAnimation.values = @[zeroTranslateValue,
                                  leftTranslateValue,
                                  rightTranslateValue,
                                  leftTranslateValue,
                                  rightTranslateValue,
                                  leftTranslateValue,
                                  rightTranslateValue,
                                  leftTranslateValue,
                                  rightTranslateValue,
                                  zeroTranslateValue
                                  ];
    
    
    _animationGroup.animations = @[transformAnimation];

    
}

@end
