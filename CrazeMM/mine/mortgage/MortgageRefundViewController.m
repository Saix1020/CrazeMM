//
//  MortgageRefundViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageRefundViewController.h"
#import "HttpMortgage.h"
#import "HttpBalance.h"
#import "MortgageRefundCell.h"

@interface MortgageRefundViewController ()

@property (nonatomic, strong) UIView* buttomView;
@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) NSMutableArray* selectedDtos;
@property (nonatomic) CGFloat money;
@property (nonatomic) CGFloat totalInterest;
@property (nonatomic) NSInteger totalPrice;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation MortgageRefundViewController

-(instancetype)initWithDtos:(NSMutableArray *)selectedDtos
{
    self =[super init];
    
    if (self)
    {
        self.selectedDtos = [selectedDtos mutableCopy];
    }
    
    return self;
}

-(UIView*)buttomView
{
    if(!_buttomView){
        _buttomView = [[UIView alloc] init];
        [self.view addSubview:_buttomView];
        _buttomView.backgroundColor = [UIColor clearColor];
    }
    
    return _buttomView;
}


-(UIButton*)payButton
{
    if (!_payButton)
    {
        _payButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_payButton setTitle:@"确认付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _payButton.layer.cornerRadius = 0;
        [_payButton setBackgroundColor:[UIColor redColor]];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self.buttomView addSubview:_payButton];
        
        
        @weakify(self);
        self.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
            
            @strongify(self);
            
            NSLog(@"need to call pay methods here");
            //余额支付？
            return [RACSignal empty];
        }];
        
        
    }
    return _payButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"抵押还款";
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
    
    
    self.view.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];

    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = self.view.frame;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MortgageRefundCell" bundle:nil] forCellReuseIdentifier:@"MortgageRefundCell"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
     self.buttomView.frame = CGRectMake(0, self.view.bounds.size.height-70, self.view.bounds.size.width, 70);
    self.payButton.frame = CGRectMake(0, 20, self.view.bounds.size.width, 50);
}

-(void)calculateInterest
{
    self.totalInterest = 0.00f;
    self.totalPrice = 0;
    
    HttpNowRequest* request = [[HttpNowRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        if (!request.response.ok) {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
        else {
            HttpNowResponse* response = (HttpNowResponse*) request.response;
            NSInteger now = response.now;
            
            //format time
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
            [formatter setTimeZone:timeZone];
            
            for(MortgageDTO* Dto in self.selectedDtos)
            {
                NSString* checkTime = Dto.checkTime;
                NSDate* date = [formatter dateFromString:checkTime];
                NSLog(@"%@", date);
                NSInteger checkTimeInterval = [date timeIntervalSince1970];
                NSLog(@"%ld", checkTimeInterval);
                NSInteger days = (now - checkTimeInterval)/(1000 * 60 * 60 * 24);
                self.totalPrice += Dto.price*Dto.quantity;
                self.totalInterest += Dto.price*Dto.quantity*Dto.interestRate*days;
            }
            
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });

}

- (void)getBalanceInfo

{
    HttpBalanceRequest* balanceRequest = [[HttpBalanceRequest alloc] init];
    [balanceRequest request]
    .then(^(id responseObj){
        HttpBalanceResponse* response = (HttpBalanceResponse*)balanceRequest.response;
        self.money = response.balanceDto.money;
        
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MortgageRefundCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MortgageRefundCell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    self.totalInterest = 0.00f;
    self.totalPrice = 0;
    self.money = 0.00f;
    
    HttpBalanceRequest* balanceRequest = [[HttpBalanceRequest alloc] init];
    [balanceRequest request]
    .then(^(id responseObj){
        HttpBalanceResponse* response = (HttpBalanceResponse*)balanceRequest.response;
        self.money = response.balanceDto.money;
        
        HttpNowRequest* request = [[HttpNowRequest alloc] init];
        [request request]
        .then(^(id responseObj){
            if (!request.response.ok) {
                [self showAlertViewWithMessage:request.response.errorMsg];
            }
            else {
                HttpNowResponse* response = (HttpNowResponse*) request.response;
                NSInteger now = response.now;
                
                //format time
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
                [formatter setTimeZone:timeZone];
                
                for(MortgageDTO* Dto in self.selectedDtos)
                {
                    NSString* checkTime = Dto.checkTime;
                    NSDate* date = [formatter dateFromString:checkTime];
                    NSLog(@"%@", date);
                    NSInteger checkTimeInterval = [date timeIntervalSince1970];
                    NSLog(@"%ld", checkTimeInterval);
                    NSInteger days = (now - checkTimeInterval*1000)/(1000 * 60 * 60 * 24);
                    self.totalPrice += Dto.price*Dto.quantity;
                    self.totalInterest += Dto.price*Dto.quantity*Dto.interestRate*days;
                }
                
                ((MortgageRefundCell*) cell).totalNum = [self.selectedDtos count];
                ((MortgageRefundCell*) cell).price =self.totalPrice;
                ((MortgageRefundCell*) cell).interest =self.totalInterest;
                ((MortgageRefundCell*) cell).money = self.money;

                
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });

        
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}

@end
