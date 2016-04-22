//
//  MineViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "AvataCell.h"

typedef NS_ENUM(NSInteger, MineTableViewSection){
    kSectionOverview = 0,
    kSectionInfo,
    kSectionContact,
    kSectionMax
};


@interface MineViewController()

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) AvataCell* avataCell;


@end

@implementation MineViewController


-(AvataCell*)avataCell
{
    if(!_avataCell){
        _avataCell = [[[NSBundle mainBundle]loadNibNamed:@"AvataCell" owner:nil options:nil] firstObject];
    }
    
    return _avataCell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Mine";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    

}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    //[self.avataCell backgroundColorFrom:RGBCOLOR(230, 0, 0) To:RGBCOLOR(255, 255, 255)];

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setTabBarHidden:NO animated:YES];
    
}

#pragma -- mark tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionMax;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case kSectionOverview:
        {
            switch (row) {
                case 0:
                    return 110;
                case 1:
                    return 64;
                case 2:
                    return 32;
                    
                default:
                    break;
            }
        }
            break;
        case kSectionInfo:
        {
            return 44.f;
        }
            break;
        case kSectionContact:
        {
            return 40.f;
        }
            break;
            
        default:
            break;
    }
    
    
    return 44.f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"BuyItemCell" owner:nil options:nil] firstObject];
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section %lu, row %lu", indexPath.section, indexPath.row];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case kSectionOverview:
        {
            switch (row) {
                case 0:
                    return self.avataCell;
                case 1:
                    return cell;
                case 2:
                    return cell;
                    
                default:
                    break;
            }
        }
            break;
        case kSectionInfo:
        {
            return cell;
        }
            break;
        case kSectionContact:
        {
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kSectionOverview:
            return 3;
        case kSectionInfo:
            return 5;
        case kSectionContact:
            return 1;
        default:
            break;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == kSectionOverview) {
        return 0.f;
    }

    return 12.f;
}



@end
