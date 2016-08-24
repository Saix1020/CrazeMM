//
//  PayBottomView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonBottomView.h"

@implementation CommonBottomView

- (void)awakeFromNib {
    
    self.selectAllCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectAllCheckBox.onTintColor = [UIColor redColor];
    self.selectAllCheckBox.onFillColor = [UIColor redColor];
    self.selectAllCheckBox.boxType = BEMBoxTypeCircle;
    self.selectAllCheckBox.on = NO  ;
    self.selectAllCheckBox.animationDuration = 0.f;

    self.addtionalButton.hidden = YES;
    
    [self fomartTotalPriceLabel];
}

-(void)setTotalPrice:(CGFloat)totalPrice
{
    _totalPrice = totalPrice;
    [self formartTotalPriceLabelWithPrice:totalPrice];
}

-(void)formartTotalPriceLabelWithPrice:(CGFloat)price
{
    
    NSArray* priceStringComp = [NSString formatePrice:price];
    self.totalPriceLabel.text = @"";
    self.totalPriceLabel.textAlignment = kCTTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"总计: "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor grayColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:priceStringComp[0]];
    
    if (attributedText.length > 9) {
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:14.f]];
    }
    else {
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:16.f]];
    }
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:priceStringComp[1]];
    
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    [self.totalPriceLabel appendText:@""];
    self.totalPriceLabel.numberOfLines = 1;
    self.totalPriceLabel.offsetY = -4.f;
}

-(void)fomartTotalPriceLabel
{
    [self formartTotalPriceLabelWithPrice:0.f];
}

+(CGFloat)cellHeight
{
    return 40.f;
}

-(void)setOrderStyle:(MMOrderListStyle)style
{
    _orderType = style.orderType;
    _orderSubtype = style.orderSubType;
    _orderState = style.orderState;
    
    //    PAYCOMPLETE = TOBESENT,
    //    RECEIVECOMPLETE = TOBESETTLED,
    //    SENTCOMPLETE = TOBERECEIVED,
    //    CONFIRMEDCOMPLETE = COMPLETED,

    
    if (_orderType == kOrderTypeBuy) {
        switch (_orderSubtype) {
            case kOrderSubTypePay:
            {
                switch (_orderState) {
                    case TOBEPAID: //
                        self.hidden = NO;
                        self.selectAllCheckBox.hidden = NO;
                        self.totalPriceLabel.hidden = NO;
                        [self.confirmButton setTitle:@"付款" forState:UIControlStateNormal];
                        break;
                    case PAYTIMEOUT:
                        self.hidden = NO;
                        self.selectAllCheckBox.hidden = NO;
                        self.totalPriceLabel.hidden = YES;
                        [self.confirmButton setTitle:@"删除" forState:UIControlStateNormal];
                        break;
                    case PAYCOMPLETE:
                        self.hidden = YES;
                        break;
                        
                    default:
                        break;
                }
            }
                
                break;
            case kOrderSubTypeReceived:
            {
                switch (_orderState) {
                    case TOBERECEIVED:
                        self.hidden = NO;
                        self.selectAllCheckBox.hidden = NO;
                        self.totalPriceLabel.hidden = YES;
                        [self.confirmButton setTitle:@"签收" forState:UIControlStateNormal];

                        break;
                    case RECEIVECOMPLETE:
                        self.hidden = YES;
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }
    else if(_orderType == kOrderTypeSupply){
        switch (_orderSubtype) {
            case kOrderSubTypeSend:
            {
                switch (_orderState) {
                    case WAITFORPAY:
                        self.hidden = YES;
                        break;
                    case TOBESENT:
                        self.hidden = NO;
                        self.selectAllCheckBox.hidden = NO;
                        self.totalPriceLabel.hidden = YES;
                        [self.confirmButton setTitle:@"发货" forState:UIControlStateNormal];
                        break;
                    case SENTCOMPLETE:
                        self.hidden = YES;
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case kOrderSubTypeConfirmed:
            {
                switch (_orderState) {
                    case TOBESETTLED:
                        self.hidden = YES;
                        break;
                    case TOBECONFIRMED:
                        self.hidden = NO;
                        self.selectAllCheckBox.hidden = NO;
                        self.totalPriceLabel.hidden = YES;
                        self.totalPriceLabel.hidden = YES;
                        [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
                        break;
                    case CONFIRMEDCOMPLETE:
                        self.hidden = YES;
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }
}


@end
