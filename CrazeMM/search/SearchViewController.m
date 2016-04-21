//
//  SearchViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchViewController.h"
#import "UISearchBar+RACSignalSupport.h"
#import "UITabBarController+HideTabBar.h"
#import "KeyWordsCell.h"
#import "SearchHistoryCell.h"
#import "ClearHistoryCell.h"
#import "SearchListViewController.h"

typedef NS_ENUM(NSInteger, SearchTableViewSection){
    kSectionKeywords = 0,
    kSectionSearchHistory,
    kSectionClearSearchHistory,
    kSectionMax
};




@interface SearchViewController ()

@property (nonatomic) SearchType searchType;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIBarButtonItem* backButtonItem;
@property (nonatomic, strong) UIBarButtonItem* searchButtonItem;
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* searchKeywords;
@property (nonatomic, strong) NSMutableArray* searchHistory;

@property (nonatomic, strong) KeyWordsCell* keywordsCell;
@property (nonatomic, strong) ClearHistoryCell* clearHistoryCell;

@end

@implementation SearchViewController

-(UISearchBar*)searchBar
{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.tintColor = [UIColor blueColor];
        _searchBar.placeholder = [NSString stringWithFormat:@"输入你所需要的%@信息", self.searchType==kSearchTypeBuy?@"求购":@"供货"];
        
        @weakify(self);
        [_searchBar.rac_textSignal subscribeNext:^(NSString* text) {
            @strongify(self);
            
            //[self.tableView reloadData];
        }];
    }
    return _searchBar;
}

-(UIBarButtonItem*)searchButtonItem
{
    if(!_searchButtonItem){
        _searchButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:nil];
        @weakify(self);
        [_searchButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            SearchListViewController* searchListVC = [[SearchListViewController alloc] initWithKeyword:self.searchBar.text];
            [self.navigationController pushViewController:searchListVC animated:YES];
            return [RACSignal empty];
        }]];
    }
    return _searchButtonItem;
}


-(instancetype)initWithType:(SearchType)searchType
{
    self = [super init];
    if(self){
        self.searchType = searchType;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [self.tableView setTableFooterView:view];

    
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    
    self.keywordsCell = [[[NSBundle mainBundle]loadNibNamed:@"KeyWordsCell" owner:nil options:nil] lastObject];
    self.clearHistoryCell = [[[NSBundle mainBundle]loadNibNamed:@"ClearHistoryCell" owner:nil options:nil] lastObject];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchHistoryCell" bundle:nil] forCellReuseIdentifier:@"SearchHistoryCell"];

    
    self.searchKeywords = [@[@"AAAA", @"BBBB", @"CCCCCCCCCCC", @"DDDDDDDDDD", @"EEEEE"] mutableCopy];
    self.searchHistory = [@[@"AAAA", @"BBBB", @"CCCCCCCCCCC", @"DDDDDDDDDD", @"EEEEE"] mutableCopy];
    @weakify(self);
    [self.keywordsCell setKeywords:self.searchKeywords andBlock:^(id sender){
        @strongify(self);
        UIButton* btn = (UIButton*)sender;
        SearchListViewController* vc = [[SearchListViewController alloc] initWithKeyword:btn.titleLabel.text];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

#pragma -- mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionMax;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    CGFloat cellHeight = 100.f;
    switch (section) {
        case kSectionKeywords:
            cellHeight = self.keywordsCell.cellHight;
            break;
        case kSectionSearchHistory:
            cellHeight = [SearchHistoryCell cellHight];
            break;
        case kSectionClearSearchHistory:
            cellHeight = [ClearHistoryCell cellHeight];
            break;
            
        default:
            break;
    }
    
    return cellHeight;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UITableViewCell* cell = [[UITableViewCell alloc] init];;

    switch (section) {
        case kSectionKeywords:
            cell = self.keywordsCell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.clipsToBounds = YES;
            break;
        case kSectionSearchHistory:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryCell"];
            SearchHistoryCell* sc = (SearchHistoryCell*)cell;
            sc.historyString = self.searchHistory[indexPath.row];

            if(indexPath.row != self.searchHistory.count-1){
                sc.enableButtomLine = false;
            }
        }
            break;
        case kSectionClearSearchHistory:
            cell = self.clearHistoryCell;
            break;
        default:
            break;
    }
    
    //cell.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNum = 0;
    switch (section) {
        case kSectionKeywords:
            rowNum = 1;
            break;
            
        case kSectionSearchHistory:
            rowNum = self.searchHistory.count;
            break;
            
        case kSectionClearSearchHistory:
            rowNum = 1;
            break;
            
        default:
            break;
    }
    
    return rowNum;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString* title;
//    switch (section) {
//        case kSectionKeywords:
//            title = @"热门搜索";
//            break;
//            
//        case kSectionSearchHistory:
//            title = @"搜索历史记录";
//            break;
//        default:
//            break;
//    }
//    return title;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case kSectionKeywords:
        case kSectionSearchHistory:
            return 44.f;
            break;
        default:
            break;
    }
    
    return 0.f;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString* title;
    switch (section) {
        case kSectionKeywords:
            title = @"热门搜索";
            break;
            
        case kSectionSearchHistory:
            title = @"搜索历史记录";
            break;
        default:
            return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.f, 0, 320, 44.f)];
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
    
    return contentView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    //NSUInteger row = indexPath.row;
    switch (section) {
        case kSectionKeywords:
            //
            break;
        case kSectionSearchHistory:
        {
            UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
            SearchListViewController* vc = [[SearchListViewController alloc] initWithKeyword:cell.textLabel.text];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
