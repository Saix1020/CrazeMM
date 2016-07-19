//
//  MineStockEditViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineStockEditViewController.h"
#import "AddrRegionCell.h"
#import "AddrDefaultCheckboxCell.h"
#import "SelectionViewController.h"
#import "HttpSaveSupplyInfo.h"
#import "HttpStock.h"
#import "HttpGoodInfoQuery.h"

@interface MineStockEditViewController ()

@property (nonatomic, strong) NSArray* depots;
@property (nonatomic, strong) AddrRegionCell* depotCell;
@end

@implementation MineStockEditViewController

- (AddrRegionCell*) depotCell
{
    if (!_depotCell) {
        _depotCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _depotCell.titleLabel.text = @"仓库";
    }
    return _depotCell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新建库存信息";

    
    HttpDepotQueryRequest *request = [[HttpDepotQueryRequest alloc]init];
    [request request]
    .then(^(id responseObj){
        HttpDepotQueryResponse *response = (HttpDepotQueryResponse*)request.response;
        if (response.ok) {
            self.depots = response.depotDtos;
            if (self.depots.count>0) {
              self.depotCell.value = ((DepotDTO *)self.depots.firstObject).name;
            }
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });

    /*
     仓库
     品牌
     型号
     颜色
     制式
     容量
     带串码
     原封
     原封箱
     已刷机
     库存： 请输入库存数量
     原价： 请输入入手单价
     提交
    */
    self.stockCell.titleLabel.text = @"库存";
    self.stockCell.textFieldCell.placeholder = @"请输入库存数量";
    self.priceCell.titleLabel.text = @"原价";
    self.priceCell.textFieldCell.placeholder = @"请输入入手单价";
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithObjects:
                                 self.depotCell,
                                 self.brandCell,
                                 self.modelCell,
                                 self.colorCell,
                                 self.standardCell,
                                 self.capacityCell,
                                 self.hasIMEICell,
                                 self.isIntactCell,
                                 self.hasBoxCell,
                                 self.isBrushedCell,
                                 self.stockCell,
                                 self.priceCell,
                                 self.confirmCell, nil
                                 ];
    /*
    tempArray[kRowBrand] = self.depotCell;
    tempArray[kRowModel] = self.brandCell;
    tempArray[kRowColor] = self.modelCell;
    tempArray[kRowStandard] = self.standardCell;
    tempArray[kRowCapacity] = self.colorCell;
    tempArray[kRowHasIMEI] = self.capacityCell;
    tempArray[kRowIsIntact] = self.hasIMEICell;
    tempArray[kRowHasBox] = self.isIntactCell;
    tempArray[kRowIsBrushed] = self.hasBoxCell;
    tempArray[kRowStock] = self.isBrushedCell;
    tempArray[kRowCycle] = self.stockCell;
    tempArray[kRowTime] = self.priceCell;
    tempArray[kRowOther] = self.confirmCell;
     */
    self.cellArray = [tempArray copy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)saveNewGood:(UIButton*)sender
{
    [self.view endEditing:YES];
    @weakify(self);
    [self showAlertViewWithMessage:@"您确认提交该条库存记录吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        GoodCreateInfo* goodCreateInfo = [[GoodCreateInfo alloc] init];
                        
                        for (DepotDTO* depotDto in self.depots) {
                            if ([depotDto.name isEqualToString:self.depotCell.regionLabel.text]) {
                                goodCreateInfo.depotId = depotDto.id;
                            }
                        }
                        for (GoodBrandDTO* brandDto in self.goodBrands) {
                            if ([brandDto.name isEqualToString:self.brandCell.regionLabel.text]) {
                                goodCreateInfo.brand = brandDto.id;
                            }
                        }
                        
                        goodCreateInfo.id = self.currentGoodDetail.id;
                       
                        goodCreateInfo.color = self.colorCell.regionLabel.text;
                        goodCreateInfo.volume = self.capacityCell.regionLabel.text;
                        goodCreateInfo.network = self.standardCell.regionLabel.text;
                        goodCreateInfo.isSerial = self.hasIMEICell.swith.on;
                        goodCreateInfo.isOriginal = self.isIntactCell.swith.on;
                        goodCreateInfo.isOriginalBox = self.hasBoxCell.swith.on;
                        goodCreateInfo.isBrushMachine = self.isBrushedCell.swith.on;
                        goodCreateInfo.quantity = self.stockCell.textFieldCell.text.integerValue;
                        goodCreateInfo.price = self.priceCell.textFieldCell.text.integerValue;
                        
                        
                        HttpSaveStockInfoRequest* request = [[HttpSaveStockInfoRequest alloc] initWithGoodInfo:goodCreateInfo];
                        [request request]
                        .then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                if ([self.delegate respondsToSelector:@selector(editSupplyGoodSuccess)]) {
                                    [self showAlertViewWithMessage:@"库存信息发布成功"];
                                    [self.delegate editSupplyGoodSuccess];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                        
                    }
                 andCancelCallback:^(id x){
                     
                 }];
    
    
}

#pragma -- mark tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.cellArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row >= self.cellArray.count) {
            return 30.f;
        }
        else if (indexPath.row == kRowOther) {
            return 56.f;
        }
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionViewController* selectionVC;
    self.editingRow = indexPath.row;
    [self.selectionDataSource removeAllObjects];
    NSInteger selectedIndex = NSNotFound;
    NSInteger index;
    
    switch (indexPath.row) {
            
        case kRowBrand:
        {
            for (index=0; index<self.depots.count; ++index) {
                DepotDTO* dto = self.depots[index];
                [self.selectionDataSource addObject:dto.name];
                if ([dto.name isEqualToString:self.depotCell.regionLabel.text]) {
                    selectedIndex = index;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择仓库"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
            
        }
            break;
            
        case kRowModel:
        {
            for (index=0; index<self.goodBrands.count; ++index) {
                GoodBrandDTO* dto = self.goodBrands[index];
                [self.selectionDataSource addObject:dto.name];
                if ([dto.name isEqualToString:self.brandCell.regionLabel.text]) {
                    selectedIndex = index;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择品牌"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
            
        case kRowColor:
        {
            if (!self.enableSubEdit) {
                break;
            }
            for (index=0; index<self.goodInfos.count; ++index) {
                GoodInfoDTO* dto = self.goodInfos[index];
                [self.selectionDataSource addObject:dto.model];
                if ([dto.model isEqualToString:self.modelCell.regionLabel.text]) {
                    selectedIndex = index;
                }
            }
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选择型号"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
        case kRowStandard:
        {
            if (!self.enableSubEdit) {
                break;
            }
            for (index=0; index<self.currentGoodDetail.color.count; ++index) {
                
                if ([self.currentGoodDetail.color[index] isEqualToString:self.colorCell.regionLabel.text]) {
                    selectedIndex = index;
                    break;
                }
            }
            
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.color andSelectedIndex:selectedIndex andTitle:@"请选择颜色"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
            
        }
            break;
        case kRowCapacity:
        {
            if (!self.enableSubEdit) {
                break;
            }
            selectedIndex = [self.currentGoodDetail.network indexOfObject:self.standardCell.regionLabel.text];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.network andSelectedIndex:selectedIndex andTitle:@"请选择制式"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
        case kRowHasIMEI:
        {
            if (!self.enableSubEdit) {
                break;
            }
            selectedIndex = [self.currentGoodDetail.volume indexOfObject:self.capacityCell.regionLabel.text];
            selectionVC = [[SelectionViewController alloc] initWithDataSource:self.currentGoodDetail.volume andSelectedIndex:selectedIndex andTitle:@"请选择容量"];
            selectionVC.delegate = self;
            
            [self.navigationController pushViewController:selectionVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}


#pragma -- mark SelectionViewControllerDelegate
-(void)didSelectItemWithTitle:(NSInteger)selectedIndex
{
    switch (self.editingRow) {
        case kRowBrand:
        {
            self.depotCell.value = ((DepotDTO *)self.depots[selectedIndex]).name;
        }
            break;
        case kRowModel:
        {
            GoodBrandDTO* dto = self.goodBrands[selectedIndex];
            self.brandCell.regionLabel.text = dto.name;
            HttpGoodInfoQueryRequest* request = [[HttpGoodInfoQueryRequest alloc] initWithBrandId:dto.id];
            self.enableSubEdit = NO;
            [request request]
            .then(^(id responseObj){
                NSLog(@"%@", responseObj);
                HttpGoodInfoQueryResponse* response = (HttpGoodInfoQueryResponse*)request.response;
                if (response.ok) {
                    self.goodInfos = response.goodDtos;
                    if (self.goodInfos.count>0) {
                        self.currentGoodDetail = self.goodInfos.firstObject;
                        self.enableSubEdit = YES;
                    }
                }
            })
            .catch(^(NSError* error){
                [self showAlertViewWithMessage:error.localizedDescription];
            });
        }
            break;
            
        case kRowColor:
        {
            self.currentGoodDetail = self.goodInfos[selectedIndex];
        }
            break;
            
        case kRowStandard:
        {
            self.colorCell.regionLabel.text = self.currentGoodDetail.color[selectedIndex];
        }
            break;
            
        case kRowCapacity:
        {
            self.standardCell.regionLabel.text = self.currentGoodDetail.network[selectedIndex];
        }
            break;
        case kRowHasIMEI:
        {
            self.capacityCell.regionLabel.text = self.currentGoodDetail.volume[selectedIndex];
        }
            break;
        default:
            break;
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
