//
//  ProductSumLabel.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductSumLabel.h"

@implementation ProductSumLabel

//@property (nonatomic, strong) UILabel* totalNumLabel;
//@property (nonatomic, strong) M80AttributedLabel* totalPriceLabel;

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.totalNumLabel = [[UILabel alloc] init];
        self.totalNumLabel.textAlignment = NSTextAlignmentRight;
        self.totalNumLabel.font = [UIFont systemFontOfSize:16];
        self.totalNumLabel.textColor = [UIColor light_Gray_Color];
        
        
        self.totalPriceLabel = [[M80AttributedLabel alloc] init];
        self.totalPriceLabel.textAlignment = kCTTextAlignmentRight;
        
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.totalNumLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.totalNumLabel.frame = CGRectMake(0, 0, self.width, self.height/3);
    self.totalPriceLabel.frame = CGRectMake(0, self.totalNumLabel.height, self.width, self.height/3*2);

}


@end
