//
//  MineSellProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSellProductViewController.h"
#import "WaitForPayCell.h"
#import "SegmentedCell.h"
#import "PayBottomView.h"
#import "MinePayViewController.h"
#import "WaitForDeliverCell.h"


@interface MineSellProductViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) PayBottomView* payBottomView;
@property (nonatomic) NSInteger currentSegmentIndex;
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation MineSellProductViewController

-(PayBottomView*)payBottomView
{
    if(!_payBottomView){
        _payBottomView = [[[NSBundle mainBundle]loadNibNamed:@"PayBottomView" owner:nil options:nil] firstObject];
;
        [self.view addSubview:_payBottomView];
        _payBottomView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            MinePayViewController* payVC = [MinePayViewController new];
            [self.navigationController pushViewController:payVC animated:YES];
            return [RACSignal empty];
        }];
        
        _payBottomView.selectAllCheckBox.delegate = self;
    }
    
    return _payBottomView;
}

-(SegmentedCell*)segmentCell
{
    if(!_segmentCell){
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleB;
        _segmentCell.height = @(44.0f);
        [_segmentCell setTitles:@[@"待支付", @"支付超时", @"代发货"]];
        _segmentCell.segment.delegate = self;
    }
    
    return _segmentCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我买的货";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaitForPayCell" bundle:nil] forCellReuseIdentifier:@"WaitForPayCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WaitForDeliverCell" bundle:nil] forCellReuseIdentifier:@"WaitForDeliverCell"];
    
    
    self.tableView.tableHeaderView = self.segmentCell;

    self.currentSegmentIndex = 0;
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)]];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.payBottomView.frame = CGRectMake(0, self.view.height-[PayBottomView cellHeight], self.view.bounds.size.width, [PayBottomView cellHeight]);
    //[self.view bringSubviewToFront:self.payBottomView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIButton* btn;
    btn = self.segmentCell.segment.buttons[1];
    btn.imageView.hidden = YES;
    btn = self.segmentCell.segment.buttons[2];
    btn.imageView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentSegmentIndex == 1 || self.currentSegmentIndex == 0) {
        WaitForPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitForPayCell"];
        if (self.currentSegmentIndex == 1) {
            cell.reactiveButton.hidden = NO;
        }
        else {
            cell.reactiveButton.hidden = YES;
        }
        
        if (!cell.selectedCheckBox.delegate) {
            cell.selectedCheckBox.delegate = self;
        }
        
        cell.selectedCheckBox.on = [self.dataSource[indexPath.row] boolValue];
        cell.selectedCheckBox.tag = 1000 + indexPath.row;
        
        return cell;
    }
    else {
        WaitForDeliverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitForDeliverCell"];
        return cell;
    }
    
    
//    if (self.currentSegmentIndex == 1) {
//        cell.reactiveButton.hidden = NO;
//    }
//    else if(self.currentSegmentIndex == 2){
//    }
//    else {
//        cell.reactiveButton.hidden = YES;
//    }
//    
//    if (!cell.selectedCheckBox.delegate) {
//        cell.selectedCheckBox.delegate = self;
//    }
//    
//    cell.selectedCheckBox.on = [self.dataSource[indexPath.row] boolValue];
//    cell.selectedCheckBox.tag = 1000 + indexPath.row;
//    
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WaitForPayCell cellHeight];
}


#pragma -- mark custom segment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    if (segment.prevIndex == index) {
        return;
    }
    
    self.currentSegmentIndex = index;
    
    switch (index) {
        case 0: // 待支付
            self.payBottomView.hidden = NO;
            self.payBottomView.totalPriceLabel.hidden = NO;

            [self.payBottomView.confirmButton setTitle:@"付款" forState:UIControlStateNormal];
            break;
        case 1: // 支付超时
            self.payBottomView.hidden = NO;
            self.payBottomView.totalPriceLabel.hidden = YES;
            [self.payBottomView.confirmButton setTitle:@"批量删除" forState:UIControlStateNormal];
            break;
        case 2: // 代发货
            self.payBottomView.hidden = YES;

            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma -- mark BEMCheckBox Delegate
-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if (checkBox != self.payBottomView.selectAllCheckBox) {
        NSInteger index = checkBox.tag - 1000;
        self.dataSource[index] = @(checkBox.on);

        
        NSArray* onArray = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != NO"]];
        if (onArray.count == self.dataSource.count) {
            self.payBottomView.selectAllCheckBox.on = YES;
        }
        else {
            self.payBottomView.selectAllCheckBox.on = NO;
        }
    }
    else {
        for (NSInteger index = 0; index<self.dataSource.count; ++index) {
            self.dataSource[index] = @(checkBox.on);
        }
        [self.tableView reloadData];
    }
    
}



@end
