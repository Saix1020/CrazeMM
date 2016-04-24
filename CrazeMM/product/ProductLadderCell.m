//
//  ProductLadderCell.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductLadderCell.h"

@interface ProductLadderCell()

@property(nonatomic, strong) UIView* headView;

@end

//@property (weak, nonatomic) IBOutlet ProductFlageView *flageView;
//@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
//@property (weak, nonatomic) IBOutlet UIView*browserDealView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//@property (weak, nonatomic) IBOutlet UIView *line1;
//@property (weak, nonatomic) IBOutlet UIView *line2;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel3;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *price1;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *price2;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *price3;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *stockLabel;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *addrLabel;
//@property (weak, nonatomic) IBOutlet UILabel *flagTitleLabel;
//@property (weak, nonatomic) IBOutlet M80AttributedLabel *expressLabel;

@implementation ProductLadderCell

//-(UIView*)headView
//{
//    if (!_headView) {
//        _headView = [[UIView alloc] init];
//        _headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [self addSubview:_headView];
//    }
//    
//    return _headView;
//}

-(void)awakeFromNib
{
    self.productImageView.layer.borderWidth = 1.f;
    self.productImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.browserDealView.layer.borderWidth = 1.f;
    self.browserDealView.layer.borderColor = [UIColor greenTextColor].CGColor;
    self.browserDealView.layer.cornerRadius = 2.f;
    self.browseLabel.numberOfLines = 1;
    self.browseLabel.adjustsFontSizeToFitWidth = YES;
    self.browseLabel.text = @"浏览:10";
    self.sellLabel.numberOfLines = 1;
    self.sellLabel.adjustsFontSizeToFitWidth = YES;
    self.sellLabel.text = @"成交:10";
    
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = @"三星-J7109 金 16G 电信版";
    
    self.descLabel.numberOfLines = 4;
    self.descLabel.adjustsFontSizeToFitWidth = YES;
    self.descLabel.text = @"原装 原封箱 带串码 网站担保 开票 保证金";
    self.descLabel.textColor = [UIColor grayColorL2];
    
//    [self bringSubviewToFront:self.line1];
//    [self bringSubviewToFront:self.line2];
    self.line1.backgroundColor = [UIColor light_Gray_Color];
    self.line2.backgroundColor = [UIColor light_Gray_Color];
    
    self.priceLabel1.text = @"1-9台";
    self.priceLabel1.font = [UIFont systemFontOfSize:12];
    self.priceLabel2.text = @"10-50台";
    self.priceLabel2.font = [UIFont systemFontOfSize:12];
    self.priceLabel3.text = @">50台";
    self.priceLabel3.font = [UIFont systemFontOfSize:12];

    
    [self.price1 appendAttributedText:[self moneyString:@"￥1020.00"]];
    [self.price2 appendAttributedText:[self moneyString:@"￥980.00"]];

    [self.price3 appendAttributedText:[self moneyString:@"￥760.00"]];

    [self fomartStorkString];
    
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
    return 209.f;
}

-(void)fomartStorkString
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"库存量:  "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor grayColorL2]];
    [self.stockLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"99"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor greenTextColor]];
    [self.stockLabel appendAttributedText:attributedText];

    attributedText = [[NSMutableAttributedString alloc]initWithString:@"台"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor grayColorL2]];
    [self.stockLabel appendAttributedText:attributedText];

    [self.stockLabel appendText:@" "];
    [self.stockLabel appendView:self.arrowView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];

}

-(NSAttributedString*)moneyString:(NSString*)money
{
    NSMutableAttributedString * finnal = [[NSMutableAttributedString alloc]init];
    UIFont* largFont = [UIFont boldSystemFontOfSize:16];
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

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 12.f);
//    self.contentView.y = self.headView.bottom;
}

@end
