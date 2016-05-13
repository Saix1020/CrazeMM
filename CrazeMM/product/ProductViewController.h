//
//  ProductViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductDTO.h"
#import "BaseProductDetailDTO.h"
#import "TTModalView.h"
typedef NS_ENUM(NSInteger, ProductDisplayMode){
    kDisplayMode0 = 0,
    kDisplayMode1
};

@interface ProductViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TTModalViewDelgate>

@property (nonatomic) ProductDisplayMode productDisplayMode;

@property (nonatomic, strong) BaseProductDTO* productDto;
@property (nonatomic, strong) BaseProductDetailDTO* productDetailDto;
@property (nonatomic) NSInteger sectionNum;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIButton* supplyOrBuyButton;

-(instancetype)initWithProductDTO:(BaseProductDTO*)dto;
-(void)handleOrderWithQuantity:(NSInteger)quantity andMessage:(NSString*)message;


@end
