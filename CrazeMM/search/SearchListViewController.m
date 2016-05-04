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



@interface SearchListViewController ()

@property (nonatomic, copy) NSString* searchKeyword;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) PPiFlatSegmentedControl *segmented;
@property (nonatomic) NSUInteger segmentedItemClickedNum;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@property (nonatomic, strong) FilterViewController* fitlerVC;
@property (nonatomic, strong) SegmentedCell* segmentCell;

@property (nonatomic, strong) UIButton* filterButton;
@end

@implementation SearchListViewController


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
        _segmentCell.height = @(40.0f);
        [_segmentCell setTitles:@[@"人气", @"价格", @"供货量"] andIcons:@[@"arrow_up", @"arrow_up", @"arrow_up"]];
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [self.tableView setTableFooterView:view];
    
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)", @"搜索结果", self.searchKeyword];
    //self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"SearchListCell" bundle:nil] forCellReuseIdentifier:@"SearchListCell"];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    }];
    
    self.tableView.tableHeaderView = self.segmentCell;

    
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
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    self.segmented.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
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
    [self removeSearchViewController];
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [SearchListCell cellHeight];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SearchListCell"];
    if(!cell){
        cell = [[SearchListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchListCell"];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController* productVC = [[ProductViewController alloc]  init];
    
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma -- mark custom segment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    
    UIButton* button = segment.buttons[index];
    UIButton* prevButton = segment.buttons[segment.prevIndex];
    if (segment.prevIndex != index) {
        //button.imageView.transform = CGAffineTransformMakeRotation(0);
//        button.imageView.hidden = NO;
//        prevButton.imageView.hidden = YES;
    }
    else {
        if (CGAffineTransformEqualToTransform(button.imageView.transform,
                                              CGAffineTransformMakeRotation(0)))
        {
            button.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        else {
            button.imageView.transform = CGAffineTransformMakeRotation(0);
        }
    }
}

@end
