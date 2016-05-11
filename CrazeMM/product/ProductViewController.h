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

typedef NS_ENUM(NSInteger, ProductDisplayMode){
    kDisplayMode0 = 0,
    kDisplayMode1
};

@interface ProductViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) ProductDisplayMode productDisplayMode;

@property (nonatomic, strong) BaseProductDTO* productDto;
@property (nonatomic, strong) BaseProductDetailDTO* productDetailDto;

-(instancetype)initWithProductDTO:(BaseProductDTO*)dto;

@end
