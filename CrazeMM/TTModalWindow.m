//
//  TTModalWindow.m
//  Pods
//
//  Created by titengjiang on 16/3/11.
//
//

#import "TTModalWindow.h"

@implementation TTModalWindow

-(instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if(self){
        [self commonInit];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInit];
    }
    return self;
    
    
}

-(void)commonInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    
}


- (void)setRootViewController:(UIViewController *)rootViewController {
    [super setRootViewController:rootViewController];
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

#pragma mark -
#pragma mark Notification Handle

- (void)updateOrientation:(NSNotification*)noti
{
    

}


@end
