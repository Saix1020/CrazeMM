//
//  SecondProductDetailCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SecondProductDetailCell.h"
#import "ProductWithNumberView.h"
#import "ProductSumLabel.h"

@interface SecondProductDetailCell ()

@property (nonatomic, strong) ProductSumLabel* productSumLabel;

//@property (nonatomic) NSUInteger productNumber;
@property (nonatomic) NSInteger totalAmount;
@property (nonatomic) float totalPrice;
@property (nonatomic, strong) NSMutableArray* imageViews;
//@property (nonatomic, copy) 

@end

@implementation SecondProductDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self commonInit];
    }
    
    return self;
}

-(UIView*)createProductViewWithImage:(NSString*)imageName andNumber:(NSUInteger)num andTag:(NSUInteger)tag
{
    ProductWithNumberView* view = [[[NSBundle mainBundle]loadNibNamed:@"ProductWithNumberView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, 68, 64);
    if (imageName) {
        if (![imageName hasPrefix:@"http"]) {
            if ([imageName hasPrefix:@"/"]) {
                imageName = COMB_URL(imageName);
            }
            else {
                imageName = [NSString stringWithFormat:@"/%@", imageName];
                imageName = COMB_URL(imageName);
                
            }
        }
        [view.imageView setImageWithURL:[NSURL URLWithString:imageName] placeholderImage: [@"android" image]];
    }
    
    view.numberLabel.text = [NSString stringWithFormat:@"%ld台", num];
    view.numberLabel.adjustsFontSizeToFitWidth = YES;
    
        view.imageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        view.imageView.layer.borderWidth = 1.f;

    return view;
                    
}

-(ProductSumLabel*)createProductSumLabel
{
    ProductSumLabel* view = [ProductSumLabel new];
    view.totalNumLabel.text = [NSString stringWithFormat:@"共 %ld 台", self.totalAmount];
    //[view.totalNumLabel sizeToFit];
    //[view.totalPriceLabel appendText:@"实付金额:￥10,000,00.00"];
    //[view.totalPriceLabel sizeToFit];
    //view.frame = CGRectMake(170, 32, 160, 60);
    self.productSumLabel = view;
    if (self.stockDTOs) {
        self.productSumLabel.totalPriceLabel.text = @"";
//        view.totalNumLabel.centerY = view.centerY;
    }
    else {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"实付金额:"];
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[UIColor grayColor]];
        [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
        
        attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
        [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[UIColor redColor]];
        [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
        
        
        NSString* totalPrice = [NSString stringWithFormat:@"%.02f", self.totalPrice];
        NSString* comp1 = [totalPrice componentsSeparatedByString:@"."][0];
        NSString* comp2 = [NSString stringWithFormat:@".%@",  [totalPrice componentsSeparatedByString:@"."][1]];
        
        attributedText = [[NSMutableAttributedString alloc]initWithString:comp1];
        [attributedText m80_setFont:[UIFont boldSystemFontOfSize:18.f]];
        [attributedText m80_setTextColor:[UIColor redColor]];
        [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
        
        attributedText = [[NSMutableAttributedString alloc]initWithString:comp2];
        [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[UIColor redColor]];
        [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
    }
    
    [self.contentView addSubview:view];
    
    return view;

}

-(void)setOrderDetailDtos:(NSArray<OrderDetailDTO*>*)orderDetailDtos
{
    _orderDetailDtos = orderDetailDtos;
    self.totalAmount = 0;
    self.totalPrice = 0;
    for (UIView* view in self.imageViews) {
        [view removeFromSuperview];
    }
    
    self.imageViews = [[NSMutableArray alloc] init];
    
    NSUInteger tag = 0;
    for(OrderDetailDTO* dto in orderDetailDtos)
    {
        self.totalAmount += dto.quantity;
        self.totalPrice += dto.quantity * dto.price;
        
        UIView* view = [self createProductViewWithImage:dto.goodImage andNumber:dto.quantity andTag:tag];
        [self.imageViews addObject:view];
    }
    
    [self refreshSubviews];
}

-(void)setStockDTOs:(NSArray<MineStockDTO *> *)stockDTOs
{
    _stockDTOs = stockDTOs;
    self.totalAmount = 0;
    self.totalPrice = 0;
    for (UIView* view in self.imageViews) {
        [view removeFromSuperview];
    }
    
    self.imageViews = [[NSMutableArray alloc] init];
    
    NSUInteger tag = 0;
    for(MineStockDTO* dto in stockDTOs)
    {
        self.totalAmount += dto.total;
        
        UIView* view = [self createProductViewWithImage:dto.goodImage andNumber:dto.total andTag:tag];
        [self.imageViews addObject:view];
    }
    
    [self refreshSubviews];
}

-(void)commonInit
{
    if (self.productNumber == 0) {
        self.productNumber = 5;
    }
    
    self.clipsToBounds = YES;

    
    NSArray* imges = @[@"iphone", @"android"];
    
    CGFloat y = 8.f;
    CGFloat x = 16.f;
    self.imageViews = [[NSMutableArray alloc]  init];
    for (NSUInteger i=0; i<self.productNumber; i+=2) {
        x = 8.f;
        UIView* view1 = [self createProductViewWithImage:nil andNumber:100 andTag:i];
        view1.x = x;
        view1.y = y;
        [self.contentView addSubview:view1];
        [self.imageViews addObject:view1];
        x += 8.f+view1.width;
        
        if (i+1 < self.productNumber) {
            UIView* view2 = [self createProductViewWithImage:nil andNumber:100 andTag:i];
            view2.x = x;
            view2.y = y;
            [self.imageViews addObject:view2];
            [self.contentView addSubview:view2];
        }
        
        y += 8.f + view1.height;
        
    }
    
    self.height = y +8.f;
    
    [self createProductSumLabel];
    
}

-(void)refreshSubviews
{
    
    CGFloat y = 8.f;
    CGFloat x = 16.f;
    
    for (NSUInteger i=0; i<self.imageViews.count; i+=2) {
        x = 8.f;
        UIView* view1 = self.imageViews[i];
        view1.x = x;
        view1.y = y;
        [self.contentView addSubview:view1];
        x += 8.f+view1.width;
        
        if (i+1 < self.imageViews.count) {
            UIView* view2 = self.imageViews[i+1];;
            view2.x = x;
            view2.y = y;
            [self.contentView addSubview:view2];
        }
        
        y += 8.f + view1.height;
        
    }
    
    self.height = y +8.f;
    
    [self createProductSumLabel];
    
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.productSumLabel.width = self.contentView.width - 64*2 -16.f*3 +8.f;
    self.productSumLabel.x = 64*2 + 16.f*2;
    self.productSumLabel.height = 60.f;
    if (self.stockDTOs) {
        self.productSumLabel.y = self.height/2-self.productSumLabel.height/2 + 20.f;

    }
    else {
        self.productSumLabel.y = self.height/2-self.productSumLabel.height/2;
 
    }

}

@end
