//
//  LoopView.h
//  Test_LoopScrollView
//
//

#import <UIKit/UIKit.h>

@interface LoopView : UIView<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;


-(instancetype)initWithImages:(NSArray*)images;
-(instancetype)initWithImageUrls:(NSArray*)imageUrls;
- (void)changePage;

@end
