//
//  MineBuyViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineBuyViewController.h"
#import "SegmentedCell.h"
#import "CommonBottomView.h"
#import "SupplyListCell.h"
#import "HttpMineSupply.h"
#import "MineSupplyProductDTO.h"
#import "HttpMineSupplyShelve.h"
#import "MineBuyEditViewController.h"


@interface MineBuyViewController()

@property (nonatomic) SupplyListCellStyle cellStyle;
//@property (nonatomic, strong) NSMutableArray* dataSource;

@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;

@property (nonatomic) BOOL isShelving;

@end

@implementation MineBuyViewController

-(SegmentedCell*)segmentCell
{
    if (!_segmentCell) {
        SegmentedCell* cell = [super segmentCell];
        [cell setTitles:@[@"正常", @"下架", @"成交"]];
    }
    return _segmentCell;
}

-(CommonBottomView*)bottomView
{
    if(!_bottomView){
        _bottomView = [super bottomView];
        [_bottomView.confirmButton setTitle:@"批量下架" forState:UIControlStateNormal];
        [_bottomView.totalPriceLabel setText:@""];
        
    }
    
    return _bottomView;
}




-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的求购";
    self.view.backgroundColor = [UIColor light_Gray_Color];
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[@"addr_add_icon" image] style:UIBarButtonItemStylePlain target:self action:@selector(addBuy:)];
    
    self.isShelving = NO;
    self.pageNumber = 0;
    [self getMineBuy];
}

-(void)addBuy:(id)sender
{
    MineBuyEditViewController* editVC = [[MineBuyEditViewController alloc] init];
    editVC.delegate = self;
    [self.navigationController pushViewController:editVC animated:YES];
}

-(AnyPromise*)handleHeaderRefresh
{
    return [self getMineBuy];
}

-(AnyPromise*)handleFooterRefresh
{
    return [self getMineBuy];
}

-(void)bottomViewButtonClicked:(UIButton*)button
{
    if (button == self.bottomView.confirmButton) {
        switch (self.cellStyle) {
            case kNomalStyle:
                [self unshelveProducts];
                break;
            case kOffShelfStyle:
                [self reshelveProducts];
                break;
            case kDealStyle:
                break;
            default:
                break;
        }
    }
    
}

-(void)reshelveProducts
{
    if (self.isShelving) {
        [self showAlertViewWithMessage:@"你还不能上架该求购"];
        return;
    }
    NSMutableArray* selectedDtos = [[NSMutableArray alloc] init];
    NSMutableArray* selectedIds = [[NSMutableArray alloc] init];
    
    for (MineSupplyProductDTO* dto in self.dataSource) {
        if (dto.selected) {
            [selectedDtos addObject:dto];
            [selectedIds addObject:@(dto.id)];
        }
    }
    
    HttpMineBuyReshelveRequest *request = [[HttpMineBuyReshelveRequest alloc] initWithIds:selectedIds];
    self.isShelving = YES;
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            for (MineSupplyProductDTO* dto in selectedDtos) {
                [self.dataSource removeObject:dto];
            }
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        self.isShelving = NO;
    });
}

-(void)reshelveProductsWithSid:(NSInteger)sid
{
    if (self.isShelving) {
        [self showAlertViewWithMessage:@"你还不能上架该求购"];
        return;
    }
    NSMutableArray* selectedDtos = [[NSMutableArray alloc] init];
    NSArray* selectedIds = @[@(sid)];
    
    for (MineSupplyProductDTO* dto in self.dataSource) {
        if (sid == dto.id) {
            [selectedDtos addObject:dto];
            break;
        }
    }
    
    HttpMineBuyReshelveRequest *request = [[HttpMineBuyReshelveRequest alloc] initWithIds:selectedIds];
    self.isShelving = YES;
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            for (MineSupplyProductDTO* dto in selectedDtos) {
                [self.dataSource removeObject:dto];
            }
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        self.isShelving = NO;
    });
}

-(void)unshelveProducts
{
    if (self.isShelving) {
        [self showAlertViewWithMessage:@"你还不能下架该求购"];
        return;
    }
    
    
    NSMutableArray* selectedDtos = [[NSMutableArray alloc] init];
    NSMutableArray* selectedIds = [[NSMutableArray alloc] init];
    
    for (MineSupplyProductDTO* dto in self.dataSource) {
        if (dto.selected) {
            [selectedDtos addObject:dto];
            [selectedIds addObject:@(dto.id)];
        }
    }
    
    HttpMineBuyUnshelveRequest *request = [[HttpMineBuyUnshelveRequest alloc] initWithIds:selectedIds];
    
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            for (MineSupplyProductDTO* dto in selectedDtos) {
                [self.dataSource removeObject:dto];
            }
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        self.isShelving = NO;
    });
}
-(void)unshelveProductsWithSid:(NSInteger)sid
{
    if (self.isShelving) {
        [self showAlertViewWithMessage:@"你还不能下架该求购"];
        return;
    }
    
    
    NSMutableArray* selectedDtos = [[NSMutableArray alloc] init];
    NSArray* selectedIds = @[@(sid)];
    
    for (MineSupplyProductDTO* dto in self.dataSource) {
        if (sid == dto.id) {
            [selectedDtos addObject:dto];
            break;
        }
    }
    
    HttpMineBuyUnshelveRequest *request = [[HttpMineBuyUnshelveRequest alloc] initWithIds:selectedIds];
    
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        if (request.response.ok) {
            for (MineSupplyProductDTO* dto in selectedDtos) {
                [self.dataSource removeObject:dto];
            }
            [self.tableView reloadData];
        }
        else {
            [self showAlertViewWithMessage:request.response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    })
    .finally(^(){
        self.isShelving = NO;
    });
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    
    if(!cell) {
        // we should use this style for cell reuse to support iOS8
        cell = [tableView dequeueReusableCellWithIdentifier:@"SupplyListCell"];
        if (cell==nil) {
            cell= [[[NSBundle mainBundle]loadNibNamed:@"SupplyListCell" owner:nil options:nil] firstObject];
        }
        ((SupplyListCell*)cell).style = self.cellStyle;
        ((SupplyListCell*)cell).mineSupplyProductDto = self.dataSource[indexPath.row/2];
        ((SupplyListCell*)cell).selectCheckBox.tag = 10000 + indexPath.row/2;
        ((SupplyListCell*)cell).selectCheckBox.delegate = self;
        ((SupplyListCell*)cell).delegate = self;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row %2 == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    else {
//        if (self.segmentCell.segment.currentIndex != 2) {
//            return [SupplyListCell cellHeight] - 10;
//            
//        }
//        else {
//            return [SupplyListCell cellHeight] ;
//        }
        return [SupplyListCell cellHeight] - 16.f;
        
    }
}

-(AnyPromise*)getMineBuy
{
    
    HttpMineSupplyRequest * request = [[HttpMineBuyRequest alloc]init];
    
    switch (self.cellStyle) {
        case kNomalStyle:
            request = [[HttpMineBuyRequest alloc] initStateNomalWithPageNumber:self.pageNumber+1];
            break;
        case kOffShelfStyle:
            request = [[HttpMineBuyRequest alloc] initStateOffShelfWithPageNumber:self.pageNumber+1];
            break;
        case kDealStyle:
            request = [[HttpMineBuyRequest alloc] initStateSoldOutWithPageNumber:self.pageNumber+1];
            break;
        default:
            break;
    }
    
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpMineBuyResponse* response = (HttpMineBuyResponse*)request.response;
        if (response.ok) {
            if (response.productDTOs.count>0) {
                [self.dataSource addObjectsFromArray:response.productDTOs];
                self.totalPage = response.totalPage;
                self.pageNumber = response.pageNumber>=self.totalPage?self.totalPage:response.pageNumber;
                [self.tableView reloadData];
                self.bottomView.selectAllCheckBox.on = NO;                
            }
            
        }
        else{
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
        
    });
}

- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index;
{
    if (segment.prevIndex == index) {
        return;
    }
    
    if (index == 0) {
        self.bottomView.hidden = NO;
        self.cellStyle = kNomalStyle;
        [self.bottomView.confirmButton setTitle:@"批量下架" forState:UIControlStateNormal];
    }
    else if(index==1){
        self.bottomView.hidden = NO;
        self.cellStyle = kOffShelfStyle;
        [self.bottomView.confirmButton setTitle:@"批量上架" forState:UIControlStateNormal];
        
    }
    else {
        self.bottomView.hidden = YES;
        self.cellStyle = kDealStyle;
        [self.bottomView.confirmButton setTitle:@"批量删除" forState:UIControlStateNormal];
        
    }
    self.bottomView.selectAllCheckBox.on = NO;
    
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    
    self.pageNumber = 0;
    [self getMineBuy];
}

#pragma -- mark BEMCheckBox Delegate
-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if (checkBox != self.bottomView.selectAllCheckBox) {
        NSInteger index = checkBox.tag - 10000;
        MineSupplyProductDTO* dto = self.dataSource[index];
        dto.selected = checkBox.on;
        
        NSArray* onArray = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.selected != NO"]];
        if (onArray.count == self.dataSource.count) {
            self.bottomView.selectAllCheckBox.on = YES;
        }
        else {
            self.bottomView.selectAllCheckBox.on = NO;
        }
    }
    else {
        for (NSInteger index = 0; index<self.dataSource.count; ++index) {
            MineSupplyProductDTO* dto = self.dataSource[index];
            dto.selected = checkBox.on;
        }
        [self.tableView reloadData];
    }
    
}

#pragma -- mark SupplyListCell delegate
-(void)buttonClicked:(UIButton *)sender andType:(SupplyListCellStyle)type andSid:(NSInteger)sid
{
    switch (type) {
        case kNomalStyle: //unshelve
            [self unshelveProductsWithSid:sid];
            break;
        case kOffShelfStyle: //reshelve
            [self reshelveProductsWithSid:sid];
            break;
            
        case kUnkonwStyle: //share
        default:
            break;
    }
}

#pragma -- mark MineSupplyEditViewController Delegate
-(void)editSupplyGoodSuccess
{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    
    self.pageNumber = 0;
    [self getMineBuy];
    
}

@end

