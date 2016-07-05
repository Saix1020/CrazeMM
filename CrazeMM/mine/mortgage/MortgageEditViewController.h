//
//  MortgageEditViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"
#import "AddrCommonCell.h"
#import "AddrRegionCell.h"
#import "SwitchCell.h"
#import "HttpMortgage.h"
#import "MortgageBrandDTO.h"
#import "MortgageGoodDTO.h"
#import "MortgageInfoDTO.h"

typedef NS_ENUM(NSInteger, MortgageEditingTableViewRow){
    kRowMDepot = 0,
    kRowMBrand = 1,
    kRowMModel,
    kRowMCVN,
    kRowMPrice,
    kRowMInterestRate,
    kRowMDuration,
    kRowMQuantity,
    kRowMInprice,
    kRowMOutprice,
    kRowMConfirm,
    kRowMMax
};

@protocol MortgageEditViewControllerDelegate <NSObject>

-(void)editMortgageSuccess;

@end

@interface MortgageEditViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SelectionViewControllerDelegate>
@property (nonatomic, weak) id<MortgageEditViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray* cellArray;
@property (nonatomic, strong) AddrRegionCell* depotCell;
@property (nonatomic, strong) AddrRegionCell* brandCell;
@property (nonatomic, strong) AddrRegionCell* modelCell;
@property (nonatomic, strong) AddrRegionCell* cVNCell; //Color/Volume/Network
@property (nonatomic, strong) AddrRegionCell* priceCell;
@property (nonatomic, strong) AddrRegionCell* interestRateCell;
@property (nonatomic, strong) AddrRegionCell* durationCell;
@property (nonatomic, strong) AddrCommonCell* quantityCell;
@property (nonatomic, strong) AddrCommonCell* inpriceCell;
@property (nonatomic, strong) AddrCommonCell* outpriceCell;
//注：抵押货品将在放款后自动生成供货信息进行出售
@property (nonatomic, strong) UILabel* additionalInfo;
@property (nonatomic, strong) UITableViewCell* confirmCell;
@property (nonatomic, strong) UIButton* confirmButton;

@property (nonatomic, strong) NSMutableArray* selectionDataSource;
@property (nonatomic) NSInteger editingRow;
@property (nonatomic, strong) NSArray* depots;
@property (nonatomic, strong) NSArray* goodBrands;
@property (nonatomic, strong) NSArray* goodModels;
@property (nonatomic, strong) NSArray* mortgageInfos;
@property (nonatomic, strong) NSMutableArray* cVNInfos;
@property (nonatomic, strong) MortgageInfoDTO * currentMortgageDetail;

@property (nonatomic) BOOL enableModelEdit;
@property (nonatomic) BOOL enableCVNEdit;

-(void)saveNewMortgage:(UIButton*)sender;

@end
