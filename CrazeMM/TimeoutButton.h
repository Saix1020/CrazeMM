//
//  TimeoutButton.h
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeoutButtonDelegate <NSObject>

-(void)timeLapse:(id)sender;

@end

@interface TimeoutButton : UIButton

@property (nonatomic) int timeoutSeconds;
@property (nonatomic, copy) NSString* enableTitle;
@property (nonatomic, copy) NSString* disableTitle;
@property (nonatomic, weak) id<TimeoutButtonDelegate> delegate;
@property (nonatomic) BOOL startTimer;
@end
