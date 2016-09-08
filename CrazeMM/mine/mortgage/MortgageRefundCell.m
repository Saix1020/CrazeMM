//
//  MortgageRefundCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/9/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageRefundCell.h"

@interface MortgageRefundCell()

@end

@implementation MortgageRefundCell


-(void)setTotalNum:(NSInteger)totalNum
{
    [self formatTotalNum:totalNum];
}

-(void)setPrice:(NSInteger)price
{
    [self formatTotalPrice:price];
}

-(void)setInterest:(CGFloat)interest
{
    [self formatTotalInterest:interest];
}

- (void)setMoney:(CGFloat)money
{
    [self formatTotalMoney:money];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.garyView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    // Initialization code
}

- (void) formatTotalNum: (NSInteger)totalNum
{
    self.totalNumLabel.text = [NSString stringWithFormat:@"共偿还%ld笔抵押", totalNum];
}

- (void) formatTotalPrice: (NSInteger)totalPrice
{
    NSString* firstComponent = [NSString stringWithFormat:@"总本金: "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:17.f]
                                                        }];
    NSArray* formatedPrice = [NSString formatePrice:totalPrice];
    NSString* secondComopent = [NSString stringWithFormat:@"￥%@", [formatedPrice componentsJoinedByString:@""]];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:17.f],
                                                                                       NSForegroundColorAttributeName: [UIColor redColor]                                             }]];
    
    self.totalPrice.attributedText = attributedText;
}

- (void) formatTotalInterest: (CGFloat)totalInterest
{
    NSString* firstComponent = [NSString stringWithFormat:@"总利息: "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:17.f]
                                                        }];
    NSArray* formatedPrice = [NSString formatePrice:totalInterest];
    NSString* secondComopent = [NSString stringWithFormat:@"￥%@", [formatedPrice componentsJoinedByString:@""]];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:17.f],
                                                                                       NSForegroundColorAttributeName: [UIColor redColor]                                             }]];
    
    self.totalInterest.attributedText = attributedText;
}

- (void) formatTotalMoney: (CGFloat)totalMoney
{
    NSString* firstComponent = [NSString stringWithFormat:@"可用金额 "];
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString: firstComponent
                                           attributes:@{
                                                        NSFontAttributeName: [UIFont systemFontOfSize:20.f]
                                                        }];
    NSArray* formatedPrice = [NSString formatePrice:totalMoney];
    NSString* secondComopent = [NSString stringWithFormat:@"￥%@", [formatedPrice componentsJoinedByString:@""]];
    [attributedText appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:secondComopent attributes:@{
                                                                                       NSFontAttributeName: [UIFont systemFontOfSize:20.f],
                                                                                       NSForegroundColorAttributeName: [UIColor blackColor]                                             }]];
    
    self.totalMoney.attributedText = attributedText;
}


@end
