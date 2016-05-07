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
#import "OrderListViewController.h"
#import "SupplyViewController.h"
#import "AccountViewController.h"
#import "LoginViewController.h"

#import "NoLoginHeadCell.h"
#import "HttpOrderSummary.h"
#import "HttpLogout.h"



@interface MineViewController()

@property (nonatomic, strong) AvataCell* avataCell;
@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) OrderStatusCell* orderStatusCell;
@property (nonatomic, strong) ContactCell* contactCell;
@property (nonatomic, strong) NoLoginHeadCell* noLoginCell;
@property (nonatomic, strong) UITableViewCell* logoutCell;
@property (nonatomic, readonly) BOOL isLogined;
@property (nonatomic, strong) HttpOrderSummaryResponse* orderSummary;
@end

@implementation MineViewController


+(NSArray*)infoNames
{
    if ([UserCenter defaultCenter].isLogined) {
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
    else {
        return @[
                 @"我的账户",
                 @"我的供货",
                 @"我的求购",
                 @"我的抵押",
                 ];
    }
    
}
+(NSArray*)infoIcons
{
    if ([UserCenter defaultCenter].isLogined) {
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
    else {
        return @[
                 @"account",
                 @"gonghuo",
                 @"qiugou",
                 @"diya",
                 ];
    }
    
}

-(UITableViewCell*)logoutCell
{
    if (!_logoutCell) {
        _logoutCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logoutCell"];
        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelButton setTitle:@"退出" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor redColor];
        cancelButton.layer.cornerRadius = 4.f;
        cancelButton.clipsToBounds = YES;
        cancelButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        
        [cancelButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];

        [_logoutCell addSubview:cancelButton];

    }
    
    return _logoutCell;
}

-(NoLoginHeadCell*)noLoginCell
{
    if(!_noLoginCell){
        _noLoginCell = [[[NSBundle mainBundle]loadNibNamed:@"NoLoginHeadCell" owner:nil options:nil] firstObject];
        _noLoginCell.infoLabel.text = @"欢迎使用189疯狂买卖王";
        [_noLoginCell.loginButton setTitle:@"请点击登录" forState:UIControlStateNormal];
        
        @weakify(self);
        _noLoginCell.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            
            @strongify(self);
            LoginViewController* loginVC = [[LoginViewController alloc] init];
            
            [self.navigationController pushViewController:loginVC animated:YES];
            return [RACSignal empty];
        }];
        
        _noLoginCell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return _noLoginCell;
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
        _orderStatusCell.delegate = self;
        
//        @weakify(self);
//        _orderStatusCell.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
//            
//            @strongify(self);
////            LoginViewController* loginVC = [[LoginViewController alloc] init];
//            
//            MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
//            [self.navigationController pushViewController:mineSellProductVC animated:YES];
//            return [RACSignal empty];
//        }];
    }
    
    return _orderStatusCell;
}

-(ContactCell*)contactCell
{
    if(!_contactCell){
        _contactCell = [[[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:nil options:nil] firstObject];
//        _contactCell.selectionStyle = UITableViewCellSelectionStyleNone;

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
        _segmentCell.segment.delegate = self;

    }
    
    return _segmentCell;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
//        if (![UserCenter defaultCenter].isLogined) {
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(logoutSuccessed:)
//                                                         name:kLogutSuccessBroadCast object:nil];
//        }
        
    }
    return self;
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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];

    
}

-(void)logout
{
    HttpLogoutRequest* logoutRequest = [[HttpLogoutRequest alloc] init];
    [self showProgressIndicatorWithTitle:@"正在注销..."];
    [logoutRequest request]
    .then(^(id responseObject){
        if (logoutRequest.response.ok) {
            [[UserCenter defaultCenter] resetKeychainItem];
            [[UserCenter defaultCenter] setLogouted];
            
            //navigate to login page
            LoginViewController* loginVC = [[LoginViewController alloc] init];
            //[self presentViewController:loginVC animated:YES completion:nil];
            [self.navigationController pushViewController:loginVC animated:YES];

            
        }
        else {
            [self showAlertViewWithMessage:@"注销失败!"];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        [self dismissProgressIndicator];
    });
    
    //[self.tableView reloadData];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.orderStatusCell.titleArray = [self titleArray];
    
    HttpOrderSummaryRequest* orderSummaryRequest = [[HttpOrderSummaryRequest alloc] init];
    [orderSummaryRequest request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        self.orderSummary = (HttpOrderSummaryResponse*)orderSummaryRequest.response;
        if (self.orderSummary.ok) {
            self.orderStatusCell.titleArray = [self titleArray];
        }
    })
    .catch(^(NSError* error){
        if ([error needLogin]) {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }
        else {
            [self showAlertViewWithMessage:error.localizedDescription];
 
        }
    });
}

-(NSArray*)titleArray
{
    if (self.orderSummary) {
        if(self.segmentCell.segment.currentIndex == 0){
            return @[
                     @{
                         @"name" : @"待付款",
                         @"number" : @(self.orderSummary.tobepaid)
                         },
                     @{
                         @"name" : @"待签收",
                         @"number" : @(self.orderSummary.tobereceived)
                         },
                     @{
                         @"name" : @"其他",
                         @"number" : @(-1)
                         },
                     
                     ];
        }
        else {
            return @[
                     @{
                         @"name" : @"待发货",
                         @"number" : @(self.orderSummary.tobesent)
                         },
                     @{
                         @"name" : @"待确认",
                         @"number" : @(self.orderSummary.tobeconfirmed)
                         },
                     @{
                         @"name" : @"其他",
                         @"number" : @(-1)
                         },
                     
                     ];
        }
    }
    else{
        if(self.segmentCell.segment.currentIndex == 0){
            return @[
                     @{
                         @"name" : @"待付款",
                         @"number" : @(0)
                         },
                     @{
                         @"name" : @"待签收",
                         @"number" : @(0)
                         },
                     @{
                         @"name" : @"其他",
                         @"number" : @(-1)
                         },
                     
                     ];
        }
        else {
            return @[
                     @{
                         @"name" : @"待发货",
                         @"number" : @(0)
                         },
                     @{
                         @"name" : @"待确认",
                         @"number" : @(0)
                         },
                     @{
                         @"name" : @"其他",
                         @"number" : @(-1)
                         },
                     
                     ];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:NO animated:YES];
    
}

#pragma -- mark tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (![UserCenter defaultCenter].isLogined) {
        return kSectionMax-1;
    }
    
    return kSectionMax;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (![UserCenter defaultCenter].isLogined) {
        if (section == kSectionInfo) {
            return 44.f;
        }
    }
    
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
        case kSectionLogout:
        {
            return 40.f;
        }
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
    
    if (![UserCenter defaultCenter].isLogined) {
        if (indexPath.section == kSectionOverview && row==0) {
            return self.noLoginCell;
        }
    }

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
        case kSectionLogout:
        {
            return self.logoutCell;
        }
            break;
        default:
            break;
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([UserCenter defaultCenter].isLogined) {
        switch (section) {
            case kSectionOverview:
                return 3;
            case kSectionInfo:
                return [[self class] infoNames].count;
            case kSectionContact:
                return 1;
            case kSectionLogout:
                return 1;
            default:
                break;
        }

    }
    else {
        switch (section) {
            case kSectionOverview:
                return 2;
            case kSectionInfo:
                return [[self class] infoNames].count;
            case kSectionContact:
                return 1;
            case kSectionLogout:
                return 0;
            default:
                break;
        }
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![UserCenter defaultCenter].isLogined) {
        switch (indexPath.section) {
            case kSectionInfo:
            {
//                MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
//                [self.navigationController pushViewController:mineSellProductVC animated:YES];
                return;
            }
                break;
                
            default:
                break;
        }
    }
    
    
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
//            
//            MineSellProductViewController* mineSellProductVC = [[MineSellProductViewController alloc] init];
//            [self.navigationController pushViewController:mineSellProductVC animated:YES];
            
            
        }
            break;
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kSectionOverview) {
        return 0.f;
    }

    return 12.f;
}

#pragma  -- mark custom segment delegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    self.orderStatusCell.titleArray = [self titleArray];
}

#pragma -- mark order status cell delegate
-(void)orderStatusCellButtonClicked:(UIButton *)button andButtonIndex:(NSUInteger)index
{
    MMOrderType orderType;
    MMOrderSubType orderSubType;
    

    if (self.segmentCell.segment.currentIndex == 0) {
        orderType = kOrderTypeBuy;
        
        switch (index) {
            case 1:
                orderSubType = kOrderSubTypePay;
                break;
            case 2:
                orderSubType = kOrderSubTypeReceived;
                break;
            default:
                orderSubType = kOrderSubTypePay;
                break;
        }
    }
    else {
        orderType = kOrderTypeSupply;
        switch (index) {
            case 1:
                orderSubType = kOrderSubTypeSend;
                break;
            case 2:
                orderSubType = kOrderSubTypeConfirmed;
                break;
            default:
                orderSubType = kOrderSubTypeSend;
                break;
        }

    }
    
    OrderListViewController* orderListVC = [[OrderListViewController alloc] initWithOrderType:orderType andSubType:orderSubType];
    [self.navigationController pushViewController:orderListVC animated:YES];
}

@end
