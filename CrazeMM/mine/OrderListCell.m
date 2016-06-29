//
//  WaitForPayCell.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell()

@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UILabel* companyLabel;
@property (nonatomic, strong) UIImageView* companyIcon;

@property (nonatomic, strong) UILabel* statusLabel;
@property (nonatomic, strong) UILabel* flagLabel;
@end

@implementation OrderListCell

-(UILabel*)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_statusLabel];
        _statusLabel.font = [UIFont systemFontOfSize:12.f];
        _statusLabel.textColor = [UIColor grayColor];
    }
    return _statusLabel;
}

-(UILabel*)flagLabel
{
    if (!_flagLabel) {
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];//
        _flagLabel.font = [UIFont systemFontOfSize:12.f];

        _flagLabel.layer.cornerRadius = 4.f;
        _flagLabel.clipsToBounds = YES;
        _flagLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];
        
        [self.contentView addSubview:_flagLabel];

    }
    
    return _flagLabel;
}

-(UILabel*)companyLabel
{
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:13.f];
        [self.companyWithIconLabel addSubview:_companyLabel];
    }
    
    return _companyLabel;
}
-(UIImageView*)companyIcon
{
    if (!_companyIcon) {
        _companyIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.companyWithIconLabel addSubview:_companyIcon];
    }
    
    return _companyIcon;
}

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
    // Initialization code
    
    self.selectedCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectedCheckBox.onTintColor = [UIColor redColor];
    self.selectedCheckBox.onFillColor = [UIColor redColor];
    self.selectedCheckBox.boxType = BEMBoxTypeCircle;
    self.selectedCheckBox.on = YES  ;
    self.selectedCheckBox.animationDuration = 0.f;
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    self.totalPriceLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    self.backgroundLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.reactiveButton addTarget:self action:@selector(reactiveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    

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
    
    self.totalPriceLabel.text = @"";
    self.totalPriceLabel.textAlignment = NSTextAlignmentRight;
    
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
    self.totalPriceLabel.attributedText = attributedText;
}

-(void)fomartCompanyLabel
{        NSString* companyIconURL = @"http://invalid_image";
    NSString* companyName = @"疯狂买卖王";
    
    if (self.orderDetailDTO) {
        companyIconURL = self.orderDetailDTO.userImage;
        companyName = self.orderDetailDTO.userName;
    }
    
    if (![companyIconURL hasPrefix:@"http"]) {
        companyIconURL = COMB_URL(companyIconURL);
    }
    
    self.companyLabel.text = companyName;
    [self.companyIcon setImageWithURL:[NSURL URLWithString:companyIconURL] placeholderImage:[UIImage imageNamed:@"company_icon"]];
    
    [self.companyLabel sizeToFit];
}

-(void)fomartOrderLabel
{
    if (self.orderDetailDTO) {
        self.orderLabel.text = [NSString stringWithFormat:@"订单号: %ld", self.orderDetailDTO.id];
    }
    else {
        self.orderLabel.text = @"订单号: 123456";
    }
    [self.orderLabel sizeToFit];
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
    
    self.statusLabel.text = string;
    [self.statusLabel sizeToFit];
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
    NSMutableString* amountLabelString = [[NSMutableString alloc] initWithFormat:@"数量: %ld", _orderDetailDTO.quantity ];
    if (NotNilAndNull(orderDetailDTO.depotDto) && orderDetailDTO.depotDto.name.length>0) {
        [amountLabelString appendString:[NSString stringWithFormat:@" (%@)", orderDetailDTO.depotDto.name]];
    }
    else {
        [amountLabelString appendString:[NSString stringWithFormat:@" (%@)", @"卖家发货"]];

    }
    self.amountLabel.text = amountLabelString;
    self.priceLabel.text = [NSString stringWithFormat:@"单台定价: %.02f", _orderDetailDTO.price];
    if (!_orderDetailDTO.isAony) {
        [self fomartCompanyLabel];
    }
    
    self.flagLabel.text = [NSString stringWithFormat:@" %@ ", orderDetailDTO.stateLabel];
    [self.flagLabel sizeToFit];
    
    [self fomartTotalPriceLabel];
    [self fomartStatusLabel];
    [self layoutAllSubvies];
}

-(void)layoutAllSubvies
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    if (self.hiddenCheckbox) {
        self.selectedCheckBox.hidden = YES;
        self.orderLabel.x = 8.f;
    }
    else{
        self.selectedCheckBox.hidden = NO;
        self.selectedCheckBox.x = 8.f;
        self.orderLabel.x = self.selectedCheckBox.right + 4.f;
    }
    
    self.flagLabel.x = self.orderLabel.right + 4.f;
    self.flagLabel.height = self.orderLabel.height;
    self.flagLabel.bottom = self.orderLabel.bottom;
    
    self.companyWithIconLabel.width = screenWidth - 8.f - self.companyWithIconLabel.x;
    self.companyLabel.right = self.companyWithIconLabel.width;
    self.companyIcon.right = self.companyLabel.x - 4.f;
    self.companyLabel.bottom = self.companyIcon.bottom = self.companyWithIconLabel.height;
    
    self.seperatorLine.x = 8.f;
    self.seperatorLine.width = screenWidth - 8.f*2;
    
    self.productDescLabel.x = 8.f;
    self.productDescLabel.width = screenWidth - 8.f*2;
    
    self.statusLabel.x = 8.f;
    self.statusLabel.width = screenWidth - 8.f*2;
    self.statusLabel.y = self.productDescLabel.bottom;
    
    self.amountLabel.x = 8.f;
    self.amountLabel.y = self.statusLabel.bottom + 4.f;
    self.amountLabel.width = screenWidth - 8.f*2;
    
    self.priceLabel.x = 8.f;
    self.priceLabel.y = self.amountLabel.bottom + 4.f;
    self.priceLabel.width = screenWidth - 8.f*2;
    
    self.backgroundLabel.x = 0.f;
    self.backgroundLabel.y = self.priceLabel.bottom + 4.f;
    self.backgroundLabel.width = screenWidth ;
    
    self.totalPriceLabel.right = self.backgroundLabel.width-8.f;
}

-(void)reactiveButtonClicked:(id)sender
{
    if (sender == self.reactiveButton) {
        if ([self.delegate respondsToSelector:@selector(reactiveButtonClicked:)]) {
            [self.delegate reactiveButtonClicked:self.orderDetailDTO];
        }
    }
}

+(CGFloat)cellHeight
{
    return 150.f + 8.f + 16.f;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headView.frame = CGRectMake(0, 0, self.bounds.size.width, self.headView.height);
    self.contentView.y = self.headView.height;
    self.contentView.height = self.height-self.headView.height;
    
    self.backgroundLabel.bottom = self.contentView.height;

}

-(void)dealloc
{
    NSLog(@"Wait for pay cell dealloc");
}

@end


@implementation WrappedOrderDetailDTO

-(instancetype)initWithOrderDetail:(OrderDetailDTO *)dto
{
    self = [super init];
    if (self) {
        self.dto = dto;
//        self.selected = 
    }
    return self;
}

//-(void)setSelected:(BOOL)selected
//{
//    _selected = selected;
//    if (self.cell) {
//        self.cell.selectedCheckBox.on = selected;
//        [self.cell layoutIfNeeded];
//    }
//}


-(void)dealloc
{
    NSLog(@"WrappedOrderDetailDTO dealloc");
}

@end

