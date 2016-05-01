//
//  WaitForDeliverCell.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WaitForDeliverCell.h"

@interface WaitForDeliverCell()
@property (nonatomic, strong) UIView* headView;
@end

@implementation WaitForDeliverCell

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
}

-(void)fomartTotalPriceLabel
{
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
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@"5,5550"];
    [attributedText m80_setFont:[UIFont boldSystemFontOfSize:16.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    
    attributedText = [[NSMutableAttributedString alloc]initWithString:@".00"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [attributedText m80_setTextColor:[UIColor redColor]];
    [self.totalPriceLabel appendAttributedText:attributedText];
    [self.totalPriceLabel appendText:@""];
    self.totalPriceLabel.numberOfLines = 1;
    self.totalPriceLabel.offsetY = -4.f;
    //[self.totalPriceLabel sizeToFit];
    //self.totalPriceLabel.baselineAdjustment = UIBaselineAdjustmentNone;
}

-(void)fomartCompanyLabel
{
    //    self.companyLabel.text = @"江苏梁晶信息技术有限公司";
    //    self.companyLabel.font = [UIFont systemFontOfSize:12.f];
    //    self.companyIcon.image = [UIImage imageNamed:@"company_icon"];
    self.companyWithIconLabel.textAlignment = kCTTextAlignmentRight;
    UIImageView* companyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    companyImageView.image = [UIImage imageNamed:@"company_icon"];
    
    
    [self.companyWithIconLabel appendView:companyImageView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    //[self.companyWithIconLabel appendText:@" "];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"江苏梁晶信息技术有限公司"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:13.f]];
    [attributedText m80_setTextColor:[UIColor blackColor]];
    
    [self.companyWithIconLabel appendAttributedText:attributedText];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headView.frame = CGRectMake(0, 0, self.bounds.size.width, self.headView.height);
    self.contentView.y = self.headView.height;
    self.contentView.height = self.height-self.headView.height;
}


@end
