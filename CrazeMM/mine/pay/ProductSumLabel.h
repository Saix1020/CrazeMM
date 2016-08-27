//
//  ProductSumLabel.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M80AttributedLabel.h"

@interface ProductSumLabel : UIView

@property (nonatomic, strong) UILabel* totalNumLabel;
@property (nonatomic, strong) M80AttributedLabel* totalPriceLabel;

@end
