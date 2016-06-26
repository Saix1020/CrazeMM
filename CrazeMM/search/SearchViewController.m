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
#import "SearchHistory.h"
#import "HttpSearchKeyWord.h"

typedef NS_ENUM(NSInteger, SearchTableViewSection){
    kSectionKeywords = 0,
    kSectionSearchHistory,
    kSectionClearSearchHistory,
    kSectionMax
};

@interface SearchViewController ()

@property (nonatomic) SearchType searchType;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIView* searchView;
@property (nonatomic, strong) UIBarButtonItem* backButtonItem;
@property (nonatomic, strong) UIBarButtonItem* searchButtonItem;
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* searchKeywords;
@property (nonatomic, strong) NSMutableArray* searchHistory;

@property (nonatomic, strong) KeyWordsCell* keywordsCell;
@property (nonatomic, strong) ClearHistoryCell* clearHistoryCell;
@property (nonatomic, strong) SearchHistoryCell* searchHistoryEmptyCell;

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectcontent;

@end

@implementation SearchViewController

-(NSManagedObjectContext*)managedObjectcontent
{
    return sharedManagedObjectContext();
}

-(SearchHistoryCell*)searchHistoryEmptyCell
{
    if (!_searchHistoryEmptyCell) {
        _searchHistoryEmptyCell = (SearchHistoryCell*)[UINib viewFromNib:@"SearchHistoryCell"];
        _searchHistoryEmptyCell.enableTopLine = YES;
        _searchHistoryEmptyCell.enableButtomLine = YES;
        _searchHistoryEmptyCell.historyString = @"暂无记录";
        _searchHistoryEmptyCell.userInteractionEnabled = NO;
    }
    
    return _searchHistoryEmptyCell;
}

-(UISearchBar*)searchBar
{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(12.f,0.0f,250.0f,44.0f)];
        _searchBar.delegate = self;
        _searchBar.placeholder = [NSString stringWithFormat:@"搜索%@信息, 逗号隔开多个关键字", self.searchType==kSearchTypeBuy?@"求购":@"供货"];
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont systemFontOfSize:12.f]];

        _searchBar.tintColor = [UIColor blueColor];
        _searchBar.backgroundImage = [[UIImage alloc] init];

    }
    return _searchBar;
}

-(UIBarButtonItem*)searchButtonItem
{
    if(!_searchButtonItem){
        _searchButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self);
        [_searchButtonItem setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            // save search keyword to db
            if (self.searchBar.text.length>0) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [SearchHistory createIfNotExist:self.searchBar.text andManagedObjectContext:self.managedObjectcontent];
                });
                HttpSearchAddKeywordsRequest* request = [[HttpSearchAddKeywordsRequest alloc] initWithKeywords:@[self.searchBar.text] andType:self.searchType==kSearchTypeBuy?2:1];

                [request request]
                .then(^(id responseObj){
                    NSLog(@"%@", responseObj);
                })
                .catch(^(NSError* error){
                    
                });
            }
            SearchListViewController* searchListVC = [[SearchListViewController alloc] initWithKeyword:self.searchBar.text];
            [self.navigationController pushViewController:searchListVC animated:YES];
            self.searchBar.text = @"";
            [self.searchBar resignFirstResponder];

            return [RACSignal empty];
        }]];
    }
    return _searchButtonItem;
}

-(UIView*)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 44)];
        _searchView.backgroundColor = [UIColor clearColor];
        [_searchView addSubview:self.searchBar];
    }
    
    return _searchView;
}


-(instancetype)initWithType:(SearchType)searchType
{
    self = [super init];
    if(self){
        self.searchType = searchType;
    }
    return self;
}

-(ClearHistoryCell*)clearHistoryCell
{
    if (!_clearHistoryCell) {
        _clearHistoryCell = [[[NSBundle mainBundle]loadNibNamed:@"ClearHistoryCell" owner:nil options:nil] lastObject];
        
        @weakify(self);
        _clearHistoryCell.clearButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            if (self.searchHistory.count != 0) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^(){
                    [SearchHistory removeAll:self.managedObjectcontent];
                    
                    dispatch_async(dispatch_get_main_queue(), ^(){
                        [self.searchHistory removeAllObjects];
                        [self.tableView reloadData];
                    });
                });
            }
            
            HttpSearchRemoveKeywordsRequest* request = [[HttpSearchRemoveKeywordsRequest alloc] init];
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
            })
            .catch(^(NSError* error){
                
            });
            
            return [RACSignal empty];
        }];

    }
    
    return _clearHistoryCell;
}

-(KeyWordsCell*)keywordsCell
{
    if (!_keywordsCell) {
        _keywordsCell = [[[NSBundle mainBundle]loadNibNamed:@"KeyWordsCell" owner:nil options:nil] lastObject];
    }
    
    return _keywordsCell;
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

    
    self.navigationItem.titleView = self.searchView;
    self.navigationItem.rightBarButtonItem = self.searchButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchHistoryCell" bundle:nil] forCellReuseIdentifier:@"SearchHistoryCell"];

    
    self.searchKeywords = [@[@"苹果", @"美图", @"诺基亚", @"三星", @"小米", @"华为"] mutableCopy];
    @weakify(self);
    [self.keywordsCell setKeywords:self.searchKeywords andBlock:^(id sender){
        @strongify(self);
        UIButton* btn = (UIButton*)sender;
//        [self.searchBar resignFirstResponder];
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
    [self.tabBarController setTabBarHidden:YES animated:YES];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.searchHistory = [[SearchHistory findAll:self.managedObjectcontent] mutableCopy];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//        });
//    });
    [super viewWillAppear:animated];
    HttpSearchQueryKeywordsRequest* request = [[HttpSearchQueryKeywordsRequest alloc] initWithQueryCata:self.searchType];
    [request request]
    .then(^(id responseObj){
        HttpSearchQueryKeywordsResponse* response = (HttpSearchQueryKeywordsResponse*)request.response;
        if (response.ok) {
            self.searchHistory = [response.keywords mutableCopy];
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
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
            if (self.searchHistory.count == 0) {
                cell = self.searchHistoryEmptyCell;
            }
            else {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryCell"];
                SearchHistoryCell* sc = (SearchHistoryCell*)cell;
//                SearchHistory* searchHistory = (SearchHistory*)self.searchHistory[indexPath.row];
//                sc.historyString = searchHistory.keyword;
                sc.historyString = self.searchHistory[indexPath.row];
                if (indexPath.row != self.searchHistory.count-1) {
                    sc.enableButtomLine = NO;
                }
                else{
                    sc.enableButtomLine = YES;
                }
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
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
            if (rowNum == 0) {
                rowNum = 1; // we should display no history cell
            }
            break;
            
        case kSectionClearSearchHistory:
            rowNum = 1;
            break;
            
        default:
            break;
    }
    
    return rowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case kSectionKeywords:
            return 44.f;
            break;
        case kSectionSearchHistory:
        {
//            if (self.searchHistory.count > 0) {
//                return 44.f;
//            }
//            else {
//                return 0;
//            }
            return 44.f;
        }
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
            if (self.searchHistory.count == 0) {
                break;
            }
            else {
                UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                SearchListViewController* vc = [[SearchListViewController alloc] initWithKeyword:cell.textLabel.text];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma -- searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // save search keyword to db
    if (self.searchBar.text.length>0) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [SearchHistory createIfNotExist:self.searchBar.text andManagedObjectContext:self.managedObjectcontent];
        });
        HttpSearchAddKeywordsRequest* request = [[HttpSearchAddKeywordsRequest alloc] initWithKeywords:@[self.searchBar.text] andType:self.searchType==kSearchTypeBuy?2:1];
        [request request]
        .then(^(id responseObj){
            NSLog(@"%@", responseObj);
        })
        .catch(^(NSError* error){
            
        });
    }
    
    SearchListViewController* searchListVC = [[SearchListViewController alloc] initWithKeyword:self.searchBar.text];
    [self.navigationController pushViewController:searchListVC animated:YES];
    
    self.searchBar.text = @"";
}

@end
