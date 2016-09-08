//
//  AllOrderListViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AllOrderListViewController.h"
#import "MJRefresh.h"
#import "HttpOrder.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"

@interface AllOrderListViewController ()

@property (nonatomic) MMOrderType orderType;

@property (nonatomic) NSInteger orderListPageNumber;
@property (nonatomic) NSInteger orderListTotalPage;

@property (nonatomic) BOOL isRefreshing;
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation AllOrderListViewController


-(instancetype)initWithOrderType:(MMOrderType)orderType
{
    self = [super init];
    if (self) {
        self.orderType = orderType;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.orderType==kOrderTypeBuy? @"我的所有买货" : @"我的所有卖货";
}

-(BOOL)needSegmentCell
{
    return NO;
}

-(BOOL)needCommonBottomView
{
    return NO;
}

-(AnyPromise*)getOrderList
{
    HttpOrderRequest* orderRequest;
    if (self.orderType == kOrderTypeBuy) {
        
        orderRequest = [[HttpAllBuyOrderRequest alloc] initWithPage:self.orderListPageNumber+1 andConditions:self.searchConditions];
    }
    else {
        orderRequest = [[HttpAllSupplyOrderRequest alloc] initWithPage:self.orderListPageNumber+1 andConditions:self.searchConditions];
    }
    
    
    return [orderRequest request]
    .then(^(id responseObject){
        NSLog(@"%@", responseObject);
        HttpOrderResponse* response = (HttpOrderResponse*)orderRequest.response;
        if (response.ok) {
            self.orderListTotalPage = response.totalPage;
            if (self.orderListPageNumber < self.orderListTotalPage) {
                self.orderListPageNumber = response.pageNumber;
            }
            if (response.orderDetailDTOs.count > 0) {
                [self.dataSource addObjectsFromArray:response.orderDetailDTOs];
                [self.tableView reloadData];
            }
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.tabBarController setTabBarHidden:YES animated:YES];
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailDTO* dto = (OrderDetailDTO*)self.dataSource[indexPath.row];
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    cell.hiddenCheckbox = YES;
    cell.orderDetailDTO = dto;
    cell.reactiveButton.hidden = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrderListCell cellHeight]; //WaitForDeliverCell has the same height with WaitForPayCell
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMOrderListStyle style = {
        .orderType = self.orderType,
        .orderSubType = kOrderSubTypeAll
    };
    OrderDetailViewController* orderDetailVC = [[OrderDetailViewController alloc] initWithOrderStyle:style andOrder:self.dataSource[indexPath.row]];
    orderDetailVC.delegate = self;
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
