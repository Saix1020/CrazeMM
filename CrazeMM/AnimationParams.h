//
//  AnimationParams.h
//  TTAnimationExample
//
//  Created by titengjiang on 16/1/17.
//  Copyright © 2016年 sloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationCommon.h"

@interface AnimationParams : NSObject

@property(nonatomic,assign)CFTimeInterval  duration;
@property(nonatomic,assign)AnimationType  animationType;
@property(nonatomic,assign)CGFloat repeatCount;
@property(nonatomic,assign)BOOL removedOnCompletion;
@property(copy) NSString *fillMode;

@end
