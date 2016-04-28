//
//  MineViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "AvataCell.h"
#import "SegmentedCell.h"
#import "OrderStatusCell.h"
#import "MyInfoCell.h"
#import "ContactCell.h"
#import "CustomSegment.h"
#import "MineSellProductViewController.h"
#import "SupplyViewController.h"
#import "AccountViewController.h"




@interface MineViewController()

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) AvataCell* avataCell;
@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) OrderStatusCell* orderStatusCell;
@property (nonatomic, strong) ContactCell* contactCell;


@end

@implementation MineViewController

+(NSArray*)infoNames
{
    return @[
             @"我的账户",
             @"我的供货",
             @"我的求购",
             @"我的抵押",
             @"我的站内信息",
             @"我的收货地址",
             @"我的自提人"
             ];
}
+(NSArray*)infoIcons
{
    return @[
             @"account",
             @"gonghuo",
             @"qiugou",
             @"diya",
             @"info",
             @"addr",
             @"ziti"
             ];
}


-(AvataCell*)avataCell
{
    if(!_avataCell){
        _avataCell = [[[NSBundle mainBundle]loadNibNamed:@"AvataCell" owner:nil options:nil] firstObject];
        
        _avataCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _avataCell;
}

-(OrderStatusCell*)orderStatusCell
{
    if(!_orderStatusCell){
        _orderStatusCell = [[[NSBundle mainBundle]loadNibNamed:@"OrderStatusCell" owner:nil options:nil] firstObject];
        _orderStatusCell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        @weakify(self);
        _orderStatusCell.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            
            @strongify(self);
//            LoginViewController* loginVC = [[LoginViewController alloc] init];
            
            MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
            [self.navigationController pushViewController:mineSellProductVC animated:YES];
            return [RACSignal empty];
        }];
    }
    
    return _orderStatusCell;
}

-(ContactCell*)contactCell
{
    if(!_contactCell){
        _contactCell = [[[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:nil options:nil] firstObject];
        _contactCell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return _contactCell;
}


-(SegmentedCell*)segmentCell
{
    if(!_segmentCell){
        _segmentCell = [[SegmentedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SegmentedCell"];
        _segmentCell.buttonStyle = kButtonStyleV;
        [_segmentCell setTitles:@[@"我买的货", @"我卖的货"] andIcons:@[@"buy_product", @"sell_product"]];
        _segmentCell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return _segmentCell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的189疯狂买卖王";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    //[self.avataCell backgroundColorFrom:RGBCOLOR(230, 0, 0) To:RGBCOLOR(255, 255, 255)];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    
//}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:NO animated:YES];
    
}

#pragma -- mark tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionMax;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case kSectionOverview:
        {
            switch (row) {
                case 0:
                    return 110;
                case 1:
                    return [SegmentedCell cellHight];
                case 2:
                    return 32;
                    
                default:
                    break;
            }
        }
            break;
        case kSectionInfo:
        {
            return 34.f;
        }
            break;
        case kSectionContact:
        {
            return 40.f;
        }
            break;
            
        default:
            break;
    }
    
    
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case kSectionOverview:
        {
            switch (row) {
                case 0:
                    return self.avataCell;
                case 1:
                    return self.segmentCell;
                case 2:
                    return self.orderStatusCell;
                    
                default:
                    break;
            }
        }
            break;
        case kSectionInfo:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoCell"];
            if(!cell) {
                cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyInfoCell"];
            }
            NSArray* infoNames = [[self class] infoNames];
            NSArray* infoIcons = [[self class] infoIcons];
            
            cell.textLabel.text = infoNames[row];
            cell.imageView.image = [UIImage imageNamed:infoIcons[row]];
            
        }
            break;
        case kSectionContact:
        {
            return self.contactCell;
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kSectionOverview:
            return 3;
        case kSectionInfo:
            return [[self class] infoNames].count;
        case kSectionContact:
            return 1;
        default:
            break;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case kSectionInfo:
        {
            if (indexPath.row == 1) {
                SupplyViewController* supplyVC = [[SupplyViewController alloc] init];
                [self.navigationController pushViewController:supplyVC animated:YES];
                
                return;
            }
            else if(indexPath.row == 0){
                AccountViewController* accountVC = [[AccountViewController alloc] init];
                [self.navigationController pushViewController:accountVC animated:YES];
                
                return;
            }
            
            MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
            [self.navigationController pushViewController:mineSellProductVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kSectionOverview) {
        return 0.f;
    }

    return 12.f;
}



@end
