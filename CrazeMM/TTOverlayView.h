//
//  TTOverlayView.h
//  Pods
//
//  Created by titengjiang on 16/3/8.
//
//

#import <UIKit/UIKit.h>
#import "TTModalView.h"


@interface TTOverlayView : UIView

/** The style of the overlay. */
@property (nonatomic) TTModalOverlayMode overlayMode;

/** The color for the overlay. This color will be used in both the linear and gradient overlay modes. */
@property (nonatomic) CGColorRef overlayColor;

/** Init a new overlay view with the specified frame and overlayMode.
 
 @param frame The frame of the overlayView.
 @param overlayMode The style of the overlay.
 */
- (instancetype)initWithFrame:(CGRect)frame
                  overlayMode:(TTModalOverlayMode)overlayMode;

@end
