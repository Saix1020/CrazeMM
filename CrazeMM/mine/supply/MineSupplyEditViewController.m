//
//  MineSupplyEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/5/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSupplyEditViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SwitchCell.h"
#import "AddrDefaultCheckboxCell.h"
#import "ZZPopoverWindow.h"
#import "HttpGoodInfoQuery.h"


typedef NS_ENUM(NSInteger, AddrEditingTableViewRow){
    kRowBrand = 0,
    kRowModel = 1,
    kRowColor,
    kRowStandard,
    kRowCapacity,
    kRowHasIMEI,
    kRowIsIntact,
    kRowHasBox,
    kRowIsBrushed,
    kRowPrice,
    kRowStock,
    kRowCycle,
    kRowTime,
    kRowOther,
    kRowConfirm,
    kRowMax
};


@interface MineSupplyEditViewController()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) AddrRegionCell* brandCell; //we use AddrRegionCell here for they has the same style
@property (nonatomic, strong) AddrRegionCell* modelCell;
@property (nonatomic, strong) AddrRegionCell* standardCell;
@property (nonatomic, strong) AddrRegionCell* colorCell;
@property (nonatomic, strong) AddrRegionCell* capacityCell;
@property (nonatomic, strong) SwitchCell* hasIMEICell;
@property (nonatomic, strong) SwitchCell* isIntactCell;
@property (nonatomic, strong) SwitchCell* hasBoxCell;
@property (nonatomic, strong) SwitchCell* isBrushedCell;

@property (nonatomic, strong) AddrCommonCell* priceCell;
@property (nonatomic, strong) AddrCommonCell* stockCell;

@property (nonatomic, strong) AddrRegionCell* cycleCell;
@property (nonatomic, strong) AddrCommonCell* timeCell;
@property (nonatomic, strong) AddrDefaultCheckboxCell* otherCell;
@property (nonatomic, strong) NSArray* cellArray;


@property (nonatomic, strong) UITableView* selectionTableView;
@property (nonatomic, strong) NSMutableArray* selectionDataSource;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@end

@implementation MineSupplyEditViewController

-(UITableViewCell*)confirmCell
{
    if (!_confirmCell) {
        _confirmCell = [[UITableViewCell alloc] init];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.frame = CGRectMake(16.f, 16.f, [UIScreen mainScreen].bounds.size.width-16.f*2, 40.f);
        _confirmButton.backgroundColor = [UIColor light_Gray_Color];
        [_confirmCell addSubview:self.confirmButton];
    }
    
    return _confirmCell;
}


-(AddrRegionCell*)brandCell
{
    if (!_brandCell) {
        _brandCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _brandCell.titleLabel.text = @"品牌";
        
        [_brandCell.chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _brandCell;
}
-(AddrRegionCell*)modelCell
{
    if (!_modelCell) {
        _modelCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _modelCell.titleLabel.text = @"型号";
        [_modelCell.chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _modelCell;
}
-(AddrRegionCell*)standardCell
{
    if (!_standardCell) {
        _standardCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _standardCell.titleLabel.text = @"制式";
        [_standardCell.chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _standardCell;
}
-(AddrRegionCell*)colorCell
{
    if (!_colorCell) {
        _colorCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _colorCell.titleLabel.text = @"颜色";
        [_colorCell.chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _colorCell;
}
-(AddrRegionCell*)capacityCell
{
    if (!_capacityCell) {
        _capacityCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _capacityCell.titleLabel.text = @"容量";
        [_capacityCell.chooseButton addTarget:self action:@selector(chooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _capacityCell;
}
-(AddrRegionCell*)cycleCell
{
    if (!_cycleCell) {
        _cycleCell = (AddrRegionCell*)[UINib viewFromNib:@"AddrRegionCell"];
        _cycleCell.titleLabel.text = @"周期";
    }
    
    return _cycleCell;
}

-(SwitchCell*)hasIMEICell
{
    if(!_hasIMEICell){
        _hasIMEICell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _hasIMEICell.titleLabel.text = @"带串码";
        _hasIMEICell.swith.on = YES;
    }
    
    return _hasIMEICell;
}

-(SwitchCell*)isIntactCell
{
    if(!_isIntactCell){
        _isIntactCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _isIntactCell.titleLabel.text = @"原封";
        _isIntactCell.swith.on = YES;
    }
    
    return _isIntactCell;
}
-(SwitchCell*)hasBoxCell
{
    if(!_hasBoxCell){
        _hasBoxCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _hasBoxCell.titleLabel.text = @"原封箱";
        _hasBoxCell.swith.on = YES;
    }
    
    return _hasBoxCell;
}
-(SwitchCell*)isBrushedCell
{
    if(!_isBrushedCell){
        _isBrushedCell = (SwitchCell*)[UINib viewFromNib:@"SwitchCell"];
        _isBrushedCell.titleLabel.text = @"已刷机";
        _isBrushedCell.swith.on = NO;
    }
    
    return _isBrushedCell;
}

-(AddrCommonCell*)priceCell
{
    if (!_priceCell) {
        _priceCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _priceCell.titleLabel.text = @"单价";
        _priceCell.textFieldCell.placeholder = @"请输入单台价格";
    }
    
    return _priceCell;
}
-(AddrCommonCell*)stockCell
{
    if (!_stockCell) {
        _stockCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _stockCell.titleLabel.text = @"库存";
        _stockCell.textFieldCell.placeholder = @"请输入库存数量";
    }
    
    return _stockCell;
}
-(AddrCommonCell*)timeCell
{
    if (!_timeCell) {
        _timeCell = (AddrCommonCell*)[UINib viewFromNib:@"AddrCommonCell"];
        _timeCell.titleLabel.text = @"供货周期";
        _timeCell.textFieldCell.placeholder = @"请输入小时数";
    }
    
    return _timeCell;
}

-(AddrDefaultCheckboxCell*)otherCell
{
    if (!_otherCell) {
        _otherCell = (AddrDefaultCheckboxCell*)[UINib viewFromNib:@"AddrDefaultCheckboxCell"];
        _otherCell.titleLabel2.hidden = NO;
        _otherCell.checkBox2.hidden = NO;
        
        _otherCell.titlelabel.text = @"可拆分";
        _otherCell.titleLabel2.text = @"匿名";
        _otherCell.checkBox.on = NO;
        _otherCell.checkBox2.on = NO;

    }
    
    return _otherCell;
}


-(UITableView*)selectionTableView
{
    if (!_selectionTableView) {
        _selectionTableView = [[UITableView alloc] init];
        _selectionTableView.backgroundColor = [UIColor whiteColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_selectionTableView setTableFooterView:view];
        _selectionTableView.delegate = self;
        _selectionTableView.dataSource = self;
    }
    
    return _selectionTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"新建供货信息";
    
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = self.view.frame;
    
    self.cellArray = @[
                       self.brandCell,
                       self.modelCell,
                       self.colorCell,
                       self.standardCell,
                       self.capacityCell,
                       self.hasIMEICell,
                       self.isIntactCell,
                       self.hasBoxCell,
                       self.isBrushedCell,
                       self.priceCell,
                       self.stockCell,
                       self.cycleCell,
                       self.timeCell,
                       self.otherCell,
                       self.confirmCell
                       ];
}


-(void)chooseButtonClicked:(UIButton*)sender
{
    if (sender == self.brandCell.chooseButton) {
        
    }
    else if(sender == self.modelCell.chooseButton){
        
    }
    else if(sender == self.colorCell.chooseButton){
        
    }
    else if(sender == self.standardCell.chooseButton){
        
    }
    else if(sender == self.capacityCell.chooseButton){
        
    }
    else if(sender == self.cycleCell.chooseButton){
        
    }
    self.selectionDataSource = [@[@"1111", @"22222", @"3333"] mutableCopy];
    CGFloat height = self.selectionDataSource.count*44.f;
    if (height>400.f) {
        height = 400.f;
    }
    self.selectionTableView.frame = CGRectMake(8.f, 0, sender.superview.frame.size.width-8.f, self.selectionDataSource.count*44.f);
    //        self.suggestVC.view.backgroundColor = RGBCOLOR(150, 150, 150);
    self.popover                    = [[ZZPopoverWindow alloc] init];
    self.popover.popoverPosition = ZZPopoverPositionDown;
    self.popover.contentView        = self.selectionTableView;
    self.popover.animationSpring = NO;
    //        self.popover.backgroundColor = RGBCOLOR(150, 150, 150);
    self.popover.showArrow = NO;
    self.popover.didShowHandler = ^() {
        //self.popover.layer.cornerRadius = 0;
    };
    self.popover.didDismissHandler = ^() {
        //NSLog(@"Did dismiss");
    };
    
    [self.popover showAtView:sender.superview];

}

#pragma -- mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView){
        return self.cellArray.count;

    }
    else {
        return self.selectionDataSource.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableView){
        if (indexPath.row == kRowConfirm) {
            return 56.f;
        }
        return 44.f;
    }
    else {
        return 44.f;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    
    if(tableView == self.tableView){
        cell = self.cellArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectionCell"];
        }
        cell.textLabel.text = self.selectionDataSource[indexPath.row];
    }
    return cell;
}


@end
