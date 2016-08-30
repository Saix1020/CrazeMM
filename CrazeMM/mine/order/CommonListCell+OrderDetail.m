//
//  CommonListCell+OrderDetail.m
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonListCell+OrderDetail.h"

@implementation CommonListCell (OrderDetail)


-(OrderDetailDTO*)orderDetailDTO
{
    return (OrderDetailDTO*)self.dto;
}

-(void)setOrderDetailDTO:(OrderDetailDTO*)orderDetailDTO
{
    self.rightButton.hidden = YES;
    self.leftButton.hidden = YES;
    self.image.hidden = NO;
    self.bottomLabel.hidden = NO;
    
    
    
    [self fomartOrderLabel];
    [self fomartProductDescLabel];
    NSMutableString* amountLabelString = [[NSMutableString alloc] initWithFormat:@"数量: %ld", orderDetailDTO.quantity ];
    if (NotNilAndNull(orderDetailDTO.depotDto) && orderDetailDTO.depotDto.name.length>0) {
        [amountLabelString appendString:[NSString stringWithFormat:@" (%@)", orderDetailDTO.depotDto.name]];
    }
    else {
        [amountLabelString appendString:[NSString stringWithFormat:@" (%@)", @"卖家发货"]];
        
    }
    self.secondLabel.text = amountLabelString;
    self.thirdLabel.text = [NSString stringWithFormat:@"单台定价: %.02f", orderDetailDTO.price];
    if (!orderDetailDTO.isAony) {
        [self fomartCompanyLabel];
    }
    
    self.statusLabel.text = [NSString stringWithFormat:@" %@ ", orderDetailDTO.stateLabel];
//    [self.flagLabel sizeToFit];
    
    [self fomartTotalPriceLabel];
    [self fomartStatusLabel];
}

-(void)fomartCompanyLabel
{
    NSString* companyIconURL = @"http://invalid_image";
    NSString* companyName = @"疯狂买卖王";
    
    if (self.orderDetailDTO) {
        companyIconURL = self.orderDetailDTO.userImage;
        companyName = self.orderDetailDTO.userName;
    }
    
    if (![companyIconURL hasPrefix:@"http"]) {
        companyIconURL = COMB_URL(companyIconURL);
    }
    
    self.timeLabel.text = companyName;
    self.timeLabel.font = [UIFont systemFontOfSize:12.f];
//    [self.timeLabel sizeToFit];

    [self.image setImageWithURL:[NSURL URLWithString:companyIconURL] placeholderImage:[UIImage imageNamed:@"company_icon"]];
    
}

-(void)fomartOrderLabel
{
    self.orderLabel.text = [NSString stringWithFormat:@"订单号: %ld", self.orderDetailDTO.id];
}

-(void)fomartStatusLabel
{
    NSMutableString* string = [[NSMutableString alloc]init];
    if (self.orderDetailDTO.isSerial) {
        [string appendString:@"带串码 "];
    }
    if (self.orderDetailDTO.isOriginal) {
        [string appendString:@"原装 "];
    }
    if (self.orderDetailDTO.isOriginalBox) {
        [string appendString:@"原封箱 "];
    }
    if (self.orderDetailDTO.isBrushMachine) {
        [string appendString:@"已刷机"];
    }
    
    self.firstLabel.text = string;
    self.firstLabel.font = [UIFont systemFontOfSize:12.f];
    self.firstLabel.textColor = [UIColor lightGrayColor];
}

-(void)fomartProductDescLabel
{
    self.titleLabel.text = self.orderDetailDTO.goodName;
    
}

-(void)fomartTotalPriceLabel
{
    NSArray* priceArray;
    if (self.orderDetailDTO) {
        priceArray = [NSString formatePrice:self.orderDetailDTO.price*self.orderDetailDTO.quantity];
    }
    else {
        priceArray = @[@"5,000", @".00"];
    }
    
    self.bottomLabel.text = @"";
    self.bottomLabel.textAlignment = NSTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]
                                                 initWithString:@"总价: "
                                                 attributes:@{
                                                              NSForegroundColorAttributeName: [UIColor grayColor],
                                                              NSFontAttributeName :      [UIFont systemFontOfSize:12.f]                                                                           }] ;
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc]
                                            initWithString:@"￥"
                                            attributes:@{
                                                         NSForegroundColorAttributeName: [UIColor redColor],
                                                         NSFontAttributeName :      [UIFont systemFontOfSize:12.f]                                                              }] ];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc]
                                            initWithString:priceArray[0]
                                            attributes:@{
                                                         NSForegroundColorAttributeName: [UIColor redColor],
                                                         NSFontAttributeName :      [UIFont systemFontOfSize:16.f]                                                              }] ];
    [attributedText appendAttributedString:[[NSMutableAttributedString alloc]
                                            initWithString:priceArray[1]
                                            attributes:@{
                                                         NSForegroundColorAttributeName: [UIColor redColor],
                                                         NSFontAttributeName :      [UIFont systemFontOfSize:12.f]                                                              }] ];
    self.bottomLabel.attributedText = attributedText;
}



@end
