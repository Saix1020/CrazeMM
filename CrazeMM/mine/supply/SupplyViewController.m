//
//  SupplyViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyViewController.h"
#import "SegmentedCell.h"
#import "SupplyBottomOffView.h"
#import "SupplyListCell.h"
#import <objc/runtime.h>

@interface SupplyViewController ()
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) SupplyBottomOffView* bottomView;
@property (nonatomic) SupplyListCellStyle cellStyle;

@end



@implementation SupplyViewController


-(SegmentedCell*)segmentCell
{
    if (!_segmentCell) {
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleB;
        _segmentCell.height = @(44.0f);
        [_segmentCell setTitles:@[@"正常", @"下架", @"成交"]];
        _segmentCell.segment.delegate = self;

    }
    
    return _segmentCell;
}

-(SupplyBottomOffView*)bottomView
{
    if(!_bottomView){
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"PayBottomView" owner:nil options:nil] firstObject];
        
        object_setClass(_bottomView, [SupplyBottomOffView class]);
        [_bottomView myInit];
        [self.view addSubview:_bottomView];
        _bottomView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
//            MinePayViewController* payVC = [MinePayViewController new];
//            [self.navigationController pushViewController:payVC animated:YES];
            return [RACSignal empty];
        }];
    }
    
    return _bottomView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的供货";
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SupplyListCell" bundle:nil] forCellReuseIdentifier:@"SupplyListCell"];
    
    
    self.tableView.tableHeaderView = self.segmentCell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.bottomView.frame = CGRectMake(0, self.view.height-[PayBottomView cellHeight], self.view.bounds.size.width, [PayBottomView cellHeight]);
    //[self.view bringSubviewToFront:self.bottomView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.row%2 == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UselessHeadCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UselessHeadCell"];
            cell.backgroundColor = RGBCOLOR(240, 240, 240);
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SupplyListCell"];
        ((SupplyListCell*)cell).style = self.cellStyle;

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row %2 == 0) {
        return 12.f;
    }
    
    else {
        if (self.segmentCell.segment.currentIndex != 2) {
            return [SupplyListCell cellHeight];

        }
        else {
            return [SupplyListCell cellHeight] - 30;
        }

    }
}


- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    if (segment.prevIndex == index) {
        return;
    }
    
    if (index == 0) {
        self.cellStyle = kNomalStyle;
        [self.bottomView.confirmButton setTitle:@"下架" forState:UIControlStateNormal];
    }
    else if(index==1){
        self.cellStyle = kOffShelfStyle;
        [self.bottomView.confirmButton setTitle:@"上架" forState:UIControlStateNormal];

    }
    else {
        self.cellStyle = kDealStyle;
        [self.bottomView.confirmButton setTitle:@"批量删除" forState:UIControlStateNormal];

    }
    
    [self.tableView reloadData];
    
//    UIButton* button = segment.buttons[index];
//    UIButton* prevButton = segment.buttons[segment.prevIndex];
//    if (segment.prevIndex != index) {
//        [prevButton setTitleColor:[UIColor UIColorFromRGB:0x959595] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        
//    }
//    else {
//        
//    }
}


@end
