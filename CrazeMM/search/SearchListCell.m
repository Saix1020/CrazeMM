//
//  SearchListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchListCell.h"

#define kMaxTitleLength 36

@interface SearchListCell()
@property(nonatomic, strong) UIImageView* clockView;
@property(nonatomic, strong) UILabel* tagLabel;
@end

@implementation SearchListCell

-(UILabel*)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];
        _tagLabel.textColor = [UIColor UIColorFromRGB:0x346796];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.text = @"原封";
        _tagLabel.font = [UIFont systemFontOfSize:14.f];
        [_tagLabel sizeToFit];
        _tagLabel.width += 16.f;
        _tagLabel.clipsToBounds = YES;
        _tagLabel.layer.cornerRadius = _tagLabel.height/2;
    }
    
    return _tagLabel;
}

-(UIImageView*)clockView
{
    if (!_clockView) {
        _clockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        _clockView.image = [UIImage imageNamed:@"Clock-1"];
        
    }
    return _clockView;
}

-(ArrowView*)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[ArrowView alloc] init];
        _typeLabel.textLabel.text = @"求购";
        _typeLabel.frame = CGRectMake(0, 0, 38, 16);
    }
    
    return _typeLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andResultItem:(NSUInteger) item
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.typeName = @"供货";
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.typeName = @"供货";
        [self initAllSubviews];
    }
    
    return self;
}

-(void)initAllSubviews
{
    self.titleLabel = [[M80AttributedLabel alloc] init];
    [self fomartTitleLabel];
    
//    self.titleLabel.font = [UIFont systemFontOfSize:20];
//    self.titleLabel.numberOfLines = 2;
//    self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.titleLabel.text = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    
    self.priceLabel = [[M80AttributedLabel alloc] init];
    [self fomartPriceLabel];
//    self.priceLabel.font = [UIFont systemFontOfSize:17];
//    self.priceLabel.numberOfLines = 1;
//    self.priceLabel.adjustsFontSizeToFitWidth = YES;
//    self.priceLabel.textColor = [UIColor redColor];
//    self.priceLabel.text = @"￥1020.00起 10台";

    
    self.seperatorLine = [[UIView alloc] init];
    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.layer.borderColor = RGBCOLOR(240, 240, 240).CGColor;
//    self.seperatorLine.alpha = .25f;
    
    
    self.arrivalTime = [[UILabel alloc] init];
    self.arrivalTime.font = [UIFont systemFontOfSize:13];
    self.arrivalTime.numberOfLines = 1;
    self.arrivalTime.adjustsFontSizeToFitWidth = YES;
    self.arrivalTime.textColor = RGBCOLOR(131, 131, 131);
    self.arrivalTime.text = @"到货周期:24小时";
    
    
    self.scopeLabel = [[UILabel alloc] init];
    self.scopeLabel.font = [UIFont systemFontOfSize:13];
    self.scopeLabel.numberOfLines = 1;
    self.scopeLabel.adjustsFontSizeToFitWidth = YES;
    self.scopeLabel.textColor = RGBCOLOR(131, 131, 131);
    self.scopeLabel.text = @"供货范围: 北京,北京,北京,北京,北京";

    
    self.companyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company_icon"]];
    
    self.companyLabel = [[UILabel alloc] init];
    self.companyLabel.font = [UIFont systemFontOfSize:15];
    self.companyLabel.numberOfLines = 1;
    self.companyLabel.adjustsFontSizeToFitWidth = YES;
    self.companyLabel.text = @"江苏梁晶信息技术有限公司";
    self.companyLabel.textColor = RGBCOLOR(50, 50, 50);
//    self.scopeLabel.textColor = RGBCOLOR(131, 131, 131);
    
    self.leftTimeLabel = [[M80AttributedLabel alloc] init];
    self.leftTimeLabel.backgroundColor = [UIColor lightGrayColor188];
    self.leftTimeLabel.text = @"10 天 18 小时 20 分钟";
    [self fomartTimeLeftLabel];
    
    self.typeLabel = [[ArrowView alloc] init];
    self.typeLabel.textLabel.textColor = [UIColor greenTextColor];
    self.typeLabel.textLabel.text = self.typeName;
    
    NSArray* titles = @[@"浏览:10", @"成交:2"];
    self.previewAndTransctionsLabels = [[LabelWithSeperatorLine alloc] init];
    self.previewAndTransctionsLabels.strings = titles;
    
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.arrivalTime];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.companyImageView];
    [self.contentView addSubview:self.scopeLabel];
    [self.contentView addSubview:self.leftTimeLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.previewAndTransctionsLabels];
    
    [self layoutAllLabels];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)fomartTitleLabel
{
    NSString* title = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA V387 黑色 黑色";
    UIFont* font = [UIFont systemFontOfSize:20.f];
    
    if (title.length > kMaxTitleLength) {
        title = [NSString stringWithFormat:@"%@...", [title substringToIndex:kMaxTitleLength]];
    }
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:title];
    [attributedText m80_setFont:font];
    [self.titleLabel appendAttributedText:attributedText];
    [self.titleLabel appendText:@" "];
    [self.titleLabel appendView:self.tagLabel margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.titleLabel sizeToFit];
//    self.titleLabel.numberOfLines = 2;
    //[attributedText

}


-(void)fomartTimeLeftLabel
{
    NSString* timeLeftString = self.leftTimeLabel.text;
    self.leftTimeLabel.text = @"";
    self.leftTimeLabel.textAlignment = kCTTextAlignmentCenter;
    [self.leftTimeLabel appendView:self.clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.leftTimeLabel appendText:@" "];
    
    NSArray *colors = @[[UIColor redColor], [UIColor blackColor]];
    NSArray *components = [timeLeftString componentsSeparatedByString:@" "];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index%2]];
        [self.leftTimeLabel appendAttributedText:attributedText];
        [self.leftTimeLabel appendText:@""];
        index ++;
    }
    
    //self.leftTimeLabel.offsetY = 4.f;
    
    [self.leftTimeLabel sizeToFit];
}

-(void)fomartPriceLabel
{
    NSString* detailString = self.priceLabel.text;
    self.priceLabel.text = @"";
    
    self.priceLabel.textAlignment = kCTTextAlignmentCenter;

    
    //    self.detailLabel.text = @"￥1020.00起 10台";
    
    UIFont* largFont = [UIFont boldSystemFontOfSize:20];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor blackColor], [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       smallFont, largFont, middleFont];
    
    NSArray* components = @[@"￥", @"1020", @".00", @"起  ", @"10", @"台"];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        [self.priceLabel appendAttributedText:attributedText];
        index ++;
    }
//    [self.priceLabel appendView:self.typeLabel margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    
    [self.priceLabel sizeToFit];
}

-(void)layoutAllLabels
{
    [self.priceLabel sizeToFit];
    //[self.typeLabel sizeToFit];
    
    CGRect bounds = self.contentView.bounds;
    bounds.size.width = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = 16.f;
    self.previewAndTransctionsLabels.frame = CGRectMake(bounds.size.width-50-16.f, y, 50, 60);
    self.titleLabel.frame = CGRectMake(16.f, y,
                                       bounds.size.width-70-16.f*2, 60.f);
    y += self.titleLabel.frame.size.height;
    
    
    self.priceLabel.frame = CGRectMake(16.f, y,
                                       self.priceLabel.frame.size.width, self.priceLabel.height);
    self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+4.f, self.priceLabel.center.y - self.typeLabel.frame.size.height/2,
                                      43.f, 18.f);
    self.typeLabel.y = self.titleLabel.bottom+2.f;
    //self.typeLabel.height = self.priceLabel.height;
    
    y += self.priceLabel.frame.size.height+12.f;
    
    self.seperatorLine.frame = CGRectMake(16.f, y, bounds.size.width-2*16.f, 1);
    
    y += self.seperatorLine.frame.size.height+12.f;
    self.arrivalTime.frame = CGRectMake(16.f, y,
                                        bounds.size.width-2*16.f, 24.f);
    
    y += self.arrivalTime.frame.size.height-4.f;
    self.scopeLabel.frame = CGRectMake(16.f, y,
                                       bounds.size.width-2*16.f, 24.f);
    
    y += self.scopeLabel.frame.size.height + 4.f;
    
    self.leftTimeLabel.frame =CGRectMake(bounds.size.width-150.f, y+4.f,
                                         150.f, self.leftTimeLabel.height-4.f);
    
    self.companyImageView.frame = CGRectMake(12.f, y, 24.f, 24.f);
    self.companyLabel.frame = CGRectMake(self.companyImageView.right, y,
                                         bounds.size.width-2*16.f-150.f, 24.f);

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

+(CGFloat)cellHeight
{
    return 210.f;
}


@end
