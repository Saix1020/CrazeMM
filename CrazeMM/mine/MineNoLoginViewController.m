//
//  MineNoLoginViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineNoLoginViewController.h"
#import "NoLoginHeadCell.h"
#import "OrderListViewController.h"
#import "MineViewController.h"
#import "TabBarController.h"
#import "LoginViewController.h"

@interface MineNoLoginViewController ()

@property (nonatomic, strong) NoLoginHeadCell* noLoginCell;

@end

@implementation MineNoLoginViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        if (![UserCenter defaultCenter].isLogined) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(loginSuccessed:)
                                                         name:kLoginSuccessBroadCast object:nil];
        }

    }
    return self;
}


+(NSArray*)infoNames
{
    return @[
             @"我的账户",
             @"我的供货",
             @"我的求购",
             @"我的抵押",
            ];
}
+(NSArray*)infoIcons
{
    return @[
             @"account",
             @"gonghuo",
             @"qiugou",
             @"diya",
            ];
}

-(NoLoginHeadCell*)noLoginCell
{
    if(!_noLoginCell){
        _noLoginCell = [[[NSBundle mainBundle]loadNibNamed:@"NoLoginHeadCell" owner:nil options:nil] firstObject];
        _noLoginCell.infoLabel.text = @"欢迎使用189疯狂买卖王";
        [_noLoginCell.loginButton setTitle:@"请点击登录" forState:UIControlStateNormal];
        
        @weakify(self);
        _noLoginCell.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
           
            @strongify(self);
            LoginViewController* loginVC = [[LoginViewController alloc] init];
            
            [self.navigationController pushViewController:loginVC animated:YES];
            return [RACSignal empty];
        }];
    }
    
    return _noLoginCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessBroadCast object:self];
}

-(void)loginSuccessed:(id)notifiction
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessBroadCast object:self];
    
    MineViewController* mineVC = [[MineViewController alloc] init];
    UITabBarItem *mineItem = [[UITabBarItem alloc] init];
    [mineItem setTitle:@"我的"];
    [mineItem setImage:[[UIImage imageNamed:@"mine1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    mineVC.tabBarItem = mineItem;
    
    NSArray *vcs = self.navigationController.viewControllers;
    NSMutableArray* vcsNew = [[NSMutableArray alloc] init];
    for (UIViewController *vc in vcs) {
        if(vc == self){
            [vcsNew addObject:mineVC];
        }
        else {
            [vcsNew addObject:vc];
            
        }
    }
    
    self.navigationController.viewControllers = [vcsNew copy];


}



#pragma -- mark tableview Delegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0 && row == 0) {
        cell = self.noLoginCell;
    }
    else {
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kSectionOverview:
            return 2;
        case kSectionInfo:
            return [[self class] infoNames].count;
        case kSectionContact:
            return 1;
        default:
            break;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case kSectionInfo:
        {
            OrderListViewController* mineSellProductVC = [[OrderListViewController alloc] init];
            [self.navigationController pushViewController:mineSellProductVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kSectionOverview) {
        return 0.f;
    }
    
    return 12.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == kSectionInfo) {
        return 44.f;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
