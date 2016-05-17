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
        _headCell.layer.borderWidth = .5f;
        _headCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

    }
    
    return _headCell;
}

-(OrderDetailAddrCell*)addrCell
{
    if (!_addrCell) {
        _addrCell = (OrderDetailAddrCell*)[UINib viewFromNib:@"OrderDetailAddrCell"];
        _addrCell.backgroundColor = [UIColor whiteColor];
        _addrCell.layer.borderWidth = .5f;
        _addrCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

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
        _contentCell.productDescLabel.font = [UIFont systemFontOfSize:15.f];
        UIColor* textColor = [UIColor UIColorFromRGB:0x666666];
        _contentCell.orderLabel.textColor = textColor;
        _contentCell.productDescLabel.textColor = textColor;
        _contentCell.companyWithIconLabel.textColor = textColor;
        _contentCell.amountLabel.textColor = textColor;
        _contentCell.priceLabel.textColor = textColor;
    }
    return _contentCell;
}

-(OrderDetailStatusCell*)statusCell
{
    if (!_statusCell) {
        _statusCell = (OrderDetailStatusCell*)[UINib viewFromNib:@"OrderDetailStatusCell"];
        _statusCell.backgroundColor = [UIColor whiteColor];
        _statusCell.layer.borderWidth = .5f;
        _statusCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

        
    }
    return _statusCell;

}

-(OrderLogsCell*)logsCell
{
    if (!_logsCell) {
        _logsCell = (OrderLogsCell*)[UINib viewFromNib:@"OrderLogsCell"];
        _logsCell.backgroundColor = [UIColor whiteColor];
        _logsCell.layer.borderWidth = .5f;
        _logsCell.layer.borderColor = [UIColor light_Gray_Color].CGColor;

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
//    [self.tableView beginUpdates];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:kOrderDetailAddrRow inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView endUpdates];
//    
    self.contentCell.orderDetailDTO = [[OrderDetailDTO alloc]initWithOrderStatusDTO:orderStatusDto];
    self.logsCell.logs = orderStatusDto.logs;
    
    [_confirmButton setTitle:[self promptString][@"bottomButtonTitle"]
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
    if (self.style.orderType == kOrderTypeBuy) {
        switch (self.orderStatusDto.state) {
            case TOBEPAID:
                string =  @"请尽快付款";
                subString = @"一小时后过期";
                bottomButtonTitle = @"付款";
                break;
            case PAYCOMPLETE:
                string = @"支付完成";
                bottomButtonTitle = @"";
                break;
            case PAYTIMEOUT:
                string = @"支付超时";
                bottomButtonTitle = @"删除";
                break;
            case TOBERECEIVED:
                string = @"请尽快签收";
                break;
            case RECEIVECOMPLETE:
                string = @"签收完成";
                break;
            default:
                break;
        }
    }
    else{
        switch (self.orderStatusDto.state) {
            case TOBESENT:
                string =  @"请尽快发货";
                break;
            case SENTCOMPLETE:
                string =  @"发货完成";
                break;
            case TOBECONFIRMED:
                string =  @"请尽快确认";
                break;
            case CONFIRMEDCOMPLETE:
                string =  @"确认完成";
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
                        NSMutableArray* removeIds = [[NSMutableArray alloc] init];
                        [removeIds addObject:[NSString stringWithFormat:@"%ld", self.orderStatusDto.id]];
                        HttpOrderRemoveRequest* request = [[HttpOrderRemoveRequest alloc] initWithOrderIds:removeIds];
                        [request request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (request.response.ok) {
                                if ([self.delegate respondsToSelector:@selector(removeOrder:)]){
                                    [self.delegate removeOrder:self.orderDto];
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
                        NSLog(@"我买的货->待签收->签收");
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
                        NSLog(@"我卖的货->待发货->发货");
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
                        NSLog(@"我卖的货->待确认->确认");
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
    }
    else {
        switch (indexPath.row) {
            case kOrderDetailHeadRow:
                cell = self.headCell;
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
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        return 14.f;
    }
    else {
        switch (indexPath.row) {
            case kOrderDetailHeadRow:
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
