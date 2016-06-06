//
//  MineStockSellViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineStockSellViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "CommonBottomView.h"
#import "TTModalView.h"
#import "TransferAlertView.h"
#import "StockSellCell.h"
#import "MineStockDTO.h"
#import "HttpStock.h"

@interface MineStockSellViewController ()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) CommonBottomView* payBottomView;
@property (nonatomic, copy) NSArray* stocks;

//@property (nonatomic) BOOL keyboardShowing;


@end

@implementation MineStockSellViewController

-(CommonBottomView*)payBottomView
{
    if(!_payBottomView){
        _payBottomView = [[[NSBundle mainBundle]loadNibNamed:@"CommonBottomView" owner:nil options:nil] firstObject];
        ;
        [self.view addSubview:_payBottomView];
        [_payBottomView.confirmButton setTitle:@"转手" forState:UIControlStateNormal];
        _payBottomView.selectAllCheckBox.hidden = YES;
        _payBottomView.selectAllLabel.hidden = YES;
        
        [_payBottomView.confirmButton addTarget:self action:@selector(handleButtomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    return _payBottomView;
}

-(void)handleButtomButtonClicked:(UIButton*)send
{
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"确认要转手这%ld条库存吗?", [self.stocks count]]
                    withOKCallback:^(id x){
                        @strongify(self);
                        
                        NSInteger count = [self.stocks count];
                        
                        [self sendStockSellReq:count];
                        
                    }
                 andCancelCallback:nil];
}

-(instancetype)initWith:(NSArray*)stocks
{
    self = [super init];
    if (self)
    {
        self.stocks = stocks;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"库存出货";
    
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StockSellCell" bundle:nil] forCellReuseIdentifier:@"StockSellCell"];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel_m"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    @weakify(self);
    self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    [self canBecomeFirstResponder];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.payBottomView.frame = CGRectMake(0, self.view.height-[CommonBottomView cellHeight], self.view.bounds.size.width, [CommonBottomView cellHeight]);
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

#pragma mark - StockSellCellDelegate
-(void)refreshTotalPriceLabel
{
        NSInteger totalPrice = 0;
        for (NSInteger index = 0; index<self.stocks.count; ++index) {
            MineStockDTO* dto = self.stocks[index];
            totalPrice += dto.earning;
        }
        self.payBottomView.totalPrice = totalPrice;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return [self.stocks count]*2 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if (indexPath.row%2==0) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return cell;
    }
    else if(indexPath.row == [self.stocks count]*2){
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StockSellCell"];
        
        MineStockDTO* dto = self.stocks[indexPath.row/2];
        dto.earning = 0;

        ((StockSellCell*)cell).stockDto = dto;
        ((StockSellCell*)cell).selectCheckBox.tag = 10000 + indexPath.row/2;
        ((StockSellCell*)cell).selectCheckBox.hidden = YES;
        ((StockSellCell*)cell).delegate = self;
        }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%2 == 0) {
        return 14.f;
    }
    else if(indexPath.row == [self.stocks count]*2){
        return self.payBottomView.height;
    }
    else
    {
        return [StockSellCell cellHeight];
    }

}

- (void) sendStockSellReq: (NSInteger)count
{
    
    // TODO
    // we should refresh the selected stock dtos.
    if (count <= 0)
    {
        if ([self.delegate respondsToSelector:@selector(sendStockSellSuccess)]) {
            [self showAlertViewWithMessage:@"库存转手成功"];
            [self.delegate sendStockSellSuccess];
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    StockSellInfo* stockSellInfo = [[StockSellInfo alloc] init];
    MineStockDTO* dto = self.stocks[count-1];
    stockSellInfo.price = dto.currentPrice;
    stockSellInfo.sale = dto.currentSale;
    stockSellInfo.num = dto.currentNum;
    stockSellInfo.version = dto.version;
    stockSellInfo.sellId = dto.id;
    HttpStockSellRequest* request = [[HttpStockSellRequest alloc]initWithStocks:stockSellInfo];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            
            [self sendStockSellReq:(count-1)];
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
