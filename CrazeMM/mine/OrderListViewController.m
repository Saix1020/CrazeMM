//
//  MineSellProductViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderListViewController.h"
#import "WaitForPayCell.h"
#import "SegmentedCell.h"
#import "PayBottomView.h"
#import "MinePayViewController.h"
#import "WaitForDeliverCell.h"
#import "HttpOrder.h"



@interface OrderListViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) SegmentedCell* segmentCell;
@property (nonatomic, strong) PayBottomView* payBottomView;
@property (nonatomic) NSInteger currentSegmentIndex;
@property (nonatomic, strong) NSMutableArray* dataSource;

@property (nonatomic) MMOrderType orderType;
@property (nonatomic) MMOrderSubType subType;
@property (nonatomic) MMOrderState orderState;

@property (nonatomic, readonly) MMOrderListStyle orderListStyle;

@property (nonatomic) NSInteger orderListPageNumber;
@property (nonatomic) NSInteger orderListTotalPage;

@property (nonatomic) CGFloat totalPrice;

@end

@implementation OrderListViewController

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style;
    style.orderType = self.orderType;
    style.orderSubType = self.subType;
    style.orderState = self.orderState;
    
    return style;
}

-(NSArray*)getSegmentTitels
{
    switch (self.orderType) {
        case kOrderTypeBuy:
        {
            switch (self.subType) {
                case kOrderSubTypePay:
                    return @[@"待支付", @"超时", @"已支付"];
                    break;
                case kOrderSubTypeReceived:
                    return @[@"待签收", @"已签收"];
                    break;
                default:
                    break;
            }
        }
            break;
        case kOrderTypeSupply:
        {
            switch (self.subType) {
                case kOrderSubTypeSend:
                    return @[@"待发货", @"已发货"];
                    
                    break;
                case kOrderSubTypeConfirmed:
                    return @[@"待确认", @"已确认"];
                    
                    break;
                    
                default:
                    break;
            }
        }
        default:
            
            break;
    }
    
    return @[@"待支付", @"超时", @"已支付"];
}

-(PayBottomView*)payBottomView
{
    if(!_payBottomView){
        _payBottomView = [[[NSBundle mainBundle]loadNibNamed:@"PayBottomView" owner:nil options:nil] firstObject];
;
        [self.view addSubview:_payBottomView];
        [_payBottomView.confirmButton addTarget:self action:@selector(handleButtomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
//        _payBottomView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
////            MinePayViewController* payVC = [MinePayViewController new];
////            [self.navigationController pushViewController:payVC animated:YES];
//            return [RACSignal empty];
//        }];
        
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
//        [_segmentCell setTitles:[self getSegmentTitels]];
        _segmentCell.segment.delegate = self;
    }
    
    return _segmentCell;
}

-(instancetype)initWithOrderType:(MMOrderType)orderType andSubType:(MMOrderSubType)subType
{
    self = [super init];
    if (self) {
        self.orderType = orderType;
        self.subType = subType;
        if (orderType == kOrderTypeBuy) {
            if (subType == kOrderSubTypePay) {
                self.orderState = TOBEPAID;
            }
            else if(subType == kOrderSubTypeReceived)
            {
                self.orderState = TOBERECEIVED;
            }
        }
        else {
            if (subType == kOrderSubTypeSend) {
                self.orderState = TOBESENT;
            }
            else if(subType == kOrderSubTypeConfirmed)
            {
                self.orderState = TOBECONFIRMED;
            }
        }
    }
    return self;
}

-(void)handleButtomButtonClicked:(UIButton*)send
{
    NSInteger segmentIndex = self.segmentCell.segment.currentIndex;
    
    if (self.orderType == kOrderTypeBuy) {
        switch (self.subType ) {
            case kOrderSubTypePay:
            {
                switch (segmentIndex) {
                    case 0:
                        NSLog(@"我买的货->待付款->付款");
                        break;
                    case 1:
                        NSLog(@"我买的货->待付款->超时");
                        break;
                    case 2:
                        NSLog(@"我买的货->待付款->已支付");
                        break;
                    default:
                        break;
                }
            }
                break;
            case kOrderSubTypeReceived:
                switch (segmentIndex) {
                    case 0:
                        NSLog(@"我买的货->待签收->签收");
                        break;
                    case 1:
                        NSLog(@"我买的货->待签收->已签收");
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
    else if(self.orderType == kOrderTypeSupply){
        switch (self.subType ) {
            case kOrderSubTypeSend:
                switch (segmentIndex) {
                    case 0:
                        NSLog(@"我卖的货->待发货->发货");
                        break;
                    case 1:
                        NSLog(@"我卖的货->待发货->已发货");
                        break;
                    default:
                        break;
                }
                break;
            case kOrderSubTypeConfirmed:
                switch (segmentIndex) {
                    case 0:
                        NSLog(@"我卖的货->待确认->确认");
                        break;
                    case 1:
                        NSLog(@"我卖的货->待确认->已确认");
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.orderType==kOrderTypeBuy? @"我买的货" : @"我卖的货";
    
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
    self.dataSource = [[NSMutableArray alloc] init];
    
//    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)]];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
    [self.segmentCell setTitles:[self getSegmentTitels]];
    [self setOrderStyleWithSegmentIndex:0];
    [self getOrderList];
}

-(void)refreshTotalPriceLabel
{
    if (!self.payBottomView.totalPriceLabel.hidden) {
        self.totalPrice = 0.f;
        for (NSInteger index = 0; index<self.dataSource.count; ++index) {
            OrderDetailDTO* dto = self.dataSource[index];
            if (dto.selected) {
                self.totalPrice += dto.price;
            }
        }
        
        self.payBottomView.totalPrice = self.totalPrice;
    }
}

-(void)getOrderList
{
    HttpOrderRequest* orderRequest = [[HttpOrderRequest alloc]initWithOrderListType:self.orderListStyle andPage:1];
    [orderRequest request]
    .then(^(id responseObject){
//        NSLog(@"%@", orderRequest.response);
        NSLog(@"%@", responseObject);
        HttpOrderResponse* response = (HttpOrderResponse*)orderRequest.response;
        if (response.ok) {
            [self.dataSource addObjectsFromArray:response.orderDetailDTOs];
            [self.tableView reloadData];
            [self refreshTotalPriceLabel];
        }
    });
}

-(void)setOrderStyleWithSegmentIndex:(NSUInteger)index
{
    MMOrderListStyle style;
    self.currentSegmentIndex = index;
    style.orderType = self.orderType;
    style.orderSubType = self.subType;
    
    if (self.orderType == kOrderTypeBuy) {
        if (self.subType == kOrderSubTypePay) {
            switch (index) {
                case 0: // 待支付
                    style.orderState = TOBEPAID;
                    break;
                case 1: // 支付超时
                    style.orderState = PAYTIMEOUT;
                    break;
                case 2: // 已支付
                    style.orderState = PAYCOMPLETE;
                    break;
                default:
                    break;
            }
        }
        else if(self.subType == kOrderSubTypeReceived){
            switch (index) {
                case 0: //待签收
                    style.orderState = TOBERECEIVED;
                    break;
                case 1: //已签收
                    style.orderState = RECEIVECOMPLETE;
                    break;
                default:
                    break;
            }
        }
    }
    else if (self.orderType == kOrderTypeSupply){
        if (self.subType == kOrderSubTypeSend) {
            switch (index) {
                case 0: // 待发货
                    style.orderState = TOBESENT;
                    break;
                case 1: // 已发货
                    style.orderState = SENTCOMPLETE;
                    break;
                default:
                    break;
            }
        }
        else if(self.subType == kOrderSubTypeConfirmed){
            switch (index) {
                case 0: //待确认
                    style.orderState = TOBECONFIRMED;
                    break;
                case 1: //已确认
                    style.orderState = CONFIRMEDCOMPLETE;
                    break;
                default:
                    break;
            }
        }
    }
    self.orderState = style.orderState;
    self.payBottomView.orderStyle = style;
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
    OrderDetailDTO* dto = (OrderDetailDTO*)self.dataSource[indexPath.row];
    
    if ((self.currentSegmentIndex == 1 &&
         (self.orderType==kOrderTypeBuy && self.subType == kOrderSubTypePay))
        || self.currentSegmentIndex == 0) {
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
        
        cell.orderDetailDTO = dto;
        //wdto.selected = YES;
        
        cell.selectedCheckBox.tag = 10000 + indexPath.row;
        cell.selectedCheckBox.on = cell.orderDetailDTO.selected;
        
        return cell;
    }
    else {
        WaitForDeliverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaitForDeliverCell"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WaitForPayCell cellHeight]; //WaitForDeliverCell has the same height with WaitForPayCell
}


#pragma -- mark custom segment delegate

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    if (segment.prevIndex == index) {
        return;
    }
    [self setOrderStyleWithSegmentIndex:index];
    [self.dataSource removeAllObjects];
//    [self refreshTotalPriceLabel];
    [self.tableView reloadData];
    [self getOrderList];
}

#pragma -- mark BEMCheckBox Delegate
-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if (checkBox != self.payBottomView.selectAllCheckBox) {
        NSInteger index = checkBox.tag - 10000;
        OrderDetailDTO* dto = self.dataSource[index];
        dto.selected = checkBox.on;

        NSArray* onArray = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.selected != NO"]];
        if (onArray.count == self.dataSource.count) {
            self.payBottomView.selectAllCheckBox.on = YES;
        }
        else {
            self.payBottomView.selectAllCheckBox.on = NO;
        }
    }
    else {
        for (NSInteger index = 0; index<self.dataSource.count; ++index) {
            OrderDetailDTO* dto = self.dataSource[index];
            dto.selected = checkBox.on;
        }
        [self.tableView reloadData];
    }
    
    [self refreshTotalPriceLabel];
}



@end
