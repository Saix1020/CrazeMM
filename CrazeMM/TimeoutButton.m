//
//  TimeoutButton.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "TimeoutButton.h"

@interface TimeoutButton ()

@property (nonatomic, strong)id orignalTarget;
@property (nonatomic) SEL orignalAction;

@end

@implementation TimeoutButton

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (controlEvents == UIControlEventTouchUpInside) {
        self.orignalTarget = target;
        self.orignalAction = action;
        
        [super addTarget:self action:@selector(clicked:) forControlEvents:controlEvents];

    }
    else {
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
}

- (void)clicked:(id)sender
{
    @weakify(self);
    __block int timeout = self.timeoutSeconds;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        @strongify(self);
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:self.enableTitle forState:UIControlStateNormal];
                [self setTitleColor:[UIColor buttonEnableTextColor] forState:UIControlStateNormal];
                self.backgroundColor = [UIColor buttonEnableBackgroundColor];
                self.userInteractionEnabled = YES;
                
            });
            
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime, self.disableTitle] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor buttonDisableTextColor] forState:UIControlStateNormal];
                self.backgroundColor = [UIColor buttonDisableBackgroundColor];
                
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
        
    });
    
    dispatch_resume(_timer);
    [self.orignalTarget performSelector:self.orignalAction withObject:self afterDelay:0.5];
//    [self.orignalTarget performSelector:self.orignalAction withObject:self];
    

}


@end
