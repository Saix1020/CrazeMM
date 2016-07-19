//
//  CommonListCell+Mortgage.m
//  CrazeMM
//
//  Created by saix on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonListCell+Mortgage.h"
#import "MortgageDTO.h"


@implementation CommonListCell (Mortgage)

-(MortgageDTO*)mortgageDto
{
    return (MortgageDTO*)self.dto;
}

-(void)setMortgageDTO:(MortgageDTO*)dto
{
    [self formatOrderLabel:dto.id];
    [self formatTimeLabel:dto.createTime];
    [self formatStatusLabel:dto.stateLabel];
    [self formatGoodNameLabel:dto.goodName];
    [self formatQuantityLabel];
    [self formatPriceLabel];
    [self formatTotalPriceLabel];
    
    self.rightButton.hidden = YES;
    self.leftButton.hidden = YES;
}

-(void)formatQuantityLabel
{
    NSString* firstComponent = [NSString stringWithFormat:@"总数: %ld台 ",  self.mortgageDto.quantity];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                        }];
    
    
    if (self.mortgageDto.stockId>0 && self.mortgageDto.depotName.length>0) {
        
        NSString* secondComopent = [NSString stringWithFormat:@"(%@)", self.mortgageDto.depotName];
        [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:secondComopent attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.f]}]];
    }
    
    self.firstLabel.attributedText = attributedText;
}

-(void)formatPriceLabel
{
    NSString* firstComponent = [NSString stringWithFormat:@"抵押单价: "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                        }];
    
    
    
    NSString* secondComopent = [NSString stringWithFormat:@"￥%.02f", self.mortgageDto.price];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:13.f],
                                                                                       NSForegroundColorAttributeName: [UIColor redColor]                                             }]];
    
    self.secondLabel.attributedText = attributedText;
}

-(void)formatTotalPriceLabel
{
    NSString* firstComponent = [NSString stringWithFormat:@"总金额: "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:14.f]
                                                        }];
    NSArray* formatedPrice = [NSString formatePrice:self.mortgageDto.price*self.mortgageDto.quantity];
    NSString* secondComopent = [NSString stringWithFormat:@"￥%@", [formatedPrice componentsJoinedByString:@""]];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:13.f],
                                                                                       NSForegroundColorAttributeName: [UIColor redColor]                                             }]];
    
    self.thirdLabel.attributedText = attributedText;
}


@end
