//
//  BuyViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyViewController.h"
#import "BuyItemCell.h"
#import "UISearchBar+RACSignalSupport.h"
#import "BuySlideDetailViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "UISearchBar+Utils.h"
#import "MJRefresh.h"
#import "SearchViewController.h"
#import "ProductViewController.h"




#define kTableViewHeadHeight 128.f
#define kCarouselImageViewWidth 300.f
#define kNumberOfCellPerPage 3
#define kTotalSlides 5

@interface BuyViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, assign) CGSize cardSize;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *filtedItems;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIBarButtonItem* searchButtonItem;
@property (nonatomic, strong) UIBarButtonItem* cancelButtonItem;
@property (nonatomic) BOOL loadingMore;

@end

@implementation BuyViewController

-(UIBarButtonItem*)searchButtonItem
{
    if(!_searchButtonItem){
        _searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_search_white"] style:UIBarButtonItemStylePlain target:self action:nil];
        @weakify(self);
        [_searchButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
//            self.navigationItem.rightBarButtonItem = self.cancelButtonItem;
//            self.navigationItem.titleView = self.searchBar;
//            [self.searchBar animateToEnabledState:YES];
            SearchType type = [self isMemberOfClass:[BuyViewController class]]? kSearchTypeBuy : kSearchTypeSell;
            SearchViewController* searchVC = [[SearchViewController alloc] initWithType:type];
            [self.navigationController pushViewController:searchVC animated:YES];
            return [RACSignal empty];
        }]];
    }
    return _searchButtonItem;
}

-(UIBarButtonItem*)cancelButtonItem
{
    if(!_cancelButtonItem){
        _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
        @weakify(self);
        [_cancelButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            self.navigationItem.rightBarButtonItem = self.searchButtonItem;
            self.navigationItem.titleView = nil;
//            [self.searchBar animateToEnabledState:NO];

            self.filtedItems = [self.items mutableCopy];
            [self.tableView reloadData];
            return [RACSignal empty];
        }]];
    }
    return _cancelButtonItem;
}

-(UISearchBar*)searchBar
{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.tintColor = [UIColor blueColor];
        @weakify(self);
        [_searchBar.rac_textSignal subscribeNext:^(NSString* text) {
            @strongify(self);
            if(text.length ==0){
                self.filtedItems = [self.items mutableCopy];
            }
            else if(text.length> 0 && self.items && self.items.count>0) {
                self.filtedItems = [self.items mutableCopy];
                [self.filtedItems filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains [cd] %@", text]];
            }
            [self.tableView reloadData];
        }];
    }
    return _searchBar;
}

-(UIRefreshControl*)refreshControl
{
    if(!_refreshControl){
        _refreshControl = [[UIRefreshControl alloc] init];
        [[_refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
            NSLog(@"refreshControl pulled");
            [self performSelector:@selector(cancleRefresh) withObject:nil afterDelay:3];
        }];

    }
    return _refreshControl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = [[NSMutableArray alloc] init];
    for (int i = 0; i < kTotalSlides; i++)
    {
        [self.items addObject:[NSString stringWithFormat:@"飞利浦 -V387 黑色 1GB 联通 3G WCDMA %d", i]];
    }
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"189 疯狂买卖王 求购";
    self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    //self.navigationController
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyItemCell" bundle:nil] forCellReuseIdentifier:@"BuyItemCell"];
    [self.view addSubview:self.tableView];

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.items addObject:[NSString stringWithFormat:@"T 飞利浦 -V387 黑色 1GB 联通 3G WCDMA %lu", (unsigned long)self.items.count]];
            self.filtedItems = [self.items mutableCopy];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.items addObject:[NSString stringWithFormat:@"B 飞利浦 -V387 黑色 1GB 联通 3G WCDMA %lu", (unsigned long)self.items.count]];
            self.filtedItems = [self.items mutableCopy];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    }];

    //create carousel
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, kTableViewHeadHeight)];
    self.carousel.backgroundColor = [UIColor UIColorFromRGB:0xF5F5F5];
    //_carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.carousel.type = iCarouselTypeCoverFlow2;
//    self.carousel.autoscroll = .5f;
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.tableView.tableHeaderView = self.carousel;
 
    self.filtedItems = [self.items mutableCopy];
    [self.tableView reloadData];
    
}

-(void)cancleRefresh
{
    [self.refreshControl endRefreshing];
}

-(void)searchButtonClicked:(id)sender
{
    NSLog(@"searchButtonClicked");
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:NO animated:YES];
    
}

#pragma mark iCarousel delegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return kTotalSlides;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCarouselImageViewWidth, kTableViewHeadHeight)];
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"slide-%ld.jpg", index]];
        view.contentMode = UIViewContentModeScaleToFill;
        view.clipsToBounds = YES;
        view.userInteractionEnabled = YES;
        view.tag = index + 10000;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
        [view addGestureRecognizer:singleTap];
        [singleTap.rac_gestureSignal subscribeNext:^(UITapGestureRecognizer* g) {
            NSLog(@"image %ld tapped", g.view.tag);
            
            BuySlideDetailViewController* slideDetailVC = [[BuySlideDetailViewController alloc] initWithURL:@"http://www.baidu.com"
                                                                                                   andTitle:[NSString stringWithFormat:@"Image %ld", g.view.tag]];
            [self.navigationController pushViewController:slideDetailVC animated:YES];
            
        }];
        
    }
    
//    if(index == 1){
//        [carousel scrollToItemAtIndex:index animated:NO];
//    }
    
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.03f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -- tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return ceil(([ UIScreen mainScreen ].applicationFrame.size.height - kTableViewHeadHeight - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height)/kNumberOfCellPerPage);
    return [BuyItemCell cellHeight];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"BuyItemCell" owner:nil options:nil] firstObject];
    BuyItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BuyItemCell"];
//    cell.backgroundColor = [UIColor UIColorFromRGB:0xF5F5F5];
    cell.titleLabel.text = self.filtedItems[indexPath.row];
    cell.arrawString = @"求购";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filtedItems.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController* productVC = [[ProductViewController alloc]  init];
    
    [self.navigationController pushViewController:productVC animated:YES];
}


@end
