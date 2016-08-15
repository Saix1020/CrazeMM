//
//  MineBuyEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineBuyEditViewController.h"
#import "HttpAddress.h"
#import "AddrRegionCell.h"
#import "AddrDefaultCheckboxCell.h"
#import "SelectionViewController.h"
#import "HttpSaveSupplyInfo.h"

@interface MineBuyEditViewController()

@property (nonatomic, strong) NSArray* addresses;

@property (nonatomic, strong) AddrRegionCell* addrCell;
//@property (nonatomic, strong) AddrDefaultCheckboxCell* otherCell;

@end


@implementation MineBuyEditViewController

-(AddrRegionCell*)addrCell
{
    if (!_addrCell) {
        _addrCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _addrCell.titleLabel.text = @"收货地址";
//        _addrCell.chooseButton.hidden = YES;
//        _addrCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        [_addrCell hideChooseButton];
    }
    
    return _addrCell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    HttpAddressRequest* request = [[HttpAddressRequest alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpAddressResponse* response = (HttpAddressResponse*)request.response;
        if (response.ok) {
            self.addresses = response.addresses;
            if (self.addresses.count>0) {
                self.addrCell.value = ((AddressDTO *)self.addresses.firstObject).address;
            }
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
    });
    
    NSMutableArray* tempArray = [self.cellArray mutableCopy];
//    tempArray[kRowStock] = self.amountCell;
    self.stockCell.titleLabel.text = @"数量";
    self.stockCell.textFieldCell.placeholder = @"请输入需求数量";
    
    self.otherCell.checkBox2.hidden = YES;
    self.otherCell.titleLabel2.hidden = YES;
    self.otherCell.titlelabel.text = @"匿名";
    
    tempArray[kRowOther] = self.addrCell;
    tempArray[kRowConfirm] = self.otherCell;
    tempArray[kRowMax] = self.confirmCell;
    
    self.cellArray = [tempArray copy];
}

//save_buy_token:4376351719679073752
//gbrand:28
//buy.gid:1670
//buy.gcolor:黑
//buy.gvolume:16G
//buy.gnetwork:电信版
//buy.isSerial:true
//buy.isOriginal:true
//buy.isOriginalBox:true
//buy.isBrushMachine:true
//buy.price:1000
//buy.quantity:20
//buy.deadline:72
//buy.duration:24
//buy.addrId:178
//buy.isAnoy:true
-(void)saveNewGood:(UIButton*)sender
{
    [self.view endEditing:YES];
    @weakify(self);
    [self showAlertViewWithMessage:@"您确认发布该求购信息吗?"
                    withOKCallback:^(id x){
                        @strongify(self);
                        GoodCreateInfo* goodCreateInfo = [[GoodCreateInfo alloc] init];
                        for (GoodBrandDTO* brandDto in self.goodBrands) {
                            if ([brandDto.name isEqualToString:self.brandCell.regionLabel.text]) {
                                goodCreateInfo.brand = brandDto.id;
                            }
                        }
                        
                        goodCreateInfo.id = self.currentGoodDetail.id;
                        goodCreateInfo.quantity = [self.stockCell.textFieldCell.text integerValue];
                        NSInteger cycleStringIndex = [self.cycleStringArray indexOfObject:self.cycleCell.regionLabel.text];
                        switch (cycleStringIndex) {
                            case 0:
                                goodCreateInfo.deadline = 24;
                                break;
                            case 1:
                                goodCreateInfo.deadline = 48;
                                break;
                            case 2:
                                goodCreateInfo.deadline = 72;
                                break;
                            default:
                                goodCreateInfo.deadline = -1;
                                break;
                        }
                        
                        goodCreateInfo.duration = self.timeCell.textFieldCell.text.integerValue;
                        goodCreateInfo.price = self.priceCell.textFieldCell.text.integerValue;
                        goodCreateInfo.color = self.colorCell.regionLabel.text;
                        goodCreateInfo.volume = self.capacityCell.regionLabel.text;
                        goodCreateInfo.network = self.standardCell.regionLabel.text;
                        goodCreateInfo.isSerial = self.hasIMEICell.swith.on;
                        goodCreateInfo.isOriginal = self.isIntactCell.swith.on;
                        goodCreateInfo.isOriginalBox = self.hasBoxCell.swith.on;
                        goodCreateInfo.isBrushMachine = self.isBrushedCell.swith.on;
                        goodCreateInfo.isAnoy = self.otherCell.checkBox.on;
                        
                        for (AddressDTO* addr in self.addresses) {
                            if([self.addrCell.value isEqualToString:addr.address]){
                                goodCreateInfo.addrId = addr.id;
                                break;
                            }
                        }
                        
                        
                        HttpSaveBuyInfoRequest* request = [[HttpSaveBuyInfoRequest alloc] initWithGoodInfo:goodCreateInfo];
                        [request request]
                        .then(^(id responseObj){
                            if (!request.response.ok) {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                            else {
                                if ([self.delegate respondsToSelector:@selector(editSupplyGoodSuccess)]) {
                                    [self showAlertViewWithMessage:@"求购信息发布成功"];
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
    return self.cellArray.count+ 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == kRowOther) {
        self.editingRow = kRowOther;
        [self.selectionDataSource removeAllObjects];
        NSInteger selectedIndex = NSNotFound;
        
        for (NSInteger i=0; i<self.addresses.count; i++) {
            if([((AddressDTO*)self.addresses[i]).address isEqualToString:self.addrCell.value]){
                selectedIndex = i;
            }
            [self.selectionDataSource addObject:((AddressDTO*)self.addresses[i]).address];
        }
        SelectionViewController* selectionVC = [[SelectionViewController alloc] initWithDataSource:self.selectionDataSource andSelectedIndex:selectedIndex andTitle:@"请选收货地址"];
        selectionVC.delegate = self;
        
        [self.navigationController pushViewController:selectionVC animated:YES];
    }
    else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case kRowOther:
            return 44.f;
            break;
        case kRowConfirm:
            return 44.f;
            break;
        case kRowMax:
            return 56.f;
            break;
            
        default:
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}

#pragma -- mark SelectionViewControllerDelegate
-(void)didSelectItemWithTitle:(NSInteger)selectedIndex
{
    if(self.editingRow == kRowOther){
        self.addrCell.value = ((AddressDTO *)self.addresses[selectedIndex]).address;
    }
    else {
        [super didSelectItemWithTitle:selectedIndex];
    }
}

@end
