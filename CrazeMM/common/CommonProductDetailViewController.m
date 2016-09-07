//
//  CommonDetailViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonProductDetailViewController.h"
#import "BaseProductDetailDTO.h"
#import "CommonListCell.h"
#import "OrderLogsCell.h"

@interface CommonProductDetailViewController ()

@property (nonatomic, strong) CommonListCell* productDetail;
@property (nonatomic, strong) OrderLogsCell* logsCell;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) NSArray* bottomButtons;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) UITableView* tableView;



//@property (nonatomic, strong) BaseProductDetailDTO* productDetailDto;

@property (nonatomic, readonly) NSArray* cellArray;

@end

@implementation CommonProductDetailViewController

-(NSArray*)cellArray
{
    return @[self.productDetail, self.logsCell];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"返回"];
}

-(CommonListCell*)productDetail
{
    if (!_productDetail) {
        _productDetail = (CommonListCell*)[UINib viewFromNib:@"CommonListCell"];
        _productDetail.height = [CommonListCell cellHeight];
        _productDetail.checkBox.hidden = YES;
    }
    return _productDetail;
}

-(OrderLogsCell*)logsCell
{
    if (!_logsCell) {
        _logsCell = (OrderLogsCell*)[UINib viewFromNib:@"OrderLogsCell"];
        _logsCell.backgroundColor = [UIColor clearColor];
    }
    
    return _logsCell;
}

-(NSArray*)bottomButtons
{
    if(!_bottomButtons) {
        NSMutableArray* buttons = [[NSMutableArray alloc] init];
        
        for(NSString* title in self.bottomButtonsTitle){
            UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont middleFont];
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(handleClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            [buttons addObject:button];
            [self.bottomView addSubview:button];
            [button sizeToFit];
            
        }
        _bottomButtons = buttons;
    }
    
    return _bottomButtons;
}

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f)];
        [self.view addSubview:_bottomView];
        //        [_bottomView addSubview:self.confirmButton];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView];
        
        // we hide it now
        // _bottomView.hidden = NO;
    }
    
    return _bottomView;
}

-(void)handleClickEvent:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(BaseHttpRequest*)detailHttpRequest
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    return nil;
}

-(void)refreshDetailDto
{
    if(self.detailHttpRequest){
        [self showProgressIndicatorWithTitle:@"请稍等..."];
        [self.detailHttpRequest request]
        .then(^(id responseObj){
            if (self.detailHttpRequest.response.ok) {
                [self updateDataWithResponse:self.detailHttpRequest.response];
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage:self.detailHttpRequest.response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        })
        .finally(^(){
            [self dismissProgressIndicator];
        });

    }
}

-(void)updateDataWithResponse:(BaseHttpResponse*)response
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Alert"
                                                   message:[NSString stringWithFormat:@"You should overwrite the API %@", [NSString stringWithUTF8String:__FUNCTION__]]
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor tableViewBackgroundColor];

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //self.navigationItem.title = @""
    [self refreshDetailDto];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if(self.bottomButtons.count>0){
        self.bottomView.frame = CGRectMake(0, self.view.height-44.f, self.view.bounds.size.width, 44.f);
        CGFloat rightX = self.view.bounds.size.width;
        for(UIButton* button in self.bottomButtons){
            button.height = 44.f;
            button.width = 80;
            button.right = rightX;
            button.y = 0;
            
            rightX -= button.width+1.f;
            
        }

    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count*2 + (self.bottomButtons.count>0?1:0);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell;

    if (indexPath.row == self.cellArray.count*2 || indexPath.row%2 == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoUseCell"];
        cell.backgroundColor =  RGBCOLOR(240, 240, 240);
        cell.clipsToBounds = YES;
    }
    else {
        cell = self.cellArray[indexPath.row/2];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.cellArray.count*2) {
        return self.bottomView.height;
    }
    else if(indexPath.row%2 == 0){
        return 14.f;
    }
    else {
        UITableViewCell* cell = self.cellArray[indexPath.row/2];
        return cell.height;
    }
}

@end
