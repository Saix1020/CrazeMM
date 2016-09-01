//
//  NewOrderListViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NewOrderListViewController.h"
#import "OrderListFilterViewController.h"
#import "AllOrderListFilterViewController.h"
#import "TTModalView.h"

@interface NewOrderListViewController ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) TTModalView *modalView;
@property (nonatomic, strong) UINavigationController *modalNav;

@property (nonatomic, strong) UIButton* filterButton;
@property (nonatomic) UIView* emptyView;

@property (nonatomic, strong) NSDictionary* searchConditions;
@end

@implementation NewOrderListViewController

@synthesize filterVC = _filterVC;

-(UIView*)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.6];
        
    }
    return _maskView;
}

-(TTModalView*)modalView
{
    if (!_modalView) {
        _modalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
        _modalView.modalWindowLevel = UIWindowLevelNormal;
        _modalView.isCancelAble = NO;
        
        _modalView.contentView = self.modalNav.view;
        
        _modalView.presentAnimationStyle = SlideInRight;
        _modalView.dismissAnimationStyle = SlideOutRight ;
        
    }
    
    return _modalView;
}

-(UINavigationController*)modalNav
{
    if (!_modalNav) {
        _modalNav = [[UINavigationController alloc] initWithRootViewController:self.filterVC];
    }
    return _modalNav;
}

-(OrderListFilterViewController*)filterVC
{
    if (!_filterVC) {
        _filterVC = [[OrderListFilterViewController alloc] init];
        _filterVC.delegate = self;
        
    }
    return _filterVC;
}

-(UIView*)emptyView
{
    if (!_emptyView){
        _emptyView = [UINib viewFromNib:@"SearchEmpty"];
        _emptyView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.view addSubview:_emptyView];
        _emptyView.backgroundColor = [UIColor clearColor];
        _emptyView.hidden = YES;
    }
    
    return _emptyView;
}

-(NSArray*)operatorDtoIds
{
    NSMutableArray* operatorDtoIds = [[NSMutableArray alloc] init];
    
    for (OrderDetailDTO* dto in self.selectedData) {
        if (dto.selected) {
            [operatorDtoIds addObject:[NSString stringWithFormat:@"%ld", dto.id]];
        }
    }
    return operatorDtoIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.autoRefresh = NO;
    self.usingDefaultCell = YES;

    
    self.filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.filterButton setImage:[@"filter" image] forState:UIControlStateNormal];
    self.filterButton.frame = CGRectMake(0, 0, 24, 24);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.filterButton];
    
    
    @weakify(self);
    self.filterButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
        @strongify(self);
        [self.view addSubview:self.maskView];
        [self.modalView showWithDidAddContentBlock:^(UIView *contentView) {
            contentView.frame = CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-50, [UIScreen mainScreen].bounds.size.height);
        }];
        return [RACSignal empty];
    }];
    
    [self resetDataSource];
}

-(HttpListQueryRequest*)makeListQueryRequest
{
    return [[HttpOrderRequest alloc]  initWithOrderListType:self.orderListStyle andPage:self.pageNumber+1 andConditions:self.searchConditions];
}


#pragma - mark OrderListFilterViewController Delegate
-(void)dismiss
{
    [self.modalView dismiss];
    [self.maskView removeFromSuperview];
}

-(void)didSetSerachConditions:(NSDictionary *)conditions
{
    self.searchConditions = conditions;
    [self resetDataSource];
}


#pragma -- mark custom segment delegate

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index
{
    self.searchConditions = nil;
    [self.filterVC resetSearchCond];
    [super segment:segment didSelectAtIndex:index];
    
}

#pragma -- make OrderDetailViewController delegate
-(void)removeOrder:(OrderDetailDTO *)orderDto
{
    if(self.dataSource){
        [self.dataSource removeObject:orderDto];
        [self.tableView reloadData];
        [self updateBottomView];
    }
}

-(void)cancelOrder:(OrderDetailDTO *)orderDto
{
    if(self.dataSource){
        [self.dataSource removeObject:orderDto];
        [self.tableView reloadData];
        [self updateBottomView];
    }
}

-(void)operatorDoneForOrder:(NSArray *)orderDtos
{
    if(self.dataSource){
        [self.dataSource removeObjectsInArray:orderDtos];
        [self.tableView reloadData];
        [self updateBottomView];
    }
}

#pragma - mark Async http request
-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest andConfirmTitle:(NSString *)confirmTitle andSuccessTitle:(NSString *)successTitle
{
    @weakify(self);
    [self showAlertViewWithMessage:confirmTitle
                    withOKCallback:^(id x){
                        @strongify(self);
                        [httpRequest request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (httpRequest.response.ok) {
                                for (OrderDetailDTO* dto in self.selectedData){
                                    [self.dataSource removeObject:dto];
                                }
                                [self.tableView reloadData];
                                [self showAlertViewWithMessage:successTitle];
                            }
                            else {
                                [self showAlertViewWithMessage:httpRequest.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                 andCancelCallback:nil];
}


#pragma  - mark tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 == 0) {
        
    }
    else if(indexPath.row == self.dataSource.count*2) {
        
    }
    else {
        [self tableViewCellSelected:tableView andIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableViewCellSelected:(UITableView*)tableView andIndexPath:(NSIndexPath*)indexPath
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

@end
