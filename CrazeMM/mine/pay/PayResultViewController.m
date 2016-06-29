//
//  PayResultViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayResultViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "CommonBottomView.h"
#import "PayResultCell.h"
#import "PaySuccessProductCell.h"
#import "TTModalView.h"
#import "TransferAlertView.h"
#import "SupplyViewController.h"
#import "MineViewController.h"
#import "HttpStock.h"
#import "OrderDetailDTO.h"

@interface PayResultViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) CommonBottomView* payBottomView;

@property (nonatomic, strong) TTModalView* confirmModalView;
@property (nonatomic, strong) TransferAlertView* transferAlertView;
@property (nonatomic) BOOL keyboardShowing;

@property (nonatomic, copy) NSArray* stockDetailDTOs;
@property (nonatomic, copy) NSArray* orderDetailDTOs;
@property (nonatomic, readonly) NSArray* selectedDtos;

@end

@implementation PayResultViewController

-(NSArray*)selectedDtos
{
    return [self.stockDetailDTOs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.selected != NO"]];
}

//-(instancetype)initWithOrderDetailDtos:(NSArray *)orderDetailDTOs
//{
//    self = [self init];
//    if (self) {
//        self.orderDetailDTOs = orderDetailDTOs;
//    }
//    return self;
//}

-(instancetype)initWithStockDetailDtos:(NSArray *)stockDetailDTOs
{
    self = [self init];
    if (self) {
        self.stockDetailDTOs = stockDetailDTOs;
    }
    return self;
}


-(TransferAlertView*)transferAlertView
{
    if (!_transferAlertView) {
        _transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"TransferAlertView" owner:nil options:nil] firstObject];
        _transferAlertView.layer.cornerRadius = 6.f;
    }
    
    return _transferAlertView;
}

-(TTModalView*)confirmModalView
{
    if (!_confirmModalView) {
        _confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
        _confirmModalView.isCancelAble = YES;
        _confirmModalView.modalWindowLevel = UIWindowLevelNormal;
        _confirmModalView.contentView = self.transferAlertView;
    }
    
    return _confirmModalView;
}

-(CommonBottomView*)payBottomView
{
    if(!_payBottomView){
        _payBottomView = [[[NSBundle mainBundle]loadNibNamed:@"CommonBottomView" owner:nil options:nil] firstObject];
        ;
        [self.view addSubview:_payBottomView];
        [_payBottomView.confirmButton setTitle:@"转手" forState:UIControlStateNormal];
        [_payBottomView.confirmButton addTarget:self action:@selector(handleButtomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _payBottomView.selectAllCheckBox.delegate = self;
    }
    
    return _payBottomView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付成功";
    
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StockSellCell" bundle:nil] forCellReuseIdentifier:@"PaySuccessProductCell"];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel_m"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    @weakify(self);
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    [self canBecomeFirstResponder];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    if (self.stockDetailDTOs.count) {
        self.payBottomView.frame = CGRectMake(0, self.view.height-[CommonBottomView cellHeight], self.view.bounds.size.width, [CommonBottomView cellHeight]);

    }
    else {
        self.payBottomView.frame = CGRectZero;
    }
    //[self.view bringSubviewToFront:self.payBottomView];
    
    //self.tableView.contentSize = CGSizeMake(0, 100);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 1*2;
    }
    else {
        return self.stockDetailDTOs.count*2;
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.row%2==1) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        cell.layer.borderWidth = .5f;
//        cell.layer.borderColor = [UIColor grayColor].CGColor;
        return cell;
    }
    
    if (indexPath.section == 0) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PayResultCell" owner:nil options:nil] firstObject];
    }
    else {
        StockSellCell* stockSellCell = [tableView dequeueReusableCellWithIdentifier:@"PaySuccessProductCell"];
        StockDetailDTO* stockDetailDto = self.stockDetailDTOs[indexPath.row/2];
        stockSellCell.stockDetailDto = stockDetailDto;
        stockSellCell.delegate = self;
        stockSellCell.checkBox.on = stockDetailDto.selected;
        stockSellCell.checkBox.tag = 10000 + indexPath.row/2;
        cell = stockSellCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma -- mark BEMCheckBox Delegate
-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if (checkBox != self.payBottomView.selectAllCheckBox) {
        NSInteger index = checkBox.tag - 10000;
        MineStockDTO* dto = self.stockDetailDTOs[index];
        dto.selected = checkBox.on;
        
        NSArray* onArray = [self.stockDetailDTOs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.selected != NO"]];
        if (onArray.count == self.stockDetailDTOs.count) {
            self.payBottomView.selectAllCheckBox.on = YES;
        }
        else {
            self.payBottomView.selectAllCheckBox.on = NO;
        }
    }
    else {
        for (NSInteger index = 0; index<self.stockDetailDTOs.count; ++index) {
            MineStockDTO* dto = self.stockDetailDTOs[index];
            dto.selected = checkBox.on;
        }
        [self.tableView reloadData];
    }
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40.f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%2 == 1) {
        return 14.f;
    }
    if (indexPath.section==0) {
        return [PayResultCell cellHeigh];
    }
    else {
        return [StockSellCell cellHeight];
    }
}

-(void)refreshTotalPriceLabel
{
    NSInteger totalPrice = 0;
    for (NSInteger index = 0; index<self.stockDetailDTOs.count; ++index) {
        StockDetailDTO* dto = self.stockDetailDTOs[index];
        totalPrice += dto.earning;
    }
    self.payBottomView.totalPrice = totalPrice;
    
}

-(void)handleButtomButtonClicked:(UIButton*)send
{
    if (self.selectedDtos.count==0) {
        [self showAlertViewWithMessage:@"请选择需要转手的库存"];
        return;
    }
    
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"确认要转手这%ld条库存吗?", [self.selectedDtos count]]
                    withOKCallback:^(id x){
                        @strongify(self);
                        NSInteger count = [self.selectedDtos count];
                        [self sendStockSellReq:count];
                    }
                 andCancelCallback:nil];
}

- (void) sendStockSellReq: (NSInteger)count
{
    if (count <= 0)
    {
        [self showAlertViewWithMessage:@"库存转手成功"
                          withCallback:^(id x){
                              [self.navigationController popToRootViewControllerAnimated:YES];
                              
                          }];
        return;
    }
    
//price:234
//sale:1
//num:1
//version:0
    
    StockSellInfo* stockSellInfo = [[StockSellInfo alloc] init];
    if (count-1 >= self.selectedDtos.count) {
        return;
    }
    StockDetailDTO* dto = self.selectedDtos[count-1];
    stockSellInfo.price = dto.currentPrice;
    stockSellInfo.sale = dto.currentSale;
    stockSellInfo.num = dto.currentNum;
    stockSellInfo.version = dto.version;
//    if(dto.stock)
    stockSellInfo.sellId = dto.id;
    HttpStockSellRequest* request = [[HttpStockSellRequest alloc]initWithStocks:stockSellInfo];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
//            if (count-1>0) {
                [self sendStockSellReq:(count-1)];
//            }
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
            return ;
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
        return ;
    })
    .finally(^(){
    });
    
}


@end
