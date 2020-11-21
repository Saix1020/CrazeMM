//
//  MineSupplyEditViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "SelectionViewController.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SwitchCell.h"
#import "AddrDefaultCheckboxCell.h"
#import "HttpMineSupply.h"
#import "GoodDTO.h"
#import "SupplyDetailDTO.h"
#import "GoodCreateInfo.h"



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


@protocol MineEditViewControllerDelegate <NSObject>

-(void)editSupplyGoodSuccess;

@end

@interface MineSupplyEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, BEMCheckBoxDelegate, SelectionViewControllerDelegate>

-(instancetype)initWithId:(NSInteger)sid;
-(instancetype)initWithModifyGoodInfo:(GoodCreateInfo*)modifyGoodInfo;

@property (nonatomic, strong) GoodCreateInfo* modifyGoodInfo;

@property (nonatomic, weak) id<MineEditViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray* cellArray;
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
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) NSMutableArray* selectionDataSource;
@property (nonatomic) NSInteger editingRow;
@property (nonatomic, strong) NSArray* goodBrands;
@property (nonatomic, strong) NSArray* goodInfos;
@property (nonatomic, strong) GoodInfoDTO* currentGoodDetail;
@property (nonatomic, readonly) NSArray* cycleStringArray;

@property (nonatomic) BOOL enableSubEdit;

-(void)saveNewGood:(UIButton*)sender;
@end
