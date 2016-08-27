//
//  PersonalInfoViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalPhoneViewContoller.h"
#import "PersonalEmailModifyViewContoller.h"
#import "PersonalOtherModifyViewContoller.h"

@interface PersonalInfoViewController ()

@property (nonatomic, strong) UITableViewCell* phoneModifyCell;
@property (nonatomic, strong) UITableViewCell* emailModifyCell;
@property (nonatomic, strong) UITableViewCell* otherModifyCell;


@end



@implementation PersonalInfoViewController

-(UITableViewCell*)phoneModifyCell
{
    if(!_phoneModifyCell){
        _phoneModifyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"phoneModifyCell"];
        _phoneModifyCell.textLabel.text = @"修改手机号码";
    }
    
    return _phoneModifyCell;
}

-(UITableViewCell*)emailModifyCell
{
    if(!_emailModifyCell){
        _emailModifyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emailModifyCell"];
        _emailModifyCell.textLabel.text = @"修改邮箱";
    }
    
    return _emailModifyCell;
}

-(UITableViewCell*)otherModifyCell
{
    if(!_otherModifyCell){
        _otherModifyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherModifyCell"];
        _otherModifyCell.textLabel.text = @"修改其他信息";
    }
    
    return _otherModifyCell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息修改";
    self.tableView.backgroundColor = [UIColor tableViewBackgroundColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 8.f;
    }
    
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* cell = nil;
    switch (row) {
        case 1:
            cell = self.phoneModifyCell;
            break;
        case 2:
            cell = self.emailModifyCell;

            break;
        case 3:
            cell = self.otherModifyCell;

            break;
        default:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"uselessCell"];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController* vc = nil;
    
    switch (indexPath.row) {
        case 1:
            vc = [[PersonalPhoneViewContoller alloc] init];
            break;
        case 2:
            vc = [[PersonalEmailModifyViewContoller alloc] init];

            break;
        case 3:
            vc = [[PersonalOtherModifyViewContoller alloc] init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
