//
//  BankCardViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BankCardEditingViewController.h"
#import "AddrCommonCell.h"
#import "AddrDefaultCheckboxCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "HttpMineAccount.h"


@interface BankCardEditingViewController ()

@property (nonatomic, strong) AddrCommonCell* bankNameCell;
@property (nonatomic, strong) AddrCommonCell* bankAccountCell;
@property (nonatomic, strong) AddrCommonCell* userNameCell;
@property (nonatomic, strong) AddrDefaultCheckboxCell* setDefaultCell;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) NSArray* cellArray;

@end

@implementation BankCardEditingViewController

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 16.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
        _confirmCell.backgroundColor = RGBCOLOR(240, 240, 240);
        _confirmButton.enabled = NO;
        @weakify(self);
        RACSignal* enableSaveSignal = [RACSignal
                                        combineLatest:@[
                                                        self.bankNameCell.textFieldCell.rac_textSignal,
                                                        self.bankAccountCell.textFieldCell.rac_textSignal,
                                                        self.userNameCell.textFieldCell.rac_textSignal                                                        ]
                                        reduce:^(NSString *bankName, NSString *bankAccount, NSString *userName) {
                                            return @(bankName.length > 0 && bankAccount.length > 0 && userName.length>0);
                                        }];
        
        [enableSaveSignal subscribeNext:^(NSNumber* enable){
            @strongify(self);
            if (enable.boolValue) {
                self.confirmButton.enabled = YES;
                self.confirmButton.backgroundColor = [UIColor greenTextColor];
            }
            else {
                self.confirmButton.enabled = NO;
                self.confirmButton.backgroundColor = [UIColor light_Gray_Color];
                
            }
        }];
        
        [_confirmButton addTarget:self action:@selector(saveBankCard:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmCell;
}

-(void)saveBankCard:(id)sender
{
    HttpSaveBankAccountRequest* request = [[HttpSaveBankAccountRequest alloc] initWithBankName:self.bankNameCell.value
                                                                                 andBankAccout:self.bankAccountCell.value
                                                                                   andUserName:self.userNameCell.value
                                                                                   andIsDefaut:self.setDefaultCell.checkBox.on];
    [request request]
    .then(^(id responseObj){
        if (request.response.ok) {
            [self showAlertViewWithMessage:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加银行卡";
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    self.tableView.frame = self.view.frame;
    
    self.bankNameCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
    self.bankNameCell.title = @"开户银行";
    self.bankNameCell.placehoder = @"请填写开户银行";
    self.bankAccountCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
    self.bankAccountCell.title = @"银行账号";
    self.bankAccountCell.placehoder = @"请认真填写银行账号";
    self.userNameCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
    self.userNameCell.title = @"开户名称";
    self.userNameCell.placehoder = @"请填写开户名称";
    
    self.setDefaultCell = (AddrDefaultCheckboxCell*)[UINib viewFromNib:@"AddrDefaultCheckboxCell"];
    self.setDefaultCell.titlelabel.text = @"设为默认";
    self.setDefaultCell.titleLabel2.hidden = YES;
    self.setDefaultCell.checkBox.boxType = BEMBoxTypeSquare;
    self.setDefaultCell.checkBox.animationDuration = 0.f;
    self.setDefaultCell.checkBox2.hidden = YES;
    self.setDefaultCell.seperatorLine.hidden = YES;
    
    self.cellArray = @[
                       self.bankNameCell,
                       self.bankAccountCell,
                       self.userNameCell,
                       self.setDefaultCell,
                       self.confirmCell
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = self.cellArray[indexPath.row];
    if (cell != self.confirmCell) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==self.cellArray.count-1) {
        return 56.f;
    }
    
    return 44.f;
}


@end
