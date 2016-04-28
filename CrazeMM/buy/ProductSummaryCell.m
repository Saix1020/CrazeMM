//
//  ProductSummaryCell.m
//  CrazeMM
//
//  Created by saix on 16/4/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductSummaryCell.h"

@interface ProductSummaryCell()

@property (strong, nonatomic)  UIImageView *phoneImageView;
@property (strong, nonatomic)  M80AttributedLabel *titleLabel;
@property (strong, nonatomic)  UILabel *detailLabel;
@property (strong, nonatomic)  ArrowView *arrawView;
@property (strong, nonatomic)  UIView *bottomLine;
@property (strong, nonatomic)  UILabel *statusLabel;
@property (strong, nonatomic)  M80AttributedLabel *timeLeftLabel;
@property (strong, nonatomic)  UIImageView* triangleImageView;

@end

@implementation ProductSummaryCell

-(UIImageView*)phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prod_placeholder"]];
        [self.contentView addSubview:_phoneImageView];
    }
    
    return _phoneImageView;
}

-(UIImageView*)triangleImageView {
    if (!_triangleImageView) {
        _triangleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle"]];
        [self.contentView addSubview:_triangleImageView];
    }
    
    return _triangleImageView;
}

-(M80AttributedLabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[M80AttributedLabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(ArrowView*)arrawView
{
    if (_arrawView) {
        _arrawView = [[ArrowView alloc] init];
        [self.contentView addSubview:_arrawView];

    }
    
    return _arrawView;
}

-(UILabel*)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_detailLabel];
    }
    
    return _detailLabel;
}

-(UILabel*)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_statusLabel];
        _statusLabel.backgroundColor = [UIColor greenTextColor];
        _statusLabel.textColor = [UIColor whiteColor];
    }
    
    return _statusLabel;
}

-(M80AttributedLabel*)timeLeftLabel
{
    if (!_timeLeftLabel) {
        _timeLeftLabel = [[M80AttributedLabel alloc] init];
        [self.contentView addSubview:_timeLeftLabel];
        _timeLeftLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timeLeftLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commInit];
    }
    
    return self;
}


-(void)commInit
{
    
    self.backgroundColor = [UIColor whiteColor];
    //self.titleLabel.adjustsFontSizeToFitWidth = YES;
    //self.arrawView.textLabel.text = @"求购";
    
    //self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    self.detailLabel.text = @"￥1020.00起 10台";
    self.detailLabel.font = [UIFont fontWithName:self.detailLabel.font.fontName size:15.f];
    self.detailLabel.textColor = [UIColor orangeColor];
    self.detailLabel.adjustsFontSizeToFitWidth = YES;
    
    //self.timeLeftLabel.text = @"10 天 18 小时 20 分钟";
    M80AttributedLabel *label = self.timeLeftLabel;
    
#define UIColorFromRGB(rgbValue) [UIColor UIColorFromRGB:(rgbValue)]
    
    NSArray *fonts = @[[UIFont systemFontOfSize:12],[UIFont systemFontOfSize:13],[UIFont systemFontOfSize:17],[UIFont systemFontOfSize:25]];
    NSArray *colors= @[UIColorFromRGB(0x000000),UIColorFromRGB(0x0000FF),UIColorFromRGB(0x00FF00),UIColorFromRGB(0xFF0000)];
    
    NSArray *components = [@"10 天 18 小时 20 分钟" componentsSeparatedByString:@" "];
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        NSInteger index = arc4random() % 4;
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        
        [label appendAttributedText:attributedText];
        [label appendText:@" "];
    }
    
    UIImageView* clock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    clock.image = [UIImage imageNamed:@"Clock-1"];
    [label appendView:clock];
    
    label = self.titleLabel;
    components = [@"飞利浦 -V387 黑色 1GB 联通 3G WCDMA" componentsSeparatedByString:@" "];
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        NSInteger index = arc4random() % 4;
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        
        [label appendAttributedText:attributedText];
        [label appendText:@" "];
    }
    
    
    self.phoneImageView.image = [UIImage imageNamed:@"prod_placeholder.jpg"];
    self.phoneImageView.layer.borderWidth = 1;
    self.phoneImageView.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
    self.bottomLine.layer.borderWidth = 0.5;
    self.bottomLine.layer.borderColor = [UIColor lightGrayColor188].CGColor;
    
    
    self.statusLabel.backgroundColor = [UIColor greenTextColor];
    self.statusLabel.text = @"正常";
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)layoutAllSubviews
{
    [self commInit];
    
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.phoneImageView.frame = CGRectMake(24.f, 0, 100, 100);;
    self.phoneImageView.centerY = self.contentView.centerY;
    
    self.titleLabel.frame = CGRectMake(self.phoneImageView.right + 16.f, self.phoneImageView.y, 0, 50);
    self.titleLabel.width = maxWidth - 16.f - self.titleLabel.x;
    
    [self.timeLeftLabel sizeToFit];
    self.timeLeftLabel.bottom = self.phoneImageView.bottom;
    self.timeLeftLabel.x = self.titleLabel.x;
    //self.timeLeftLabel.height = 22.f;
    self.timeLeftLabel.width = self.titleLabel.width;
}

-(void)fomartTimeLabel
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutAllSubviews];
}

+(CGFloat)cellHeight
{
    return 140.f;
}

@end
