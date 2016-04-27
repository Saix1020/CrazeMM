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

@interface MineSellProductViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) PayBottomView* payBottomView;
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
    }
    
    return _payBottomView;
}

-(SegmentedCell*)segmentCell
{
    if(!_segmentCell){
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleB;
        _segmentCell.height = @(44.0f);
        [_segmentCell setTitles:@[@"待支付", @"支付超时", @"代发货"] andIcons:@[@"arrow_up", @"arrow_up", @"arrow_up"]];
        //        ((UIButton*)(_segmentCell.segment.buttons[1])).imageView.hidden = ((UIButton*)(_segmentCell.segment.buttons[2])).imageView.hidden = YES;
        
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
    
    
    self.tableView.tableHeaderView = self.segmentCell;


}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.payBottomView.frame = CGRectMake(0, self.view.height-[PayBottomView cellHeight], self.view.bounds.size.width, [PayBottomView cellHeight]);
    [self.view bringSubviewToFront:self.payBottomView];
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

    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitForPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitForPayCell"];
    return cell;
}



//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WaitForPayCell cellHeight];
}


#pragma -- mark custom segment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    
    UIButton* button = segment.buttons[index];
    UIButton* prevButton = segment.buttons[segment.prevIndex];
    if (segment.prevIndex != index) {
        button.imageView.transform = CGAffineTransformMakeRotation(0);
        button.imageView.hidden = NO;
        prevButton.imageView.hidden = YES;
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
