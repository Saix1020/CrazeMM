//
//  BuyViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BuyListViewController.h"
#import "UISearchBar+RACSignalSupport.h"
#import "BuySlideDetailViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "UISearchBar+Utils.h"
#import "MJRefresh.h"
#import "SearchViewController.h"
#import "ProductViewController.h"
#import "ProductDescriptionDTO.h"
#import "TTModalView.h"
#import "ProductRecommendView.h"
#import "LoginViewController.h"
#import "SignViewController.h"
#import "ProductSummaryCell.h"
#import "HttpBuyRequest.h"
#import "BuyProductViewController.h"
#import "BuyProductDTO.h"
#import "HttpAddIntention.h"

#define kTableViewHeadHeight 128.f
#define kCarouselImageViewWidth 300.f
#define kNumberOfCellPerPage 3
#define kTotalSlides 5

@interface BuyListViewController ()
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, assign) CGSize cardSize;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIBarButtonItem* searchButtonItem;
@property (nonatomic, strong) UIBarButtonItem* cancelButtonItem;
@property (nonatomic) BOOL loadingMore;

@property (nonatomic) BOOL scrollWay;
@property (nonatomic, strong) RACSignal *updateEventSignal ;
//@property  (nonatomic, strong) RACDisposable *disposable;
@property (nonatomic) BOOL stopTimer;

@property (nonatomic, strong) TTModalView* productRecommendAlertView;

@property (nonatomic) BOOL isCarouselAnimating;
@property (nonatomic) NSUInteger timeElapse;

@end

@implementation BuyListViewController

-(TTModalView*)productRecommendAlertView
{
    if (!_productRecommendAlertView) {
        _productRecommendAlertView = [[TTModalView alloc] initWithContentView:nil delegate:nil];
        _productRecommendAlertView.isCancelAble = YES;
        _productRecommendAlertView.modalWindowLevel = UIWindowLevelNormal;
        
        ProductRecommendView *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"ProductRecommendView" owner:nil options:nil] lastObject];
//        transferAlertView.layer.cornerRadius = 6.f;
        
//        transferAlertView.alertMsgLabel.text = message;
        _productRecommendAlertView.contentView = transferAlertView;
        
        _productRecommendAlertView.presentAnimationStyle = RotateIn;
        _productRecommendAlertView.dismissAnimationStyle = RotateOut ;
    }
    
    return _productRecommendAlertView;
}

-(UIBarButtonItem*)searchButtonItem
{
    if(!_searchButtonItem){
        _searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self);
        [_searchButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
//            self.navigationItem.rightBarButtonItem = self.cancelButtonItem;
//            self.navigationItem.titleView = self.searchBar;
//            [self.searchBar animateToEnabledState:YES];
            SearchType type = [self isMemberOfClass:[BuyListViewController class]]? kSearchTypeBuy : kSearchTypeSell;
            SearchViewController* searchVC = [[SearchViewController alloc] initWithType:type];
            [self.navigationController pushViewController:searchVC animated:YES];
            return [RACSignal empty];
        }]];
    }
    return _searchButtonItem;
}

//-(UIBarButtonItem*)cancelButtonItem
//{
//    if(!_cancelButtonItem){
//        _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
//        @weakify(self);
//        [_cancelButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            @strongify(self);
//            self.navigationItem.rightBarButtonItem = self.searchButtonItem;
//            self.navigationItem.titleView = nil;
////            [self.searchBar animateToEnabledState:NO];
//
//            self.filtedItems = [self.items mutableCopy];
//            [self.tableView reloadData];
//            return [RACSignal empty];
//        }]];
//    }
//    return _cancelButtonItem;
//}

//-(UISearchBar*)searchBar
//{
//    if(!_searchBar){
//        _searchBar = [[UISearchBar alloc] init];
//        _searchBar.tintColor = [UIColor blueColor];
//        @weakify(self);
//        [_searchBar.rac_textSignal subscribeNext:^(NSString* text) {
//            @strongify(self);
//            if(text.length ==0){
//                self.filtedItems = [self.items mutableCopy];
//            }
//            else if(text.length> 0 && self.items && self.items.count>0) {
//                self.filtedItems = [self.items mutableCopy];
//                [self.filtedItems filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains [cd] %@", text]];
//            }
//            [self.tableView reloadData];
//        }];
//    }
//    return _searchBar;
//}

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

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"189 疯狂买卖王 求购";
    self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    //self.navigationController
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerNib:[UINib nibWithNibName:@"BuyItemCell" bundle:nil] forCellReuseIdentifier:@"BuyItemCell"];
    [self.view addSubview:self.tableView];
    
    UIView *view = [UIView new];
    //view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;


    
    // add some mock data
    for (int i=0; i<10; i++) {
        ProductDescriptionDTO* dto = [ProductDescriptionDTO mockDate];

        [self.dataSource addObject:dto];
    }
    
    self.timeElapse = 0;

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self getProducts:NO]
        .then(^(id x){
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        })
        .catch(^(NSError* error){
            [self.tableView.mj_header endRefreshing];
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getProducts:NO]
        .then(^(id x){
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];

        })
        .catch(^(NSError* error){
            [self.tableView.mj_footer endRefreshing];
            [self showAlertViewWithMessage:error.localizedDescription];
        });;
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;


    //create carousel
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 0, kTableViewHeadHeight)];
    self.carousel.backgroundColor = [UIColor UIColorFromRGB:0xF5F5F5];
    self.carousel.type = iCarouselTypeCoverFlow2;
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.isCarouselAnimating = NO;
    
    self.tableView.tableHeaderView = self.carousel;
 
//    self.filtedItems = [self.items mutableCopy];
//    self.updateEventSignal = [[RACSignal interval:4
//                                       onScheduler:[RACScheduler mainThreadScheduler]
//                                ]
//                              takeUntilBlock:^BOOL (id x){
//                                  return self.stopTimer;
//                              }];
//    @weakify(self);

    [[MMTimer sharedInstance].oneSecondSignal subscribeNext:^(id x){
        @strongify(self);

        self.timeElapse ++;
        if (self.timeElapse % 4 ==0) {
            
            if (self.isCarouselAnimating) {
                return;
            }
            
            self.isCarouselAnimating = YES;
            
            if (self.carousel.currentItemIndex == self.carousel.numberOfItems-1) {
                self.scrollWay = YES;
            }
            else if(self.carousel.currentItemIndex == 0){
                self.scrollWay = NO;
            }
            if (self.scrollWay) {
                [self.carousel scrollToItemAtIndex:self.carousel.currentItemIndex-1 duration:1];
                
            }
            else {
                [self.carousel scrollToItemAtIndex:self.carousel.currentItemIndex+1 duration:1];
                
            }
        }
    }];
    [self clearData];
    [self getProducts:YES];
    //[self.tableView reloadData];
    

    
}

-(void)refreshData
{
    [self clearData];
    [self.tableView reloadData];
    [self getProducts:YES];
    [self.tableView reloadData];
}

-(void)refreshDataNoHud
{
    [self clearData];
    [self.tableView reloadData];
    [self getProducts:NO];
    [self.tableView reloadData];
}

-(void)clearData
{
    self.pageNumber = 0;
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];

}

-(AnyPromise*)getProducts:(BOOL)needHud
{
    HttpBuyRequest* request;
//    if ([[UserCenter defaultCenter] isLogined]) {
        request = [[HttpBuyRequest alloc] initWithPageNumber:self.pageNumber+1];
//    }
//    else{
//        request = [[HttpSupplyNoLoginRequest alloc] initWithPageNumber:self.pageNumber+1];
//    }
    if (needHud) {
        [self showProgressIndicatorWithTitle:@"正在努力加载..."];
    }
    return [request request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpBuyResponse* response = (HttpBuyResponse*)request.response;
        if(response.ok){
            self.pageNumber = response.pageNumber;
            self.totalPage = response.totalPage;
            [self.dataSource addObjectsFromArray:response.productDTOs];
            [self.tableView reloadData];
        }
    })
    .catch(^(NSError* error){
        if ([error needLogin]) {
            [self showAlertViewWithMessage:@"请先登录"];
        }
        else {
            [self showAlertViewWithMessage:error.localizedDescription];
        }
    })
    .finally(^(){
        if (needHud) {
            [self dismissProgressIndicator];
        }
    });
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    // for debug
//    if ([self isMemberOfClass:[BuyListViewController class]]) {
//        return;
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess:)
                                                 name:kLoginSuccessBroadCast
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutSucess:)
                                                 name:kLogoutSuccessBroadCast
                                               object:nil];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:NO animated:YES];
    
    if (![[UserCenter defaultCenter] isLogined]) {
        @weakify(self);
        [self.productRecommendAlertView showWithDidAddContentBlock:^(UIView *contentView) {
            
            @strongify(self);
            contentView.centerX = self.view.centerX;
            contentView.centerY = self.view.centerY;
            
            ProductRecommendView* transferAlertView = (ProductRecommendView*)contentView;
            transferAlertView.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                [self.productRecommendAlertView dismiss];
                
                [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
                
                return [RACSignal empty];
            }];
            
            transferAlertView.signupButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                [self.productRecommendAlertView dismiss];
                
                [self.navigationController pushViewController:[[SignViewController alloc] init] animated:YES];

                
                return [RACSignal empty];
            }];
        }];

    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.stopTimer = YES;
}

-(void)loginSuccess:(NSNotification*)notification
{
    [self clearData];
    [self getProducts:NO];
}

-(void)logoutSucess:(NSNotification*)notification
{
    [self clearData];
    [self getProducts:NO];
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
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"slide-%ld.jpg", (long)index]];
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

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    self.isCarouselAnimating = NO;
}


#pragma mark -- tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ProductSummaryCell cellHeight];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductSummaryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ProductSummaryCell"];
    if (!cell) {
        cell = [[ProductSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProductSummaryCell"];
        cell.cellType = @"求购";
    }
    cell.productDto = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyProductDTO* dto = self.dataSource[indexPath.row];
    [HttpAddViewRequest addView:dto.id andType:kTypeBuy];
    BuyProductViewController* vc = [[BuyProductViewController alloc] initWithProductDTO:dto];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLoginSuccessBroadCast
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLogoutSuccessBroadCast
                                                  object:nil];
}

@end
