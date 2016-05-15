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
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
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
//    self.browserLabel.text = @"浏览:10";
    self.buyLabel.numberOfLines = 1;
    self.buyLabel.adjustsFontSizeToFitWidth = YES;
//    self.buyLabel.text = @"成交:10";
    
//    self.titleLable.adjustsFontSizeToFitWidth = YES;
    self.titleLable.numberOfLines = 2;
//    self.titleLable.text = @"三星-J7109 金 16G 电信版";
    //self.titleLable.width = screenWidth - self.titleLable.x -16.f;
    
    self.detalLabel.numberOfLines = 1;
//    self.detalLabel.adjustsFontSizeToFitWidth = YES;
//    self.detalLabel.text = @"原装 原封箱 带串码 网站担保 开票 保证金";
    self.detalLabel.textColor = [UIColor grayColorL2];

    
    self.line2.backgroundColor = [UIColor light_Gray_Color];
    self.line2.width = screenWidth - self.line2.x -16.f;
//    self.line2.layer.borderColor = [UIColor light_Black_Color].CGColor;
//    self.line2.layer.borderWidth = .25f;
    
    self.priceLabel.width = screenWidth - self.priceLabel.x -16.f;

    
    self.addrLabel.numberOfLines = 2;
//    self.addrLabel.adjustsFontSizeToFitWidth = YES;
    self.addrLabel.width = screenWidth - self.addrLabel.x -16.f;
//    self.addrLabel.text = @"发货地址:  江苏省南京市浦口区";
    self.addrLabel.textColor = [UIColor grayColorL2];
    self.addrLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.expressLabel.numberOfLines = 2;
    self.expressLabel.width = screenWidth - self.expressLabel.x -16.f;
//    self.expressLabel.text = @"快递: 包邮";
    self.expressLabel.textColor = [UIColor grayColorL2];
    self.expressLabel.font = [UIFont systemFontOfSize:12];
    
    self.messageLabel.numberOfLines = 3;
    self.messageLabel.width = screenWidth - self.expressLabel.x -16.f;
    self.messageLabel.textColor = [UIColor grayColorL2];
    self.messageLabel.font = [UIFont systemFontOfSize:12];
    
    
    self.traingleView.image = [[UIImage imageNamed:@"triangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


-(ArrowView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[ArrowView alloc] init];
//        _arrowView.textLabel.text = @"供货";
        _arrowView.frame = CGRectMake(0, 0, 38, 16);
    }
    
    return _arrowView;
}

+(CGFloat)cellHeight
{
    return 170.f;
}

-(void)fomartPriceLabel
{
    self.priceLabel.text = @"";
    CGFloat price = self.productDetailDto? self.productDetailDto.price : 1020.f;
    NSInteger left = self.productDetailDto? self.productDetailDto.left : 10;
    NSString* priceString = [NSString stringWithFormat:@"￥%.02f", price];
    
    [self.priceLabel appendAttributedText:[self moneyString:priceString]];
    NSMutableAttributedString *attributedText;
//    attributedText = [[NSMutableAttributedString alloc]initWithString:@"起 "];
//    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
//    [attributedText m80_setTextColor:[UIColor grayColorL2]];
//    [self.priceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %ld", left]];
    [attributedText m80_setFont:[UIFont systemFontOfSize:18]];
    [attributedText m80_setTextColor:[UIColor greenTextColor]];
    [self.priceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"台 "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor greenTextColor]];
    [self.priceLabel appendAttributedText:attributedText];
    
    [self.priceLabel appendView:self.arrowView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];

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

-(void)setProductDetailDto:(BaseProductDetailDTO *)productDetailDto
{
    NSAssert(!productDetailDto.isStep, @"ProductLadderCell is only support stepped price!");
    _productDetailDto = productDetailDto;
    
    self.flagLabel.text = productDetailDto.stateLabel;
    if([self.flagLabel.text isEqualToString:@"已过期"]){
        self.flagLabel.backgroundColor = [UIColor redColor];
        self.traingleView.tintColor = [UIColor redColor];
    }
    else {
        self.flagLabel.backgroundColor = [UIColor UIColorFromRGB:0x097939];
        self.traingleView.tintColor = [UIColor UIColorFromRGB:0x097939];
    }

    [self.flagLabel sizeToFit];
    [self.productImageView setImageWithURL:[NSURL URLWithString:_productDetailDto.goodImage] placeholderImage:[@"ph_phone" image]];
    self.browserLabel.text = [NSString stringWithFormat:@"浏览:%ld", productDetailDto.views];
    self.buyLabel.text = [NSString stringWithFormat:@"意向:%ld", productDetailDto.intentions];
    
    self.titleLable.text = productDetailDto.goodName;
    
    NSMutableString* desc = [[NSMutableString alloc] init];
    if (productDetailDto.isOriginal) {
        [desc appendString:@"原装 "];
    }
    if (productDetailDto.isOriginalBox) {
        [desc appendString:@"原封箱 "];
    }
    if (productDetailDto.isSerial) {
        [desc appendString:@"带串码 "];
    }
    if (productDetailDto.isBrushMachine) {
        [desc appendString:@"已刷机"];
    }
    self.detalLabel.text = desc;
    
    if ([productDetailDto isKindOfClass:NSClassFromString(@"SupplyProductDetailDTO")]) {
        self.arrowView.textLabel.text = @"供货";
        
    }
    else {
        self.arrowView.textLabel.text = @"求购";
    }
    [self fomartPriceLabel];
    
    NSMutableString* moreInfo = [[NSMutableString alloc] init];
    if (self.productDetailDto.isTop) {
        [moreInfo appendString:@"推荐 "];
    }
    if (self.productDetailDto.isSplit) {
        [moreInfo appendString:@"可拆分 "];
    }
    if (self.productDetailDto.isStep) {
        [moreInfo appendString:@"阶梯价 "];
    }
    [moreInfo appendString:[NSString stringWithFormat:@"%@到货", self.productDetailDto.deadlineStr]];
    self.addrLabel.text = moreInfo;
    
    NSString* scopeString = [self.productDetailDto isKindOfClass:NSClassFromString(@"SupplyProductDetailDTO")]? @"供货范围" : @"收货地址";
    self.expressLabel.text = [NSString stringWithFormat:@"%@: %@", scopeString, self.productDetailDto.region];
    
    if (![self.productDetailDto.message isKindOfClass:[NSNull class]]) {
        self.messageLabel.text = [NSString stringWithFormat:@"备注: %@", self.productDetailDto.message];
    }
    else {
        self.messageLabel.text = @"";
    }
    
//    [RACObserve(self, productDetailDto.quantity) subscribeNext:^(id quantity){
//        [self fomartPriceLabel];
//    }];
    
    [self layoutAllSubviews];
}

-(void)layoutAllSubviews
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    CGFloat x, y;
    x = self.flagLabel.x;
    y = self.flagLabel.y;
    [self.flagLabel sizeToFit];
    self.flagLabel.x = x;
    self.flagLabel.y = y;
    self.flagLabel.width += 4.f;
    self.traingleView.y = self.flagLabel.bottom;
    
    self.titleLable.width = screenWidth - self.titleLable.x -16.f;
    x = self.titleLable.x;
    y = self.titleLable.y;
    [self.titleLable sizeToFit];
    self.titleLable.x = x;
    self.titleLable.y = y;
    
    self.detalLabel.width = screenWidth - self.detalLabel.x -16.f;
    [self.detalLabel sizeToFit];
    self.detalLabel.x = self.titleLable.x;
    self.detalLabel.y = self.titleLable.bottom + 4.f;
    
    self.addrLabel.width = screenWidth - self.addrLabel.x -16.f;
    y = self.addrLabel.y;
    [self.addrLabel sizeToFit];
    self.addrLabel.x = self.titleLable.x;
    self.addrLabel.y = y;
    
    self.expressLabel.width = screenWidth - self.expressLabel.x -16.f;
    [self.expressLabel sizeToFit];
    self.expressLabel.x = self.titleLable.x;
    self.expressLabel.y = self.addrLabel.bottom + 4.f;
    
    self.messageLabel.width = screenWidth - self.messageLabel.x -16.f;
    if (self.messageLabel.text.length == 0) {
        self.messageLabel.height = 0;
    }
    else {
        [self.messageLabel sizeToFit];
        self.messageLabel.x = self.titleLable.x;

    }
    self.messageLabel.y = self.expressLabel.bottom + 4.f;
}

-(CGFloat)cellHeight
{
    return ceil(self.messageLabel.bottom + 8.f);
}

@end
