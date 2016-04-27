//
//  ProductDetailCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductDetailCell.h"

@interface ProductDetailCell()

@end

@implementation ProductDetailCell
-(void)awakeFromNib
{
    
    self.seperatorLine.backgroundColor = [UIColor clearColor];
    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.layer.borderColor = [UIColor greenTextColor].CGColor;

    self.productImageView.layer.borderWidth = 1.f;
    self.productImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.browserAndSellLabel.layer.borderWidth = .5f;
    self.browserAndSellLabel.layer.borderColor = [UIColor greenTextColor].CGColor;
    self.browserAndSellLabel.layer.cornerRadius = 2.f;
    self.browserLabel.numberOfLines = 1;
    self.browserLabel.adjustsFontSizeToFitWidth = YES;
    self.browserLabel.text = @"浏览:10";
    self.buyLabel.numberOfLines = 1;
    self.buyLabel.adjustsFontSizeToFitWidth = YES;
    self.buyLabel.text = @"成交:10";
    
    self.titleLable.numberOfLines = 1;
    self.titleLable.adjustsFontSizeToFitWidth = YES;
    self.titleLable.text = @"三星-J7109 金 16G 电信版";
    
    self.detalLabel.numberOfLines = 4;
    self.detalLabel.adjustsFontSizeToFitWidth = YES;
    self.detalLabel.text = @"原装 原封箱 带串码 网站担保 开票 保证金";
    self.detalLabel.textColor = [UIColor grayColorL2];
    
    self.line2.backgroundColor = [UIColor light_Gray_Color];
//    self.line2.layer.borderColor = [UIColor light_Black_Color].CGColor;
//    self.line2.layer.borderWidth = .25f;
    
    [self.priceLabel appendAttributedText:[self moneyString:@"￥1020.00"]];
    NSMutableAttributedString *attributedText;
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"起 "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor grayColorL2]];
    [self.priceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"10"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:18]];
    [attributedText m80_setTextColor:[UIColor greenTextColor]];
    [self.priceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"台 "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor greenTextColor]];
    [self.priceLabel appendAttributedText:attributedText];
    
    [self.priceLabel appendView:self.arrowView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    
    
    self.addrLabel.numberOfLines = 1;
    self.addrLabel.adjustsFontSizeToFitWidth = YES;
    self.addrLabel.text = @"发货地址:  江苏省南京市浦口区";
    self.addrLabel.textColor = [UIColor grayColorL2];
    self.addrLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.expressLabel.numberOfLines = 1;
    self.expressLabel.adjustsFontSizeToFitWidth = YES;
    self.expressLabel.text = @"快递: 包邮";
    self.expressLabel.textColor = [UIColor grayColorL2];
    self.expressLabel.font = [UIFont systemFontOfSize:12];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


-(ArrowView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[ArrowView alloc] init];
        _arrowView.textLabel.text = @"供货";
        _arrowView.frame = CGRectMake(0, 0, 38, 16);
    }
    
    return _arrowView;
}

+(CGFloat)cellHeight
{
    return 170.f;
}


-(NSAttributedString*)moneyString:(NSString*)money
{
    NSMutableAttributedString * finnal = [[NSMutableAttributedString alloc]init];
    UIFont* largFont = [UIFont boldSystemFontOfSize:18];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:10];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor blackColor], [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       smallFont, largFont, middleFont];
    
    NSArray* components = @[[money substringToIndex:1], [money substringWithRange:NSMakeRange(1, money.length-4)], [money substringFromIndex:money.length-3]];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        index ++;
        
        [finnal appendAttributedString:attributedText];
    }
    
    return finnal;
}


@end
