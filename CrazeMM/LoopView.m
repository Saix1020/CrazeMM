//
//  LoopView.m
//  Test_LoopScrollView
//
//

#import "LoopView.h"
#import "UIImageView+AFNetworking.h"

#define kLoopViewDefaultHeight 128.f
#define kLoopViewDefaultWidth ([UIScreen mainScreen].bounds.size.width)
#define kLoopMaxImageNumber 7
#define kPageControlPadding 0.f
#define kPageControlHeight 20.f
#define kPageControlBottomPadding 16.f

@interface LoopView ()

@property (nonatomic, copy) NSArray<NSString*>* images;
@property (nonatomic, copy) NSArray<NSString*>* imageUrls;

@property (nonatomic, readonly) NSUInteger imagesCount;
@property (nonatomic) BOOL isOrder;
@end

@implementation LoopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isOrder = YES;
        [self setupScrollView];
        [self setupPageControl];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight)];
}

-(instancetype)initWithImages:(NSArray*)images
{
    self = [super initWithFrame:CGRectMake(0, 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight)];
    if(self){
        _isOrder = YES;
        _images = images;
        [self setupScrollView];
        [self setupPageControl];
    }
    return self;
}

-(instancetype)initWithImageUrls:(NSArray*)imageUrls
{
    self = [super initWithFrame:CGRectMake(0, 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight)];
    if (self) {
        _isOrder = YES;
        _imageUrls = imageUrls;
        [self setupScrollView];
        [self setupPageControl];

    }
    return self;
}


-(UIImageView*)imageViewAtIndex:(NSUInteger)index
{
    UIImageView* imageView = [[UIImageView alloc] init];
    if (self.imageUrls.count) {
        [imageView setImageWithURL:[self.imageUrls objectAtIndex:index] placeholderImage:[@"background_alpha" image]];
    }
    else {
        imageView.image = [[self.images objectAtIndex:index] image];
    }
        
    return imageView;
}

-(NSUInteger)imagesCount
{
    return self.imageUrls.count?self.imageUrls.count:self.images.count;
}

- (void)setupScrollView
{
    NSUInteger imageNumber = self.imagesCount;
    
    if(imageNumber==0)
        return;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.tag = 200;
    _scrollView.contentSize = CGSizeMake(kLoopViewDefaultWidth * imageNumber, kLoopViewDefaultHeight);
    [_scrollView setContentOffset:CGPointMake(kLoopViewDefaultWidth, 0) animated:NO];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    
    // set last image the same with the 'first'
    // and the first image the same with the 'last'
    
    UIImageView* firstImageView = [self imageViewAtIndex:self.imagesCount-1];
    UIImageView* lastImageView = [self imageViewAtIndex:0];
    [_scrollView addSubview:firstImageView];

    firstImageView.frame = CGRectMake(0, 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight);

    for (int i = 0; i < imageNumber; i++) {
        UIImageView* imageView = [self imageViewAtIndex:i];
        [_scrollView addSubview:imageView];
        imageView.frame = CGRectMake(kLoopViewDefaultWidth*(i+1), 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight);
    }
    
    lastImageView.frame = CGRectMake(kLoopViewDefaultWidth*(imageNumber+1), 0, kLoopViewDefaultWidth, kLoopViewDefaultHeight);

    [_scrollView addSubview:lastImageView];

    
    _scrollView.delegate = self;
}

- (void)setupPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kPageControlPadding, kLoopViewDefaultHeight - kPageControlBottomPadding, kLoopViewDefaultWidth-kPageControlPadding*2, kPageControlHeight)];
    _pageControl.tag = 100;
    _pageControl.numberOfPages = self.imagesCount;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_pageControl];
    
    [_pageControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
}

- (void)dealloc
{
    self.scrollView = nil;
    self.pageControl = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIPageControl *pageControl = self.pageControl;
    int currentPage = scrollView.contentOffset.x / kLoopViewDefaultWidth;
    
    if (currentPage == 0) {
        [scrollView setContentOffset:CGPointMake(kLoopViewDefaultWidth * self.imagesCount, 0) animated:NO];
        pageControl.currentPage = self.imagesCount-1;
    } else if (currentPage == self.imagesCount+1) {
        [scrollView setContentOffset:CGPointMake(kLoopViewDefaultWidth, 0) animated:NO];
        pageControl.currentPage = 0;
    } else {
        pageControl.currentPage = currentPage - 1;
    }
}

- (void)handlePageControl:(UIPageControl *)pageControl
{
    UIScrollView *scrollView = self.scrollView;
    [scrollView setContentOffset:CGPointMake(kLoopViewDefaultWidth * (pageControl.currentPage + 1), 0) animated:YES];
}


- (void)changePage
{
    NSInteger page = self.pageControl.currentPage;
    if (_isOrder) {
        page++;
        page = page > self.imagesCount-1 ? 0 : page;
        if (!page) {
            _isOrder = NO;
            page = self.imagesCount-2;
        }
    } else {
        page--;
        page = page < 0 ? 0 : page;
        if (!page) {
            _isOrder = YES;
            page = 0;
        }
    }
    self.pageControl.currentPage = page;
    [self.scrollView setContentOffset:CGPointMake(kLoopViewDefaultWidth * (page + 1), 0) animated:YES];
}



@end
