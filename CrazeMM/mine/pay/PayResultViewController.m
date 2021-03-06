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

@interface PayResultViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) CommonBottomView* payBottomView;

@property (nonatomic, strong) TTModalView* confirmModalView;
@property (nonatomic, strong) TransferAlertView* transferAlertView;
@property (nonatomic) BOOL keyboardShowing;

@end

@implementation PayResultViewController

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
        
        @weakify(self);
        _payBottomView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            @strongify(self);
            self.confirmModalView.presentAnimationStyle = fadeIn;
            self.confirmModalView.dismissAnimationStyle = fadeOut ;
            
            
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
            return [RACSignal empty];
        }];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PaySuccessProductCell" bundle:nil] forCellReuseIdentifier:@"PaySuccessProductCell"];
    
    
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
//    NSMutableArray* vcs = [self.navigationController.viewControllers mutableCopy];
//    NSInteger count = vcs.count;
//    if (count > 2) {
//        if ([vcs[count-2] isKindOfClass:NSClassFromString(@"OnlinePayViewController")]) {
//            [vcs removeObject:vcs[count-2]]; // OnlinePayViewController
//        }
//        count = vcs.count;
//        if (count > 2) {
//            if ([vcs[count-2] isKindOfClass:NSClassFromString(@"PayViewController")]) {
//                [vcs removeObject:vcs[count-2]]; // PayViewController
//            }
//        }
//        
//    }
//    
//    
//    self.navigationController.viewControllers = vcs;
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
        return 4*2-1;
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
        cell = [tableView dequeueReusableCellWithIdentifier:@"PaySuccessProductCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
        return [PaySuccessProductCell cellHeight];
    }
}



@end
