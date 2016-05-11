//
//  ProductMiddleCell.m
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductCompanyCell.h"

@implementation ProductCompanyCell

//@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
//@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
//@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
//@property (weak, nonatomic) IBOutlet UIButton *moreDetailButton;
//@property (weak, nonatomic) IBOutlet UIImageView *star3;
//@property (weak, nonatomic) IBOutlet UIImageView *star4;
//@property (weak, nonatomic) IBOutlet UIImageView *star5;
//
//@property (weak, nonatomic) IBOutlet UIImageView *start2;
//@property (weak, nonatomic) IBOutlet UIButton *authedButton;
//@property (weak, nonatomic) IBOutlet UIImageView *star1;
//@property (weak, nonatomic) IBOutlet UIButton *contactButton;


- (void)awakeFromNib
{
    [self.moreDetailButton setImage:[UIImage imageNamed:@"rightR"] forState:UIControlStateNormal];
    
//    self.companyNameLabel.adjustsFontSizeToFitWidth = YES;
//    self.locationLabel.adjustsFontSizeToFitWidth = YES;
    self.companyNameLabel.textColor = [UIColor grayColorL2];
    self.locationLabel.textColor = [UIColor grayColorL2];
    self.levelLabel.textColor = [UIColor grayColorL2];
    
    self.contactButton.tintColor = [UIColor grayColorL2];
    self.contactButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10.f, 0, 10.f);
    [self.contactButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.contactButton setTitle:@"给我留言" forState:UIControlStateNormal];
    [self.contactButton setTitleColor:[UIColor grayColorL2] forState:UIControlStateNormal];
    
    self.contactButton.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.contactButton.layer.borderWidth = .5f;
    self.contactButton.layer.cornerRadius = 4.f;
    
    self.moreDetailButton.tintColor = [UIColor grayColorL2];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProductDetailDto:(BaseProductDetailDTO *)productDetailDto
{
    _productDetailDto = productDetailDto;
    self.companyNameLabel.text = [NSString stringWithFormat:@"%@ (%@)", productDetailDto.users.username, productDetailDto.users.typeName];
    self.checkedImage.hidden = !(productDetailDto.users.validateState == 300);
    self.locationLabel.text = [NSString stringWithFormat:@"成交单数: %ld", productDetailDto.users.successOrderCount];
    
    [self.logoImageView setImageWithURL:[NSURL URLWithString:COMB_URL(@"/weui/images/product.jpg")] placeholderImage:[@"logo-2" image]];
}

+(CGFloat)cellHeight
{
    return 165.f;
}

@end
