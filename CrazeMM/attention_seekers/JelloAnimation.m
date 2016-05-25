//
//  JelloAnimation.m
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/18.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import "JelloAnimation.h"
#import "CATransform3DExtend.h"

@implementation JelloAnimation

//-(void)prepare
//{
//    NSArray<NSNumber *> *keyTimes =  @[@0,@0.111,@0.222,@0.333,@0.444,@0.555,@0.666,@0.777,@0.888,@1];
//    CAKeyframeAnimation * transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    transformAnimation.keyTimes = keyTimes;
//    
//    NSMutableArray * values = [[NSMutableArray alloc] init];
//    CATransform3D originTransform = _targetView.layer.transform;
//
//    [@[@0,@0,@-12.5,@6.25,@-3.125,@1.5625,@-0.78125,@0.390625,@-0.1953125,@0]enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(idx == 0 || idx == 1|| idx == 9){
//            [values addObject:[NSValue valueWithCATransform3D:originTransform]];
//            
//        }
//        [values addObject:[NSValue valueWithCATransform3D:CATransform3DSkew(originTransform, [obj floatValue],[obj floatValue])]];
//
//        
//    }];
//    
//    transformAnimation.values = values;
//    
//    _animationGroup.animations = @[transformAnimation];
//
//}

@end
