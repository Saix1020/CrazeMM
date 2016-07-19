//
//  OrderDetailViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDefine.h"
#import "OrderListNoCheckBoxCell.h"
#import "OrderDetailHeadCell.h"
#import "OrderDetailAddrCell.h"
#import "OrderDetailStatusCell.h"
#import "OrderLogsCell.h"
#import "OrderStatusDTO.h"
#import "HttpOrderStatus.h"
#import "PayViewController.h"
#import "HttpOrderRemove.h"
#import "HttpOrderCancel.h"
#import "HttpOrderOperation.h"
#import "OrderSendViewController.h"
#import "OrderListViewController.h"


typedef NS_ENUM(NSInteger, OrderDetailRow){
    kOrderDetailHeadRow = 1,
    kOrderDetailAddrRow = 3,
    kOrderDetailContentRow = 5,
    kOrderDetailStatusRow = 7,
    kOrderDetailRowMax
};

@interface OrderDetailViewController()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic) MMOrderListStyle style;
@property (nonatomic, strong) OrderDetailDTO* orderDto;
@property (nonatomic, strong) OrderStatusDTO* orderStatusDto;


@property (nonatomic, strong) OrderDetailHeadCell* headCell;
@property (nonatomic, strong) OrderDetailAddrCell* addrCell;
@property (nonatomic, strong) OrderListNoCheckBoxCell* contentCell;
@property (nonatomic, strong) OrderDetailStatusCell* statusCell;
@property (nonatomic, strong) OrderLogsCell* logsCell;

@end

@implementation OrderDetailViewController

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f)];
        [self.view addSubview:_bottomView];
        [_bottomView addSubview:self.confirmButton];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        // we hide it now
        _bottomView.hidden = YES;
    }
    
    return _bottomView;
}
-(UIButton*)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f);
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmButton addTarget:self action:@selector(handleButtomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}

-(OrderDetailHeadCell*)headCell
{
    if (!_headCell) {
        _headCell = (OrderDetailHeadCell*)[UINib viewFromNib:@"OrderDetailHeadCell"];
//        _headCell.backgroundColor = [UIColor whiteColor];
//        _headCell.layer.borderWidth = .5f;
//        _headCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

    }
    
    return _headCell;
}

-(OrderDetailAddrCell*)addrCell
{
    if (!_addrCell) {
        _addrCell = (OrderDetailAddrCell*)[UINib viewFromNib:@"OrderDetailAddrCell"];
        _addrCell.backgroundColor = [UIColor whiteColor];
//        _addrCell.layer.borderWidth = .5f;
//        _addrCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

    }
    
    return _addrCell;
}

-(OrderListNoCheckBoxCell*)contentCell
{
    if (!_contentCell) {
        _contentCell = (OrderListNoCheckBoxCell*)[UINib viewFromNib:@"OrderListNoCheckBoxCell"];
        _contentCell.backgroundColor = [UIColor whiteColor];
        _contentCell.needHeadView = NO;
        _contentCell.canelButton.hidden = NO;
        _contentCell.productDescLabel.font = [UIFont boldSystemFontOfSize:15.f];
        UIColor* textColor = [UIColor UIColorFromRGB:0x666666];
        _contentCell.orderLabel.textColor = textColor;
        _contentCell.productDescLabel.textColor = textColor;
        _contentCell.companyWithIconLabel.textColor = textColor;
        _contentCell.amountLabel.textColor = textColor;
        _contentCell.priceLabel.textColor = textColor;
        
        _contentCell.layer.borderWidth = 0.f;

    }
    return _contentCell;
}

-(OrderDetailStatusCell*)statusCell
{
    if (!_statusCell) {
        _statusCell = (OrderDetailStatusCell*)[UINib viewFromNib:@"OrderDetailStatusCell"];
        _statusCell.backgroundColor = [UIColor whiteColor];
//        _statusCell.layer.borderWidth = .5f;
//        _statusCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

        
    }
    return _statusCell;

}

-(OrderLogsCell*)logsCell
{
    if (!_logsCell) {
        _logsCell = (OrderLogsCell*)[UINib viewFromNib:@"OrderLogsCell"];
        _logsCell.backgroundColor = [UIColor clearColor];
//        _logsCell.layer.borderWidth = .5f;
//        _logsCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

    }
    return _logsCell;
}

-(instancetype)initWithOrderStyle:(MMOrderListStyle)style andOrder:(OrderDetailDTO*)orderDto
{
    self = [super init];
    if (self) {
        self.style = style;
        self.orderDto = orderDto;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = self.view.bounds;

    [self initBottomView];
    
}

-(void)initBottomView
{
    // no need call it now
    return;
    
    if (self.style.orderType == kOrderTypeBuy) {
        if (self.style.orderSubType == kOrderSubTypePay) {
            switch (self.style.orderState) {
                case TOBEPAID: // 待支付
                    self.bottomView.hidden = NO;
                    break;
                case PAYTIMEOUT: // 支付超时
                    self.bottomView.hidden = NO;
                    break;
                case PAYCOMPLETE: // 已支付
                    self.bottomView.hidden = YES;
                    break;
                default:
                    self.bottomView.hidden = YES;
                    break;
            }
        }
        else if(self.style.orderSubType == kOrderSubTypeReceived){
            switch (self.style.orderState) {
                case TOBERECEIVED: //待签收
                    self.bottomView.hidden = NO;
                    break;
                case RECEIVECOMPLETE: //已签收
                    self.bottomView.hidden = YES;
                    break;
                default:
                    self.bottomView.hidden = YES;
                    break;
            }
        }
        else {
            self.bottomView.hidden = YES;
        }
    }
    else if (self.style.orderType == kOrderTypeSupply){
        if (self.style.orderSubType == kOrderSubTypeSend) {
            switch (self.style.orderState) {
                case WAITFORPAY: // 待付款
                    self.bottomView.hidden = YES;
                    break;
                case TOBESENT: // 待发货
                    self.bottomView.hidden = NO;
                    break;
                case SENTCOMPLETE: // 已发货
                    self.bottomView.hidden = YES;
                    break;
                default:
                    self.bottomView.hidden = YES;
                    break;
            }
        }
        else if(self.style.orderSubType == kOrderSubTypeConfirmed){
            switch (self.style.orderState) {
                case TOBESETTLED:
                    self.bottomView.hidden = YES;
                    break;
                case TOBECONFIRMED: //待确认
                    self.bottomView.hidden = NO;
                    break;
                case CONFIRMEDCOMPLETE: //已确认
                    self.bottomView.hidden = YES;
                    break;
                default:
                    self.bottomView.hidden = YES;
                    break;
            }
        }
        else {
            self.bottomView.hidden = YES;
        }
    }
    
    
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.bottomView.frame = CGRectMake(0, self.view.height-44.f, self.view.bounds.size.width, 44.f);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getOrderStatusDto];
    [self.tableView reloadData];

    [super viewWillAppear:animated];
    
}

-(void)setOrderStatusDto:(OrderStatusDTO *)orderStatusDto
{
    _orderStatusDto = orderStatusDto;
    
    if (orderStatusDto.addr && ![orderStatusDto.addr isKindOfClass:[NSNull class]]) {
        self.addrCell.nameLabel.text = [NSString stringWithFormat:@"收货人: %@", orderStatusDto.addr.contact];
        self.addrCell.phoneLabel.text = orderStatusDto.addr.mobile;
        self.addrCell.addrLabel.text = [NSString stringWithFormat:@"%@ %@", orderStatusDto.addr.region, orderStatusDto.addr.street];
    }
    
    self.contentCell.orderDetailDTO = [[OrderDetailDTO alloc]initWithOrderStatusDTO:orderStatusDto];
    self.logsCell.logs = orderStatusDto.logs;
    
    [self.confirmButton setTitle:[self promptString][@"bottomButtonTitle"]
                    forState:UIControlStateNormal];
    
    if (self.style.orderType == kOrderTypeBuy
        && self.style.orderSubType == kOrderSubTypePay
        && self.orderStatusDto.state == TOBEPAID) {
        self.contentCell.canelButton.hidden = NO;
        @weakify(self);
        self.contentCell.canelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
            @strongify(self);
            HttpOrderCancelRequest* request = [[HttpOrderCancelRequest alloc] initWithOderId:self.orderStatusDto.id];
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
                if (request.response.ok) {
                    if ([self.delegate respondsToSelector:@selector(removeOrder:)]){
                        [self.delegate cancelOrder:self.orderDto];
                    }
                }
                else {
                    [self showAlertViewWithMessage:request.response.errorMsg];
                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            })
            .finally(^(){
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            return [RACSignal empty];
        }];
    }
    else {
        self.contentCell.canelButton.hidden = YES;
    }

    
    [self.tableView reloadData];
}

-(void)getOrderStatusDto
{
    HttpOrderStatusRequest* request = [[HttpOrderStatusRequest alloc] initWithOrderId:self.orderDto.id andOderType:self.style.orderType];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpOrderStatusResponse* response = (HttpOrderStatusResponse*)request.response;
        if (response.ok) {
            self.orderStatusDto = response.orderStatusDto;
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

-(NSDictionary*)promptString
{
    NSString* string = @"";
    NSString* subString = @"";
    NSString* bottomButtonTitle = @"";
    NSDate* updateTime = [self.orderDto.updateTime convertToDate];
    NSInteger leftSeconds = floor(updateTime.timeIntervalSinceReferenceDate + 1*60*60 -  [NSDate date].timeIntervalSinceReferenceDate);
    if (leftSeconds < 0) {
        NSLog(@"invalid left seconds %ld", leftSeconds);
    }
    NSDate* createTime = [self.orderStatusDto.logs[0].createTime convertToDate];
    NSInteger elapseSeconds = floor([NSDate date].timeIntervalSinceReferenceDate - createTime.timeIntervalSinceReferenceDate);

    
    if (self.style.orderType == kOrderTypeBuy) {
        switch (self.orderStatusDto.state) {
            case TOBEPAID:
            {
                string =  @"请您尽快付款";
                subString = [NSString stringWithFormat:@"距离超时还剩: %@", [NSString leftTimeString2:leftSeconds*1000]];
                bottomButtonTitle = @"付款";
            }
                break;
            case PAYCOMPLETE:
            {
                string = @"请您等待卖家发货";
                subString = [NSString stringWithFormat:@"已支付%@", [NSString leftTimeString2:elapseSeconds*1000]];
                bottomButtonTitle = @"";
            }
                break;
            case PAYTIMEOUT:
                string = @"付款已超时";
                bottomButtonTitle = @"删除";
                break;
            case TOBERECEIVED:
            {
                string = @"请您尽快签收";
                subString = [NSString stringWithFormat:@"已发货%@", [NSString leftTimeString2:elapseSeconds*1000]];
                bottomButtonTitle = @"签收";
            }
                break;
            case RECEIVECOMPLETE:
                string = @"已完成";
                subString = [NSString stringWithFormat:@"已完成%@", [NSString leftTimeString2:elapseSeconds*1000]];
                break;
            case ORDERCLOSE:
                string = @"订单状态: 600";
                subString = [NSString stringWithFormat:@"最后操作时间 %@", self.orderDto.updateTime];

                break;
            default:
                break;
        }
    }
    else{
        switch (self.orderStatusDto.state) {
            case WAITFORPAY:
                string =  @"请您等待买家付款";
                subString = [NSString stringWithFormat:@"距离超时还剩: %@", [NSString leftTimeString2:leftSeconds*1000]];
                break;
            case TOBESENT:
                string =  @"请您尽快发货";
                bottomButtonTitle = @"发货";
                subString = [NSString stringWithFormat:@"已支付%@", [NSString leftTimeString2:elapseSeconds*1000]];

                break;
            case SENTCOMPLETE:
                string =  @"请您等待买家签收";
                subString = [NSString stringWithFormat:@"已发货%@", [NSString leftTimeString2:elapseSeconds*1000]];
                break;
            case TOBESETTLED:
                string =  @"请您等待网站结款";
                subString = [NSString stringWithFormat:@"已签收%@", [NSString leftTimeString2:elapseSeconds*1000]];
                bottomButtonTitle = @"结款";
                break;
            case TOBECONFIRMED:
                string =  @"请您尽快确认";
                subString = [NSString stringWithFormat:@"已结款%@", [NSString leftTimeString2:elapseSeconds*1000]];
                bottomButtonTitle = @"确认";
                break;
            case CONFIRMEDCOMPLETE:
                string =  @"已完成";
                subString = [NSString stringWithFormat:@"已完成%@", [NSString leftTimeString2:elapseSeconds*1000]];
                break;
            case ORDERCLOSE:
                string = @"订单状态: 600";
                subString = [NSString stringWithFormat:@"最后操作时间 %@", self.orderDto.updateTime];
                
                break;
            default:
                break;
        }
    }
    
    return @{@"string" : string,
             @"subString" : subString,
             @"bottomButtonTitle" : bottomButtonTitle};
}

-(void)handleButtomButtonClicked:(UIButton*)send
{
    @weakify(self);
    NSArray* operatorDtoIds = @[@(self.orderStatusDto.id)];
    
    if (self.style.orderType == kOrderTypeBuy) {
        switch (self.style.orderSubType ) {
            case kOrderSubTypePay:
            {
                switch (self.style.orderState) {
                    case TOBEPAID:
                        NSLog(@"我买的货->待付款->付款");
                        [self.navigationController pushViewController:[[PayViewController alloc] initWithOrderStatusDTO:self.orderStatusDto] animated:YES];
                        break;
                    case PAYTIMEOUT:
                        NSLog(@"我买的货->待付款->超时");
                    {
                        [self showAlertViewWithMessage:[NSString stringWithFormat:@"确定要删除该订单吗?"]
                                        withOKCallback:^(id x){
                                            @strongify(self);
                                            HttpOrderRemoveRequest* request = [[HttpOrderRemoveRequest alloc] initWithOrderIds:operatorDtoIds];
                                            [request request]
                                            .then(^(id responseObj){
                                                NSLog(@"%@", responseObj);
                                                if (request.response.ok) {
                                                    if ([self.delegate respondsToSelector:@selector(operatorDoneForOrder:)]) {
                                                        [self.delegate operatorDoneForOrder:@[self.orderDto]];
                                                    }
                                                }
                                                else {
                                                    [self showAlertViewWithMessage:request.response.errorMsg];
                                                }
                                            })
                                            .catch(^(NSError* error){
                                                [self showAlertViewWithMessage:error.localizedDescription];
                                            })
                                            .finally(^(){
                                                [self.navigationController popViewControllerAnimated:YES];
                                            });
                                        }
                                     andCancelCallback:nil];
                        
                        }
                        break;
                    case PAYCOMPLETE:
                        NSLog(@"我买的货->待付款->已支付");
                        break;
                    default:
                        break;
                }
            }
                break;
            case kOrderSubTypeReceived:
                switch (self.style.orderState) {
                    case TOBERECEIVED:
                    {
                        NSLog(@"我买的货->待签收->签收");
                        [self showAlertViewWithMessage:[NSString stringWithFormat:@"确定要签改订单吗?"]
                                        withOKCallback:^(id x){
                                            @strongify(self);
                                            HttpOrderReceiveRequest* request = [[HttpOrderReceiveRequest alloc] initWithOids:operatorDtoIds];
                                            [request request]
                                            .then(^(id responseObj){
                                                NSLog(@"%@", responseObj);
                                                if (request.response.ok) {
                                                    if ([self.delegate respondsToSelector:@selector(operatorDoneForOrder:)]) {
                                                        [self.delegate operatorDoneForOrder:@[self.orderDto]];
                                                    }
                                                }
                                                else {
                                                    [self showAlertViewWithMessage:request.response.errorMsg];
                                                }
                                            })
                                            .catch(^(NSError* error){
                                                [self showAlertViewWithMessage:error.localizedDescription];
                                            })
                                            .finally(^(){
                                                [self.navigationController popViewControllerAnimated:YES];
                                            });;
                                        }
                                     andCancelCallback:nil];

                    }
                        break;
                    case RECEIVECOMPLETE:
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
    else if(self.style.orderType == kOrderTypeSupply){
        switch (self.style.orderSubType ) {
            case kOrderSubTypeSend:
                switch (self.style.orderState) {
                    case TOBESENT:
                    {
                        NSLog(@"我卖的货->待发货->发货");
                        OrderSendViewController* sendVC = [[OrderSendViewController alloc] initWithOrderDetaildtos:@[self.orderDto]];
                        NSArray* vcs = self.navigationController.viewControllers;
                        if (vcs.count < 3) {
                            return;
                        }
                        OrderListViewController* orderListVC = vcs[vcs.count-2];
                        if (![orderListVC isKindOfClass:[OrderListViewController class]]) {
                            return;
                        }
                        sendVC.delegate = orderListVC;
                        [self.navigationController pushViewController:sendVC animated:YES];

                    }
                        break;
                    case SENTCOMPLETE:
                        NSLog(@"我卖的货->待发货->已发货");
                        break;
                    default:
                        break;
                }
                break;
            case kOrderSubTypeConfirmed:
                switch (self.style.orderState) {
                    case TOBECONFIRMED:
                    {
                        NSLog(@"我卖的货->待确认->确认");
                        [self showAlertViewWithMessage:[NSString stringWithFormat:@"确定要确认该订单吗?"]
                                        withOKCallback:^(id x){
                                            @strongify(self);
                                            HttpOrderConfirmRequest* request = [[HttpOrderConfirmRequest alloc] initWithOids:operatorDtoIds];
                                            [request request]
                                            .then(^(id responseObj){
                                                NSLog(@"%@", responseObj);
                                                if (request.response.ok) {
                                                    if ([self.delegate respondsToSelector:@selector(operatorDoneForOrder:)]) {
                                                        [self.delegate operatorDoneForOrder:@[self.orderDto]];
                                                    }
                                                }
                                                else {
                                                    [self showAlertViewWithMessage:request.response.errorMsg];
                                                }
                                            })
                                            .catch(^(NSError* error){
                                                [self showAlertViewWithMessage:error.localizedDescription];
                                            })
                                            .finally(^(){
                                                [self.navigationController popViewControllerAnimated:YES];
                                            });;
                                        }
                                     andCancelCallback:nil];
                    }
                        break;
                    case CONFIRMEDCOMPLETE:
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return kOrderDetailRowMax;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if (indexPath.row%2 == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoUseCell"];
        cell.backgroundColor =  RGBCOLOR(240, 240, 240);
        cell.clipsToBounds = YES;
    }
    else {
        switch (indexPath.row) {
            case kOrderDetailHeadRow:
                cell = self.headCell;
                if (self.style.orderType == kOrderTypeBuy && self.style.orderState==PAYTIMEOUT)
                {
                    self.headCell.titleLabel.textColor = [UIColor redColor];
                }
                self.headCell.titleLabel.text = [self promptString][@"string"];
                self.headCell.promptLabel.text = [self promptString][@"subString"];
                break;
            case kOrderDetailAddrRow:
                cell = self.addrCell;
                break;
            case kOrderDetailContentRow:
                cell = self.contentCell;
                break;
            case kOrderDetailStatusRow:
                cell = self.logsCell;
                break;
            default:
                break;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        if (indexPath.row == 2 && (!self.orderStatusDto.addr
            || [self.orderStatusDto.addr isKindOfClass:[NSNull class]])) {
            return 0;
        }
        return 14.f;
    }
    else {
        switch (indexPath.row) {
            case kOrderDetailHeadRow:
                if (self.style.orderType == kOrderTypeBuy && self.style.orderState==PAYTIMEOUT){
                    return 50.f;
                }
                return self.headCell.height;
                break;
            case kOrderDetailAddrRow:
                if (!self.orderStatusDto.addr
                    || [self.orderStatusDto.addr isKindOfClass:[NSNull class]] ) {
                    self.addrCell.hidden = YES;
                    return 0;
                }
                else {
                    self.addrCell.hidden = NO;
                    return 90.f;
                }
                break;
            case kOrderDetailContentRow:
                return self.contentCell.height;
                break;
            case kOrderDetailStatusRow:
                return self.logsCell.cellHeight;
                break;
            default:
                break;
        }
    }
    
    return 0;
}

-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}

@end
