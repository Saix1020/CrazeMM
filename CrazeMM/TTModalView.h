//
//  TTModalView.h
//  Pods
//
//  Created by titengjiang on 16/3/8.
//
//

#import <UIKit/UIKit.h>
#import "AnimationCommon.h"


typedef  void(^TTModalDidAddContentBlock)(UIView * contentView);

typedef NS_ENUM(NSUInteger,TTModalOverlayMode){
    TTModalOverlayModeNone,
    TTModalOverlayModeGradient,
    TTModalOverlayModeLinear
};

@protocol TTModalViewDelgate;
@class TTOverlayView;

@interface TTModalView : UIView

/**
 *   A Boolean value that indicates whether the modal can be canceled by click the overlayview
 */
@property(nonatomic,assign)BOOL isCancelAble;

/**
*  present  animation style for modal
*/
@property(nonatomic,assign)AnimationType presentAnimationStyle;

/**
 *  dismiss animation style for modal
 */
@property(nonatomic,assign)AnimationType dismissAnimationStyle;

/**
 *  overlaymode style
 */
@property(nonatomic,assign)TTModalOverlayMode overlayMode;

/**
 *  the contentView that will be presented
 */
@property(nonatomic,weak)UIView * contentView;

/**
 *  the viewcontroller that will be presented
 */
@property (nonatomic, strong) UIViewController *presentationViewController;
/**
 *  the overlay view
 */
@property (nonatomic, strong, readonly) TTOverlayView * overlayView;

/**
 *  custom the present and dismiss animation duration
 */
@property(nonatomic,assign) CFTimeInterval  animationDurartion;

/**
 *  the animation delegate
 */
@property(nonatomic,weak)id <TTModalViewDelgate>  delegate;

@property(nonatomic,assign)CGRect modalWindowFrame;

/**
 *  the modalview level
 */
@property(nonatomic,assign)UIWindowLevel modalWindowLevel;
/**
 *  init method
 *
 *  @param contentView the contentview
 *  @param delegate    the modal present dismiss delegate
 *
 *  @return
 */
-(instancetype)initWithContentView:(UIView *)contentView
                          delegate:(id<TTModalViewDelgate>)delegate;

/**
 *
 *
 *  @param contentView           the contentview
 *  @param delegate              the modal present and dismiss delegate
 *  @param presentAnimationStyle present animation style
 *  @param dismissAnimationStyle dismiss animation style
 *
 *  @return
 */
-(instancetype)initWithContentView:(UIView *)contentView
                          delegate:(id<TTModalViewDelgate>)delegate
             presentAnimationStyle:(AnimationType)presentAnimationStyle
             dismissAnimationStyle:(AnimationType)dismissAnimationStyle;

/**
 *  show method that show the modalview with the animationStyle
 *
 *  @param didAddContentBlock call back when the content has add
 */
-(void)showWithDidAddContentBlock:(TTModalDidAddContentBlock)didAddContentBlock;

/**
 *
 *
 *  @param PresentBlock
 *  @param animationStyle
 *  @param didAddContentBlock
 */
-(void)showWithPresentBlock:(void (^)(void))PresentBlock
   presentAnimationStyle:(AnimationType) animationStyle
      didAddContentBlock:(TTModalDidAddContentBlock)didAddContentBlock;



-(void)dismiss;

-(void)dismissWithDismissBlock:(void(^)(void))dismissBlock
         dismissAnimationStyle:(AnimationType)animationStyle;



@end


@protocol TTModalViewDelgate <NSObject>
@optional

-(void)TTModalViewDidShow:(TTModalView *)TTModalView;

-(void)TTModalViewDidDismiss:(TTModalView *)TTModalView;

@end
