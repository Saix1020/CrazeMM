//
//  BankCardListViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BankCardListViewController.h"
#import "HttpMineAccount.h"
#import "BankCardCell.h"
#import "BankCardEditingViewController.h"


@interface BankCardListViewController ()
@property (nonatomic, strong) NSArray* dataSource;
@end

@implementation BankCardListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的银行卡";
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);

    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;

    [self.tableView registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil]  forCellReuseIdentifier:@"BankCardCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]  initWithImage:[@"addr_add_icon" image] style:UIBarButtonItemStylePlain target:self action:@selector(editBankCard:)];
    
//    [self refreshBankCardList];
    
}

-(void)editBankCard:(id)sender
{
    BankCardEditingViewController* bankCardEditingVC = [[BankCardEditingViewController alloc] init];
    [self.navigationController pushViewController:bankCardEditingVC animated:YES];
}

-(void)refreshBankCardList
{
    HttpMineAccountRequest *request = [[HttpMineAccountRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpMineAccountResponse* response = (HttpMineAccountResponse*)request.response;
        
        if (response.ok) {
            self.dataSource = [response.backCards copy];
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
    [self refreshBankCardList];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCardCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bankCardDto = self.dataSource[indexPath.row];
    cell.defaultCheckBox.tag = 10000 + indexPath.row;
    cell.defaultCheckBox.delegate = self;
    cell.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132.f;
}

#pragma  -- mark BEMCheckBoxDelegate
- (BOOL)willTapCheckBox:(BEMCheckBox *)checkBox
{
    @weakify(self);
    if (checkBox.on) {
//        [self showAlertViewWithMessage:@"你确定取消该银行卡为默认账号?" withOKCallback:^(id x){
//            ((BankCardDTO*)self.dataSource[checkBox.tag-10000]).isDefault = NO;
//            
//        } andCancelCallback:^(id x){
//            
//        }];
        
    }
    else{
        [self showAlertViewWithMessage:@"你确定设置该银行卡为默认账号?" withOKCallback:^(id x){
            @strongify(self);
//            for(BankCardDTO* dto in self.dataSource){
//                if (dto.isDefault) {
//                    dto.isDefault = NO;
//                }
//            }
//            ((BankCardDTO*)self.dataSource[checkBox.tag-10000]).isDefault = YES;
            HttpSetDefaultAccountRequest* request = [[HttpSetDefaultAccountRequest alloc] initWithCardId:((BankCardDTO*)self.dataSource[checkBox.tag-10000]).id];
            [request request]
            .then(^(id responseObj){
                if (request.response.ok) {
                    [self refreshBankCardList];
                }
                else {
                    [self showAlertViewWithMessage:request.response.errorMsg];
                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            });
        } andCancelCallback:nil];
        
    }
    
    return NO;
}

-(void)removeButtonClicked:(BankCardDTO*)bankCardDto
{
    HttpDeleteBankAccountRequest* request = [[HttpDeleteBankAccountRequest alloc] initWithCardId:bankCardDto.id];
    @weakify(self);
    [self showAlertViewWithMessage:@"你确定删除该银行卡号?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        [request request]
                        .then(^(id responseObj){
                            if (request.response.ok) {
                                [self refreshBankCardList];
                            }
                            else {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                            
                        });
                    }
            andCancelCallback:^(id x){
                @strongify(self);

                 }];
    
}

@end
