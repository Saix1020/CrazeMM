//
//  SlideOutLeftAnimation.m
//  Pods
//
//  Created by titengjiang on 16/2/29.
//
//

#import "SlideOutLeftAnimation.h"

@implementation SlideOutLeftAnimation


-(void)prepare
{
    
    NSArray<NSNumber *> *keyTimes =  @[@0,@1];
    
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    
    CATransform3D endTransform = CATransform3DTranslate(_targetView.layer.transform, -ViewWidth(_targetView), 0, 0);
    
    transformAnimation.values = @[[NSValue valueWithCATransform3D:_targetView.layer.transform],
                                  [NSValue valueWithCATransform3D:endTransform]
                                  ];
    
    _animationGroup.animations = @[transformAnimation];
    _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
}


@end
