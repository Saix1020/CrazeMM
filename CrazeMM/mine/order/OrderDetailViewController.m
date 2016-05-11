//
//  OrderDetailViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderListNoCheckBoxCell.h"
#import "OrderDetailHeadCell.h"
#import "OrderDetailAddrCell.h"
#import "OrderDetailStatusCell.h"


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

@property (nonatomic, strong) OrderDetailHeadCell* headCell;
@property (nonatomic, strong) OrderDetailAddrCell* addrCell;
@property (nonatomic, strong) OrderListNoCheckBoxCell* contentCell;
@property (nonatomic, strong) OrderDetailStatusCell* statusCell;



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
        _confirmButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-32.f-80.f, (44.f-32.f)/2, 80.f, 32.f);
        [_confirmButton setTitle:@"付款" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        _confirmButton.layer.borderWidth = 1.f;
        _confirmButton.layer.borderColor = [UIColor redColor].CGColor;
        _confirmButton.layer.cornerRadius = 4.f;
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

-(instancetype)initWithOrderStyle:(MMOrderListStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
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
                cell = self.statusCell;
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
                return self.addrCell.height;
                break;
            case kOrderDetailContentRow:
                return self.contentCell.height;
                break;
            case kOrderDetailStatusRow:
                return self.statusCell.height;
                break;
            default:
                break;
        }
    }
    
    return 0;
}

@end
