//
//  WaitForDeliverCell.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderListNoCheckBoxCell.h"

@interface OrderListNoCheckBoxCell()
@property (nonatomic, strong) UIView* headView;
@end

@implementation OrderListNoCheckBoxCell

-(UIView*)headView
{
    if(!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 8.f)];
        [self addSubview:_headView];
        _headView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
        //        _headView.
        
    }
    return _headView;
}


- (void)awakeFromNib {
    [self fomartCompanyLabel];
    [self fomartTotalPriceLabel];
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.needHeadView = YES;
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
    
    self.totalPriceLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    self.backgroundLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    
    self.totalPriceLabel.text = @"";
    self.totalPriceLabel.textAlignment = kCTTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"总价: "];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor grayColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:priceArray[0]];
    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:16.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:priceArray[1]];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    [self.totalPriceLabel appendText:@""];
    self.totalPriceLabel.numberOfLines = 1;
    self.totalPriceLabel.offsetY = -4.f;
}

-(void)fomartCompanyLabel
{
    self.companyWithIconLabel.text = @"";
    
    NSString* companyIconURL = @"http://invalid_image";
    NSString* companyName = @"江苏梁晶信息技术有限公司";
    
    if (self.orderDetailDTO) {
        companyIconURL = self.orderDetailDTO.userImage;
        companyName = self.orderDetailDTO.userName;
    }
    
    if (![companyIconURL hasPrefix:@"http"]) {
        companyIconURL = COMB_URL(companyIconURL);
    }
    
    self.companyWithIconLabel.textAlignment = kCTTextAlignmentRight;
    UIImageView* companyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [companyImageView setImageWithURL:[NSURL URLWithString:companyIconURL] placeholderImage:[UIImage imageNamed:@"company_icon"]];
    [self.companyWithIconLabel appendView:companyImageView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:companyName];
    [attributedText m80_setFont:[UIFont systemFontOfSize:13.f]];
    [attributedText m80_setTextColor:[UIColor blackColor]];
    [self.companyWithIconLabel appendText:@" "];
    [self.companyWithIconLabel appendAttributedText:attributedText];
}

-(void)fomartOrderLabel
{
    if (self.orderDetailDTO) {
        self.orderLabel.text = [NSString stringWithFormat:@"订单号: %ld", self.orderDetailDTO.id];
    }
    else {
        self.orderLabel.text = @"订单号: 123456";
    }
}

-(void)fomartProductDescLabel
{
    if (self.orderDetailDTO) {
        self.productDescLabel.text = self.orderDetailDTO.goodName;
    }
    else {
        self.productDescLabel.text = @"苹果-iPhone6 (金色/16G/全网通)";
    }
}

-(void)setOrderDetailDTO:(OrderDetailDTO *)orderDetailDTO
{
    _orderDetailDTO = orderDetailDTO;
    [self fomartOrderLabel];
    [self fomartProductDescLabel];
    self.amountLabel.text = [NSString stringWithFormat:@"数量: %ld", _orderDetailDTO.quantity];
    self.priceLabel.text = [NSString stringWithFormat:@"定价: %.02f", _orderDetailDTO.price];
    if (!_orderDetailDTO.isAony) {
        [self fomartCompanyLabel];
    }
    [self fomartTotalPriceLabel];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.needHeadView) {
        self.headView.frame = CGRectMake(0, 0, self.bounds.size.width, self.headView.height);
        self.contentView.y = self.headView.height;
        self.contentView.height = self.height-self.headView.height;

    }
}


@end
