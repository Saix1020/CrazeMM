//
//  SearchListViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchViewController.h"
#import "SearchListCell.h"
#import "MJRefresh.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "UIButton+PPiAwesome.h"
#import "UIBarButtonItem+FontAwesome.h"
#import "FilterViewController.h"
#import "ZZPopoverWindow.h"
#import "UISearchBar+RACSignalSupport.h"
#import "ProductViewController.h"
#import "SegmentedCell.h"
#import "HttpSearchRequest.h"
#import "SearchResultDTO.h"
#import "SupplyProductViewController.h"
#import "BuyProductViewController.h"
#import "HttpAddIntention.h"
#import "UITableView+FDTemplateLayoutCell.h"


#define kSegmentCellHeight 40.f
#define kTableViewInsetTopWithoutSegment (kSegmentCellHeight+64)

@interface SearchListViewController ()

@property (nonatomic) UIView* emptyView;
@property (nonatomic, copy) NSString* searchKeyword;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) PPiFlatSegmentedControl *segmented;
@property (nonatomic) NSUInteger segmentedItemClickedNum;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@property (nonatomic, strong) FilterViewController* fitlerVC;
@property (nonatomic, strong) SegmentedCell* segmentCell;

@property (nonatomic, strong) UIButton* filterButton;

@property (nonatomic) SearchCategory searchCategory;
@property (nonatomic, strong) NSArray* dataSourceArray;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) NSMutableArray* cellHeight;
@property (nonatomic, strong) NSString* searchCategoryString;
@property (nonatomic) NSUInteger currentPage;
@property (nonatomic) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger sortTypes;

@property (nonatomic) CGPoint ptLastOffset;

@end



@implementation SearchListViewController

-(UIView*)emptyView
{
    if (!_emptyView){
        _emptyView = [UINib viewFromNib:@"SearchEmpty"];
        _emptyView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.view addSubview:_emptyView];
        _emptyView.backgroundColor = [UIColor clearColor];
        _emptyView.hidden = YES;
    }
    
    return _emptyView;
}

-(NSUInteger)sortTypes
{
    NSUInteger segmentSelectedIndex = self.segmentCell.segment.currentIndex;
    UIButton* button = self.segmentCell.segment.buttons[segmentSelectedIndex];

    BOOL sortIncrease = CGAffineTransformEqualToTransform(button.imageView.transform,
                                                          CGAffineTransformMakeRotation(0));
    switch (segmentSelectedIndex) {
        case 0:
            return 0;
        case 1:
        {
            if (sortIncrease) {
                return 10;
            }
            else {
                return 11;
            }
        }
        case 2:
        {
            if (sortIncrease) {
                return 20;
            }
            else {
                return 21;
            }        }
 
        default:
            break;
    }
    
    return 0;
}

-(void)clearDataSources
{
    for (NSMutableArray* array in [self dataSourceArray]) {
        [array removeAllObjects];
    }
    [self.cellHeight removeAllObjects];
    
    // we should reload data here
    [self.tableView reloadData];
}

-(void)setDataSource:(NSMutableArray<SearchResultDTO *> *)dataSource
{
    _dataSource = dataSource;
    self.currentPage = 0;
    self.totalPage = 1;
}

-(FilterViewController*)fitlerVC
{
    if(!_fitlerVC){
        _fitlerVC = [[FilterViewController alloc] init];
        _fitlerVC.filterKeywords = @[@"AAAAA", @"BBBB", @"CCCCC", @"DDDDDDD"];
        //[self addChildViewController:_fitlerVC];
    }
    return _fitlerVC;
}

-(SegmentedCell*)segmentCell
{
    if(!_segmentCell){
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleB;
        _segmentCell.height = @(kSegmentCellHeight);
        [_segmentCell setTitles:@[@"人气", @"价格", @"供货量"] andIcons:@[@"", @"arrow_up", @"arrow_up"]];
//        ((UIButton*)(_segmentCell.segment.buttons[1])).imageView.hidden = ((UIButton*)(_segmentCell.segment.buttons[2])).imageView.hidden = YES;
        
        _segmentCell.segment.delegate = self;
    }
    return _segmentCell;
}

+(NSArray*)createItems:(NSUInteger)selectedIndex andNumber:(NSUInteger)number
{
    // TODO 
    NSArray* items;
    NSString* icon = number%2?@"icon-long-arrow-down" : @"icon-long-arrow-up";

    switch (selectedIndex) {
        case 0:
            items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"人气" andIcon:icon],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"价格" andIcon:nil],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"供货量" andIcon:nil]];
            break;
        case 1:
            items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"人气" andIcon:nil],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"价格" andIcon:icon],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"供货量" andIcon:nil]];
            break;

        case 2:
            items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"人气" andIcon:nil],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"价格" andIcon:nil],
                      [[PPiFlatSegmentItem alloc] initWithTitle:@"供货量" andIcon:icon]];
            break;

        default:
            break;

    }
    
    return items;
}

-(instancetype)initWithKeyword:(NSString*)keyword
{
    self = [super init];
    if(self){
        self.searchKeyword = keyword;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSourceArray = @[[[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init],
                             [[NSMutableArray alloc] init]
                             ];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [self.tableView setTableFooterView:view];
    [self.view addSubview:self.segmentCell];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", @"搜索结果"];
    if (self.tabBarController.selectedIndex == 0) {
        self.searchCategory = kSupplySearch;
        self.searchCategoryString = @"供货";
    }
    else {
        self.searchCategory = kBuySearch;
        self.searchCategoryString = @"求购";
    }
    
    [self.tableView registerClass:[SearchListCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"SearchListCell-%@", self.searchCategoryString]];

    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getSearchList]
        .finally(^(){
            [self.tableView.mj_header endRefreshing];
        });

    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);

        [self getSearchList].finally(^(){
            [self.tableView.mj_footer endRefreshing];
        });

    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;

    //self.tableView.tableHeaderView = self.segmentCell;
//    [self.tableView addSubview:self.segmentCell];
    
    self.filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.filterButton setImage:[@"filter" image] forState:UIControlStateNormal];
    self.filterButton.frame = CGRectMake(0, 0, 24, 24);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.filterButton];
    
    
    
    self.filterButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        @strongify(self);
        self.fitlerVC.view.frame = CGRectMake(0, 0, 200, self.fitlerVC.height);
        self.fitlerVC.view.backgroundColor = RGBCOLOR(150, 150, 150);
        self.popover                    = [[ZZPopoverWindow alloc] init];
        self.popover.showShadow = YES;
        self.popover.popoverPosition = ZZPopoverPositionUp;
        self.popover.contentView        = self.fitlerVC.view;
        self.popover.backgroundColor = RGBCOLOR(150, 150, 150);
        self.popover.didShowHandler = ^() {
            //self.popover.layer.cornerRadius = 0;
        };
        self.popover.didDismissHandler = ^() {
            //NSLog(@"Did dismiss");
        };
        
        [self.popover showAtView:self.filterButton];
        return [RACSignal empty];
    }];
    
    self.segmentCell.frame = CGRectMake(0, 64.f, [UIScreen mainScreen].bounds.size.width, kSegmentCellHeight);
    self.tableView.frame = self.view.bounds;
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;

    
    self.tableView.contentInset = UIEdgeInsetsMake(kSegmentCellHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kSegmentCellHeight, 0, 0, 0);
    
    
    self.dataSource = self.dataSourceArray[0];
    self.cellHeight = [[NSMutableArray alloc] init];
    [self getSearchList:YES].finally(^(){
        //        if (self.emptyView.hidden == YES) {
        //            [self removeSearchViewController];
        //        }
    });

}

-(AnyPromise*)getSearchList:(BOOL)needHud
{
    if (needHud) {
        [self showProgressIndicatorWithTitle:@"正在努力加载..."];
    }
    HttpSearchRequest* searchRequest = [[HttpSearchRequest alloc] initWithPageNumber:self.currentPage+1
                                                                         andKeywords:self.searchKeyword.length>0?@[self.searchKeyword]:@[]
                                                                            andSorts:self.sortTypes
                                                                         andCategory:self.searchCategory];
    searchRequest.caller = self;
    
    return [searchRequest request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        
        [self dismissProgressIndicator];
        
        HttpSearchResponse* response = (HttpSearchResponse*)searchRequest.response;
        
        //self.dataSource = [response.productDTOs mutableCopy];
        if (response.productDTOs && response.productDTOs.count>0) {
            if (self.currentPage == response.pageNumber) {
                return ;
            }
            self.currentPage = response.pageNumber;
            self.totalPage = response.totalPage;
            [self.dataSource addObjectsFromArray:response.productDTOs];
//            @weakify(self);
//            dispatch_async(dispatch_get_global_queue(0, 0), ^(){
//                @strongify(self);
//                for(SearchResultDTO* dto in response.productDTOs) {
//                    [self.cellHeight addObject:@([SearchListCell cellHeightWithDTO:dto])];
//                }
//                dispatch_async(dispatch_get_main_queue(), ^{
//                });
//            });
            [self.tableView reloadData];
            self.emptyView.hidden = YES;

            
        }
        else {
            if (self.dataSource.count == 0){
                self.emptyView.hidden = NO;
                self.segmentCell.hidden = YES;
            }
            
        }
        
    })
    .catch(^(NSError* error){
        if (needHud) {
            [self dismissProgressIndicator];
        }
        if ([error needLogin]) {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }
        else{
            [self showAlertViewWithMessage:error.localizedDescription];
        }
    });
    
}

-(AnyPromise*)getSearchList
{
    return [self getSearchList:NO];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    self.segmented.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    UIButton* btn;
//    btn = self.segmentCell.segment.buttons[1];
//    btn.imageView.hidden = YES;
//    btn = self.segmentCell.segment.buttons[2];
//    btn.imageView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)removeSearchViewController
{
    NSArray* controllers = self.navigationController.viewControllers;
    UIViewController* vc = [controllers objectAtIndex:1];
    if(vc && [vc isKindOfClass:[SearchViewController class]]){
        NSMutableArray* newVCs = [controllers mutableCopy];
        [newVCs removeObject:vc];
        self.navigationController.viewControllers = [newVCs copy];
    }
}

//-(void)viewWillAppear:(BOOL)animated


#pragma -- mark tableview deleaget

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultDTO* dto = [self.dataSource objectAtIndex:indexPath.row];

    return [tableView fd_heightForCellWithIdentifier:[NSString stringWithFormat:@"SearchListCell-%@", self.searchCategoryString] cacheByKey:@(dto.id) configuration:^(SearchListCell* cell) {
        // configurations
        if (cell.searchResultDTO.id != dto.id){
            [cell setSearchResultDTO:[self.dataSource objectAtIndex:indexPath.row] andTypeName:self.searchCategoryString];

//            cell.typeName = self.searchCategoryString;
//            cell.searchResultDTO = [self.dataSource objectAtIndex:indexPath.row];
        }

    }];
//    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchListCell* cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"SearchListCell-%@", self.searchCategoryString]];
    if(!cell){
        
        cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:[NSString stringWithFormat:@"SearchListCell-%@", self.searchCategoryString]
                                             andType:self.searchCategoryString];
    }
    //cell.typeName = self.searchCategoryString;
    if (cell.searchResultDTO.id != ((SearchResultDTO*)[self.dataSource objectAtIndex:indexPath.row]).id){
        [cell setSearchResultDTO:[self.dataSource objectAtIndex:indexPath.row] andTypeName:self.searchCategoryString];
        //cell.searchResultDTO = [self.dataSource objectAtIndex:indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController* productVC;
    if (self.tabBarController.selectedIndex == 0) {
        productVC = [[SupplyProductViewController alloc] initWithProductDTO:[self.dataSource objectAtIndex:indexPath.row]];

    }
    else {
        productVC = [[BuyProductViewController alloc] initWithProductDTO:[self.dataSource objectAtIndex:indexPath.row]];
    }
    
    BaseProductDTO* dto = self.dataSource[indexPath.row];
    [HttpAddViewRequest addView:dto.id andType:self.searchCategory==kSupplySearch?kTypeSupply:kTypeBuy];
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma -- mark custom segment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    UIButton* button = segment.buttons[index];
    if (segment.prevIndex != index) {
        [self clearDataSources];
        self.dataSource = self.dataSourceArray[index];
        [self getSearchList:YES];
    }
    else {
        if (index == 0) {
            return;
        }
        if (CGAffineTransformEqualToTransform(button.imageView.transform,
                                              CGAffineTransformMakeRotation(0)))
        {
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        else {
            button.imageView.transform = CGAffineTransformMakeRotation(0);
        }
        
        [self clearDataSources];
        self.dataSource = self.dataSourceArray[index];
        [self getSearchList:YES];
    }
}

#pragma -- mark UIScroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView == self.tableView){
        
        if (scrollView.isTracking && scrollView.dragging)
        {
            CGPoint ptOffset = scrollView.contentOffset;
            
            if (scrollView.contentSize.height >= scrollView.size.height) //内容高度大于view高度
            {
                if (ptOffset.y >= scrollView.contentSize.height - scrollView.size.height) //已经到最下方
                    return;
            }
            
            
            
            if (scrollView.contentInset.top == kTableViewInsetTopWithoutSegment)
            {
                if (ptOffset.y > -kTableViewInsetTopWithoutSegment) //下滑
                {
                    if ((ptOffset.y - self.ptLastOffset.y) > 0)
                    {
                        [self hideTopBars];
                        
                        self.ptLastOffset = ptOffset;
                        self.tableView.showsVerticalScrollIndicator = YES;
                    }
                    else
                    {
                        [self showTopBars];
                        self.ptLastOffset = ptOffset;
                    }
                }
            }
            else if (scrollView.contentInset.top == 0)
            {
                if (ptOffset.y > 0)
                {
                    if ((ptOffset.y - self.ptLastOffset.y) > 0)
                    {
                        [self hideTopBars];
                        
                        self.ptLastOffset = ptOffset;
                    }
                    else if ((ptOffset.y - self.ptLastOffset.y) < 0)
                    {
                        [self showTopBars];
                        self.ptLastOffset = ptOffset;
                    }
                }
                else if (ptOffset.y < 0)
                {
                    [self showTopBars];
                    self.ptLastOffset = ptOffset;
                }
            }
        }
    }
}

- (void)hideTopBars
{
    if (self.tableView.contentSize.height < self.tableView.height)
        return;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.segmentCell.transform = CGAffineTransformMakeTranslation(0, -300);
        
    } completion:^(BOOL finished) {
    }];
}

- (void)showTopBars
{
    self.tableView.contentInset = UIEdgeInsetsMake(kTableViewInsetTopWithoutSegment, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTableViewInsetTopWithoutSegment, 0, 0, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.segmentCell.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    
}


@end
