//
//  WobbleAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "WobbleAnimation.h"

@implementation WobbleAnimation

-(void)prepare
{
    NSArray<NSNumber *> *keyTimes =  @[@0,@0.15,@0.3,@0.45,@0.6,@0.75,@1];
    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnimation.keyTimes = keyTimes;
    NSMutableArray * values = [[NSMutableArray alloc] init];
    CATransform3D originTransform = _targetView.layer.transform;
    
    CGFloat width  = _targetView.frame.size.width;
    [@[
      @[],
      @[@-0.25,@-5],
      @[@0.2,@3],
      @[@-0.15,@-3],
      @[@0.1,@2],
      @[@-0.05,@-1],
      @[]
      ]enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if(idx == 0 || idx == 6){
              [values addObject:[NSValue valueWithCATransform3D:originTransform]];
              return ;
          }
          NSNumber * translateXNum =[obj objectAtIndex:0];
          float translateX = [translateXNum floatValue] *  width;
          NSNumber * rotateDegNum =[obj objectAtIndex:1];
          float rotateDeg = deg([rotateDegNum floatValue]);
          
          CATransform3D transform = CATransform3DTranslate(originTransform, translateX, 0, 0);
          transform = CATransform3DRotate(transform, rotateDeg, 0, 0, 1);
          [values addObject:[NSValue valueWithCATransform3D:transform]];
          
      }];
    
    transformAnimation.values = values;
    
    _animationGroup.animations = @[transformAnimation];

}

@end
