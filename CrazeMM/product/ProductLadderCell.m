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
    self.seperatorLine.backgroundColor = [UIColor clearColor];
    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.layer.borderColor = [UIColor greenTextColor].CGColor;

    self.productImageView.layer.borderWidth = 1.f;
    self.productImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.browserDealView.layer.borderWidth = .5f;
    self.browserDealView.layer.borderColor = [UIColor greenTextColor].CGColor;
    self.browserDealView.layer.cornerRadius = 2.f;
    self.browseLabel.numberOfLines = 1;
    self.browseLabel.adjustsFontSizeToFitWidth = YES;
//    self.browseLabel.text = @"浏览:10";
    self.sellLabel.numberOfLines = 1;
    self.sellLabel.adjustsFontSizeToFitWidth = YES;
//    self.sellLabel.text = @"成交:10";
    
    self.titleLabel.numberOfLines = 2;
    //self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.titleLabel.text = @"三星-J7109 金 16G 电信版 三星-J7109 金 16G 电信版";
    
    self.descLabel.numberOfLines = 1;
//    self.descLabel.adjustsFontSizeToFitWidth = YES;
//    self.descLabel.text = @"原装 原封箱 带串码 网站担保 开票 保证金";
    self.descLabel.textColor = [UIColor grayColorL2];
    
//    [self bringSubviewToFront:self.line1];
//    [self bringSubviewToFront:self.line2];
    self.line1.backgroundColor = [UIColor light_Gray_Color];
    self.line2.backgroundColor = [UIColor light_Gray_Color];
    
//    self.priceLabel1.text = @"1-9台";
    self.priceLabel1.font = [UIFont systemFontOfSize:12];
//    self.priceLabel2.text = @"10-50台";
    self.priceLabel2.font = [UIFont systemFontOfSize:12];
//    self.priceLabel3.text = @">50台";
    self.priceLabel3.font = [UIFont systemFontOfSize:12];
//
//    
//    [self.price1 appendAttributedText:[self moneyString:@"￥1020.00"]];
//    [self.price2 appendAttributedText:[self moneyString:@"￥980.00"]];
//
//    [self.price3 appendAttributedText:[self moneyString:@"￥760.00"]];
//
//    [self fomartStorkString];
    
    self.addrLabel.numberOfLines = 2;
//    self.addrLabel.adjustsFontSizeToFitWidth = YES;
    //self.addrLabel.text = @"发货地址:  江苏省南京市浦口区";
    self.addrLabel.textColor = [UIColor grayColorL2];
    self.addrLabel.font = [UIFont systemFontOfSize:12];

    
    self.expressLabel.numberOfLines = 2;
    self.expressLabel.adjustsFontSizeToFitWidth = YES;
    //self.expressLabel.text = @"快递: 包邮";
    self.expressLabel.textColor = [UIColor grayColorL2];
    self.expressLabel.font = [UIFont systemFontOfSize:12];
    
    self.messageLabel.numberOfLines = 3;
    self.messageLabel.width = [UIScreen mainScreen].bounds.size.width - self.expressLabel.x -16.f;
    self.messageLabel.textColor = [UIColor grayColorL2];
    self.messageLabel.font = [UIFont systemFontOfSize:12];
    
    self.triangleView.image = [[UIImage imageNamed:@"triangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


-(ArrowView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[ArrowView alloc] init];
        //_arrowView.textLabel.text = @"供货";
        _arrowView.frame = CGRectMake(0, 0, 34, 14);
    }
    
    return _arrowView;
}

+(CGFloat)cellHeight
{
    return 209.f;
}

-(NSArray*)priceLabels
{
    return @[self.priceLabel1, self.priceLabel2, self.priceLabel3];
}
-(NSArray*)prices
{
    return @[self.price1, self.price2, self.price3];
}

-(void)fomartStorkString
{
    self.stockLabel.text = @"";
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"库存量:  "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12]];
    [attributedText m80_setTextColor:[UIColor grayColorL2]];
    [self.stockLabel appendAttributedText:attributedText];
    
//    NSInteger left = self.productDetailDto?self.productDetailDto.left:99;
    attributedText = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld", self.productDetailDto.left]];
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

-(void)setProductDetailDto:(BaseProductDetailDTO *)productDetailDto
{
    NSAssert(productDetailDto.isStep, @"ProductLadderCell is only support stepped price!");
    _productDetailDto = productDetailDto;
    
    self.flagTitleLabel.text = productDetailDto.stateLabel;
    if([self.flagTitleLabel.text isEqualToString:@"已过期"]){
        self.flagTitleLabel.backgroundColor = [UIColor redColor];
        self.triangleView.tintColor = [UIColor redColor];
    }
    else {
        self.flagTitleLabel.backgroundColor = [UIColor UIColorFromRGB:0x097939];
        self.triangleView.tintColor = [UIColor UIColorFromRGB:0x097939];
    }

    [self.productImageView setImageWithURL:[NSURL URLWithString:_productDetailDto.goodImage] placeholderImage:[@"ph_phone" image]];
    self.browseLabel.text = [NSString stringWithFormat:@"浏览:%ld", productDetailDto.views];
    self.sellLabel.text = [NSString stringWithFormat:@"意向:%ld", productDetailDto.intentions];
    
    self.titleLabel.text = productDetailDto.goodName;
    
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
    self.descLabel.text = desc;

    if ([productDetailDto isKindOfClass:NSClassFromString(@"SupplyProductDetailDTO")]) {
        self.arrowView.textLabel.text = @"供货";
        
    }
    else {
        self.arrowView.textLabel.text = @"求购";
    }
    
    for (UILabel* label in [self priceLabels]) {
        label.hidden = YES;
    }
    for (M80AttributedLabel* price in [self prices]) {
        price.hidden = YES;
    }
    
    for (NSInteger index=0; index<productDetailDto.stepPrices.count; ++index) {
        ProductStepPrice* stepPrice = productDetailDto.stepPrices[index];
        UILabel* priceLabel = [self priceLabels][index];
        M80AttributedLabel* price = [self prices][index];
        priceLabel.hidden = NO;
        price.hidden = NO;
        if (stepPrice.qto<=0) {
            priceLabel.text = [NSString stringWithFormat:@">%ld台", stepPrice.qfrom];
            

        }
        else {
            priceLabel.text = [NSString stringWithFormat:@"%ld-%ld台", stepPrice.qfrom, stepPrice.qto];

        }
        [price setAttributedText:[self moneyString:[NSString stringWithFormat:@"￥%.02f", stepPrice.sprice]]];
    }
    
    [self fomartStorkString];
    
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
    self.expressLabel.text = [NSString stringWithFormat:@"供货范围: %@", self.productDetailDto.region];
    //    self.messageLabel.text = ![self.productDetailDto.message isKindOfClass:[NSNull class]]?[NSString stringWithFormat:@"备注: %@", self.productDetailDto.message]:@"";
    
    if (![self.productDetailDto.message isKindOfClass:[NSNull class]]) {
        self.messageLabel.text = [NSString stringWithFormat:@"备注: %@", self.productDetailDto.message];
    }
    else {
        self.messageLabel.text = @"";
    }
//    @weakify(self);
//    [RACObserve(self, productDetailDto.quantity) subscribeNext:^(id x){
//        @strongify(self);
//        [self fomartStorkString];
//    }];
    
    [self layoutAllSubviews];
}

-(void)layoutAllSubviews
{
    CGFloat x, y;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    x = self.flagTitleLabel.x;
    y = self.flagTitleLabel.y;
    [self.flagTitleLabel sizeToFit];
    self.flagTitleLabel.x = x;
    self.flagTitleLabel.y = y;
    self.flagTitleLabel.width += 4.f;
    self.triangleView.y = self.flagTitleLabel.bottom;
    
    self.titleLabel.width = screenWidth - self.titleLabel.x -16.f;
    x = self.titleLabel.x;
    y = self.titleLabel.y;
    [self.titleLabel sizeToFit];
    self.titleLabel.x = x;
    self.titleLabel.y = y;
    
    self.descLabel.width = screenWidth - self.descLabel.x -16.f;
    [self.descLabel sizeToFit];
    self.descLabel.x = self.titleLabel.x;
    self.descLabel.y = self.titleLabel.bottom + 4.f;
    
    self.line1.width = screenWidth - self.line1.x -8.f;
    //self.line1.x = self.titleLabel.x;
    self.line1.y = self.descLabel.bottom + 4.f;
    
    self.stepPricesView.width = screenWidth - self.stepPricesView.x -16.f;
    self.stepPricesView.y = self.line1.bottom + 8.f;
    
    self.line2.width = screenWidth - self.line2.x -8.f;
    //self.line2.x = self.titleLabel.x;
    self.line2.y = self.stepPricesView.bottom;
    
    self.stockLabel.width = screenWidth - self.stockLabel.x -16.f;
    self.stockLabel.y = self.line2.bottom + 4.f;
    
    self.addrLabel.width = screenWidth - self.addrLabel.x -16.f;
    [self.addrLabel sizeToFit];
    self.addrLabel.x = self.titleLabel.x;
    self.addrLabel.y = self.stockLabel.bottom;
    
    self.expressLabel.width = screenWidth - self.expressLabel.x -16.f;
    [self.expressLabel sizeToFit];
    self.expressLabel.x = self.titleLabel.x;
    self.expressLabel.y = self.addrLabel.bottom + 4.f;
    
    self.messageLabel.width = screenWidth - self.messageLabel.x -16.f;
    if (self.messageLabel.text.length == 0) {
        self.messageLabel.height = 0;
    }
    else {
        [self.messageLabel sizeToFit];
        self.messageLabel.x = self.titleLabel.x;
        
    }
    self.messageLabel.y = self.expressLabel.bottom + 4.f;
}

-(CGFloat)cellHeight
{
    return ceil(self.messageLabel.bottom + 8.f);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 12.f);
//    self.contentView.y = self.headView.bottom;
}

@end
