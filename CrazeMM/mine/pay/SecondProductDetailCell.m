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

@end

@implementation SecondProductDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

-(UIView*)createProductViewWithImage:(NSString*)imageName andNumber:(NSUInteger)num andTag:(NSUInteger)tag
{
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65+4, 65)];
//    
//    view.backgroundColor = [UIColor whiteColor];
//    
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,65,65)];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.image = [UIImage imageNamed:imageName];
//    
//    ProductNumberLabel* numberLabel = [[[NSBundle mainBundle]loadNibNamed:@"ProductNumberLabel" owner:nil options:nil] firstObject];
//    numberLabel.numberLabel.text = [NSString stringWithFormat:@"%lu", num];
//    numberLabel.numberLabel.frame = CGRectMake(50, 50, 20, 10);
////    numberLabel.frame = CGRectMake(0, 0, 20, 8);
////    numberLabel.right = imageView.right + 4;
////    numberLabel.bottom = imageView.bottom-6;
//    
//    [view addSubview:imageView];
//    [view addSubview:numberLabel];
    
    ProductWithNumberView* view = [[[NSBundle mainBundle]loadNibNamed:@"ProductWithNumberView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, 68, 64);
    view.imageView.image = [UIImage imageNamed:imageName];
    view.numberLabel.text = @"50台";
    view.numberLabel.adjustsFontSizeToFitWidth = YES;
    
        view.imageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        view.imageView.layer.borderWidth = 1.f;

    return view;
                    
}

-(ProductSumLabel*)createProductSumLabel
{
    ProductSumLabel* view = [ProductSumLabel new];
    view.totalNumLabel.text = @"共150台";
    //[view.totalNumLabel sizeToFit];
    //[view.totalPriceLabel appendText:@"实付金额:￥10,000,00.00"];
    //[view.totalPriceLabel sizeToFit];
    //view.frame = CGRectMake(170, 32, 160, 60);
    self.productSumLabel = view;

    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"实付金额:"];
    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:14.f]];
    [attributedText m80_setTextColor:[UIColor grayColor]];
    [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"￥"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"10,000,00"];
    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:18.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@".00"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.productSumLabel.totalPriceLabel appendAttributedText:attributedText];
    [self.contentView addSubview:view];
    

    return view;
    

}

-(void)commonInit
{
    if (self.productNumber == 0) {
        self.productNumber = 4;
    }
    
    NSArray* imges = @[@"iphone", @"android"];
    
    CGFloat y = 8.f;
    CGFloat x = 16.f;
    
    for (NSUInteger i=0; i<self.productNumber; i+=2) {
        x = 8.f;
        UIView* view1 = [self createProductViewWithImage:imges[0] andNumber:100 andTag:i];
        view1.x = x;
        view1.y = y;
        [self.contentView addSubview:view1];
        x += 8.f+view1.width;
        
        if (i+1 < self.productNumber) {
            UIView* view2 = [self createProductViewWithImage:imges[1] andNumber:100 andTag:i];
            view2.x = x;
            view2.y = y;
            [self.contentView addSubview:view2];
        }
        
        y += 8.f + view1.height;
        
    }
    
    self.height = y +8.f;
    
    [self createProductSumLabel];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.productSumLabel.width = self.contentView.width - 64*2 -16.f*3 +8.f;
    self.productSumLabel.x = 64*2 + 16.f*2;
    self.productSumLabel.height = 60.f;
    self.productSumLabel.y = self.height/2-self.productSumLabel.height/2;

}

@end
