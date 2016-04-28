//
//  TTModalView.m
//  Pods
//
//  Created by titengjiang on 16/3/8.
//
//

#import "TTModalView.h"
#import "TTOverlayView.h"
#import "TTModalWindow.h"
#import "TTModalViewController.h"
#import "AnimationBuilder.h"

@interface TTModalView()
@property(nonatomic,strong)TTModalWindow * window;
@property (nonatomic,readwrite, strong) TTOverlayView *overlayView;
@property(nonatomic,strong)AnimationBuilder * animationBuilder;
@end



@implementation TTModalView

-(instancetype)initWithContentView:(UIView *)contentView
                          delegate:(id<TTModalViewDelgate>)delegate
{
    return [self initWithContentView:contentView delegate:delegate presentAnimationStyle:bounceIn dismissAnimationStyle:bounceOut];
    
}


-(instancetype)initWithContentView:(UIView *)contentView
                          delegate:(id<TTModalViewDelgate>)delegate
             presentAnimationStyle:(AnimationType)presentAnimationStyle
             dismissAnimationStyle:(AnimationType)dismissAnimationStyle
{
    self = [super init];
    if(self){
        _contentView = contentView;
        _delegate =delegate;
        _presentAnimationStyle = presentAnimationStyle;
        _dismissAnimationStyle = dismissAnimationStyle;
        [self commonInit];
    }
    
    return self;
    
}

-(void)commonInit
{
    _isCancelAble = YES;
    _modalWindowLevel = UIWindowLevelAlert;
    _modalWindowFrame = [[UIScreen mainScreen] bounds];
    _animationBuilder = [[AnimationBuilder alloc] init];
    [_animationBuilder setRemovedOnCompletion:NO
     ];
    [_animationBuilder setDuration:0.5f];
    
    
}

-(void)dealloc
{
    if(_window !=nil){
        [_window setHidden:YES];
    }
}


#pragma mark public method
-(void)showWithDidAddContentBlock:(TTModalDidAddContentBlock)didAddContentBlock
{
    [self showWithPresentBlock:nil presentAnimationStyle:_presentAnimationStyle didAddContentBlock:didAddContentBlock];
}


-(void)showWithPresentBlock:(void (^)(void))presentBlock
      presentAnimationStyle:(AnimationType) animationStyle
         didAddContentBlock:(TTModalDidAddContentBlock)didAddContentBlock
{
    /**
     *  if the modal did not hide , return direct
     */
    if(self.window != nil){
        return;
    }
    
    [self buildModal];
    
    if(_contentView !=nil){

        [self addSubview:_contentView];
        if(didAddContentBlock !=nil){
            didAddContentBlock(_contentView);
        }
        [_contentView layoutIfNeeded];

    }
    
    [_animationBuilder setAnimationType:animationStyle];
    [_animationBuilder setDelegate:self];
    [_animationBuilder startOn:_contentView completeBlock:^{
        if(presentBlock !=nil){
            presentBlock();
        }
    
    
    }];

    
}


-(void)dismiss
{
    [self dismissWithDismissBlock:nil dismissAnimationStyle:_dismissAnimationStyle];
    
}

-(void)dismissWithDismissBlock:(void(^)(void))dismissBlock
         dismissAnimationStyle:(AnimationType)animationStyle
{
    if(self.window == nil){
        return;
    }
    
    [_animationBuilder setAnimationType:animationStyle];
    self.userInteractionEnabled = NO;
    _overlayView.alpha = 0;
    [_animationBuilder startOn:_contentView completeBlock:^{
        [self cleanUp];
    }];
}


-(void)cleanUp 
{
    [self removeFromSuperview];
    [_contentView.layer removeAllAnimations ];
    [_contentView removeFromSuperview];
    [self.window setHidden:YES];
    self.window = nil;
    self.presentationViewController.view = nil;
    self.presentationViewController = nil;
    _overlayView.alpha = 1;
    self.userInteractionEnabled = YES;
}

#pragma mark builders
-(void)buildModal
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self buildModalWindow];

    UITapGestureRecognizer * tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismiss:)];
    [self addGestureRecognizer:tapToDismiss];
    
    
}


-(void)buildModalWindow
{
    if(self.window == nil){
        self.window = [[TTModalWindow alloc] initWithFrame:_modalWindowFrame];
        self.window.windowLevel = _modalWindowLevel;
        self.window.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if(_presentationViewController == nil){
            _presentationViewController = [[TTModalViewController alloc] init];
            _window.rootViewController = _presentationViewController;
            
            if(_presentationViewController.view !=self){
                [_presentationViewController setView:self];
            }
        }else {
            
            
        }
        [self buildOverlayViewForMode:self.overlayMode inView:_window];
        
        [self.window makeKeyAndVisible];
    }
    
}

-(void)buildOverlayViewForMode:(TTModalOverlayMode)overlayMode
                        inView:(UIView *)view
{

    self.overlayView.frame = view.bounds;
    self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.overlayView.overlayMode  = overlayMode;
    [view insertSubview:self.overlayView atIndex:0];


}
#pragma mark - Gestures
-(void)tapToDismiss:(UITapGestureRecognizer *)recognizer
{

    
    if(_isCancelAble){
        [self dismiss];
    }else {
        
        
    }
    
}


#pragma mark overide property
-(TTOverlayView *)overlayView
{
    if(_overlayView == nil){
        _overlayView = [[TTOverlayView alloc] init];
    }
    
    return _overlayView;
    
}



#pragma mark set
-(void)setAnimationDurartion:(CFTimeInterval )animationDurartion
{
    [_animationBuilder setDuration:animationDurartion];
    _animationDurartion = animationDurartion;
    
}

-(void)setOverlayMode:(TTModalOverlayMode)overlayMode
{
    self.overlayView.overlayMode = overlayMode;
}
-(TTModalOverlayMode)overlayMode
{
    return self.overlayView.overlayMode;
}

#pragma mark
-(void)animationDidStart:(CAAnimation *)anim
{
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    
}

@end
