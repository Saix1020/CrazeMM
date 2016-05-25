//
//  CommonOrderListView.m
//  CrazeMM
//
//  Created by saix on 16/5/8.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonOrderListViewController.h"
#import "SegmentedCell.h"
#import "CommonBottomView.h"
#import "MJRefresh.h"
#import "UIAlertView+AnyPromise.h"

#define kSegmentCellHeight (40.f+self.contentHeightOffset)
#define kTableViewInsetTopWithoutSegment (kSegmentCellHeight+64)

@interface CommonOrderListViewController()

@property (nonatomic) CGPoint ptLastOffset;
@property (nonatomic) BOOL isRefreshing;

@end

@implementation CommonOrderListViewController

@synthesize segmentCell = _segmentCell;
@synthesize bottomView = _bottomView;

-(SegmentedCell*)segmentCell
{
    if (!_segmentCell) {
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleB;
        _segmentCell.height = @(40.0f);
        [_segmentCell setTitles:@[@"Segment1", @"Segment2", @"Segment3"]];
        _segmentCell.segment.delegate = self;
        
        [self.view addSubview:_segmentCell];
        
    }
    
    return _segmentCell;
}

-(CommonBottomView*)bottomView
{
    if(!_bottomView){
        _bottomView = (CommonBottomView*)[UINib viewFromNibByClass:[CommonBottomView class]];
        [self.view addSubview:_bottomView];

        [_bottomView.confirmButton addTarget:self action:@selector(bottomViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _bottomView.selectAllCheckBox.delegate = self;
    }
    
    return _bottomView;
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor light_Gray_Color];
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.segmentCell.frame = CGRectMake(0, 64.f, [UIScreen mainScreen].bounds.size.width, kSegmentCellHeight);
    self.tableView.frame = self.view.bounds;
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kSegmentCellHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kSegmentCellHeight, 0, 0, 0);
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        if (self.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.isRefreshing = YES;
        [self handleHeaderRefresh]
        .finally(^(){
            self.isRefreshing = NO;
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        if (self.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        self.isRefreshing = YES;
        [self handleFooterRefresh]
        .finally(^(){
            self.isRefreshing = NO;
            [self.tableView.mj_footer endRefreshing];
        });

    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
    self.isRefreshing = NO;
}

-(void)setIsRefreshing:(BOOL)isRefreshing
{
    _isRefreshing = isRefreshing;
    
    for (UIButton* button in self.segmentCell.segment.buttons) {
        button.enabled = !isRefreshing;
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.bottomView.frame = CGRectMake(0, self.view.height-[CommonBottomView cellHeight], self.view.bounds.size.width, [CommonBottomView cellHeight]);
}

-(AnyPromise*)handleHeaderRefresh
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    return [alert promise];
    
}

-(AnyPromise*)handleFooterRefresh
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    return [alert promise];

}

#pragma -- mark custom segment delegate

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma -- mark BEMCheckBox Delegate
-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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

#pragma -- UITableViewCell delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = self.dataSource.count;
    return num*2 + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count*2){
        return [CommonBottomView cellHeight];
    }
    else if(indexPath.row %2 ==0){
        return 12.f;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (indexPath.row%2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UselessHeadCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UselessHeadCell"];
            cell.backgroundColor = RGBCOLOR(240, 240, 240);
        }
    }
    else if (indexPath.row == self.dataSource.count*2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LastUselessCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastUselessCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
    }
    
    return cell;
}

@end
