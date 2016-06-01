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
//#import "SupplyViewController.h"
//#import "MineViewController.h"

@interface MineStockSellViewController ()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) CommonBottomView* payBottomView;

@property (nonatomic) BOOL keyboardShowing;


@end

@implementation MineStockSellViewController

-(CommonBottomView*)payBottomView
{
    if(!_payBottomView){
        _payBottomView = [[[NSBundle mainBundle]loadNibNamed:@"CommonBottomView" owner:nil options:nil] firstObject];
        ;
        [self.view addSubview:_payBottomView];
        [_payBottomView.confirmButton setTitle:@"转手" forState:UIControlStateNormal];
        
        @weakify(self);
        _payBottomView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            
            
            /*
            [self.confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
                
                contentView.centerX = self.view.centerX;
                contentView.centerY = self.view.centerY;
                
                
                self.transferAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    [self.tableView reloadData];
                    
                    return [RACSignal empty];
                }];
                
                self.transferAlertView.linkButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
                    @strongify(self);
                    [self.confirmModalView dismiss];
                    
                    //[self.navigationController po];
                    NSArray* vcs = self.navigationController.viewControllers;
                    NSMutableArray* newVcs = [[NSMutableArray alloc] init];
                    //self.navigationController.viewControllers = [newVcs copy];
                    
                    
                    if ([[vcs firstObject] isMemberOfClass:[MineViewController class]]) {
                        SupplyViewController* supplyVC = [[SupplyViewController alloc] init];
                        //                        BaseNavigationController* baseNav = (BaseNavigationController*)self.navigationController;
                        //                        baseNav.nextViewController = supplyVC;
                        //                        [self.navigationController popToRootViewControllerAnimated:YES];
                        [newVcs addObject:[vcs firstObject]];
                        [newVcs addObject:supplyVC];
                        [newVcs addObject:self];
                        
                        self.navigationController.viewControllers = [newVcs copy];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                    return [RACSignal empty];
                }];
                
                
            }];
             */
            return [RACSignal empty];
        }];
        
    }
    
    return _payBottomView;
}

- (void)viewDidLoad {
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StockSellCell" bundle:nil] forCellReuseIdentifier:@"StockSellCell"];
    
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       //TBD
       return 1;
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
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StockSellCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row%2 == 1) {
        return 14.f;
    }
    else
    {
        return [StockSellCell cellHeight];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
