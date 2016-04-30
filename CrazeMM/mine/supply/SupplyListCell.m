//
//  SupplyListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyListCell.h"

@implementation SupplyListCell

- (void)awakeFromNib {
   
    self.selectCheckBox.onCheckColor = [UIColor whiteColor];
    self.selectCheckBox.onTintColor = [UIColor redColor];
    self.selectCheckBox.onFillColor = [UIColor redColor];
    self.selectCheckBox.boxType = BEMBoxTypeCircle;
    self.selectCheckBox.on = YES  ;
    
//    [self fomartCompanyLabel];
//    [self fomartTotalPriceLabel];
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    [self fomartPriceLabel];
    
//    CGSize fontSize = [self.shareButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.shareButton.titleLabel.font}];
//    [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.shareButton.imageView.frame.size.width-4.f, 0, self.shareButton.imageView.frame.size.width+4.f)];
//    [self.shareButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];
    
    [self.shareButton exchangeImageAndText];
    [self.offButton exchangeImageAndText];
    
    //self.shareButton.buttonType =
    
    self.shareButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    self.offButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    
//    [self.shareButton setTintColor:[UIColor UIColorFromRGB:0x444444]  forState:UIControlStateNormal];
//    [self.offButton setTitleColor:[UIColor UIColorFromRGB:0x444444]  forState:UIControlStateNormal];
    
    //[self.shareButton setim:<#(nullable UIColor *)#> forState:<#(UIControlState)#>]


}



-(void)fomartPriceLabel
{
    NSString* priceString = self.priceLabel.text;
    
    NSArray* subStrings = [priceString componentsSeparatedByString:@" "];
    
    NSString* firstComponent = subStrings[0];
    NSString* secondComopent = [[subStrings subarrayWithRange:NSMakeRange(1, subStrings.count-1)] componentsJoinedByString:@""];
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:firstComponent
                                           attributes:@{
                                                        NSForegroundColorAttributeName: self.priceLabel.textColor
                                                            }];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:secondComopent attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}]];
    
    self.priceLabel.text = @"";
    self.priceLabel.attributedText = attributedText;
    
    self.backgroundView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    //self.backgroundView.hidden = YES;
}

-(void)setStyle:(SupplyListCellStyle)style
{
    _style = style;
    
    switch (style) {
        case kNomalStyle:
            self.backgroundView.hidden = NO;
            self.shareButton.hidden = NO;
            [self.offButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            self.offButton.imageView.transform = CGAffineTransformMakeRotation(0);

            [self.offButton setTitle:@"下架" forState:UIControlStateNormal];
            break;
        case kOffShelfStyle:
            self.shareButton.hidden = YES;
            self.backgroundView.hidden = NO;
            [self.offButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
            self.offButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            [self.offButton setTitle:@"上架" forState:UIControlStateNormal];
            break;
        case kDealStyle:
            self.backgroundView.hidden = YES;
            break;
        default:
            break;
    }
}

+(CGFloat)cellHeight
{
    return 150.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
