//
//  NewSearchListCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NewSearchListCell.h"
#import "UIView+SDAutoLayout.h"
#import "ArrowView.h"
#import "LabelWithSeperatorLine.h"
#import "NSAttributedString+Utils.h"

@interface NewSearchListCell()
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  LabelWithSeperatorLine *previewAndTransctionsLabels;
@property (strong, nonatomic)  UILabel *priceLabel;
@property (strong, nonatomic)  ArrowView *typeLabel;
@property (strong, nonatomic)  UILabel *arrivalTime;
@property (strong, nonatomic)  UILabel *scopeLabel;
@property (nonatomic, strong) UIView* seperatorLine;
@property (nonatomic, strong) UIView* bottomLine;
@property (strong, nonatomic)  UIImageView *companyImageView;
@property (strong, nonatomic)  UILabel *companyLabel;
@property (nonatomic, strong) UIView* companyInfoContaintView;
@property (nonatomic, strong) UIView* topSeperatorView;
@property (nonatomic, strong) UIView* statusContaintView;
@property (nonatomic, strong) UIImageView* clockView;
@property (nonatomic, strong) UILabel* statusLabel;
@property (strong, nonatomic)  NSString* typeName;

@end

@implementation NewSearchListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeName = @"求购";
        [self setup];
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTypeName:(NSString*)typeName
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeName = typeName;
        [self setup];

    }
    
    return self;
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

-(void)setup
{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 4;
    self.titleLabel.font = [UIFont systemFontOfSize:20.f];
    
    self.priceLabel = [[UILabel alloc] init];
    
    self.seperatorLine = [[UIView alloc] init];
//    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.backgroundColor = RGBCOLOR(240, 240, 240);
    
    self.arrivalTime = [[UILabel alloc] init];
    self.arrivalTime.font = [UIFont systemFontOfSize:13];
    self.arrivalTime.numberOfLines = 1;
    self.arrivalTime.adjustsFontSizeToFitWidth = YES;
    self.arrivalTime.textColor = RGBCOLOR(131, 131, 131);
    
    self.scopeLabel = [[UILabel alloc] init];
    self.scopeLabel.font = [UIFont systemFontOfSize:13];
    self.scopeLabel.numberOfLines = 0;
    self.scopeLabel.textColor = RGBCOLOR(131, 131, 131);
    
    
    self.companyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"company_icon"]];
    
    self.companyLabel = [[UILabel alloc] init];
    self.companyLabel.font = [UIFont systemFontOfSize:15];
    self.companyLabel.numberOfLines = 1;
    self.companyLabel.adjustsFontSizeToFitWidth = YES;
    self.companyLabel.textColor = RGBCOLOR(50, 50, 50);
    
    self.companyInfoContaintView = [[UIView alloc] init];
    [self.companyInfoContaintView addSubview:self.companyImageView];
    [self.companyInfoContaintView addSubview:self.companyLabel];
    
    self.typeLabel = [[ArrowView alloc] init];
    self.typeLabel.textLabel.textColor = [UIColor greenTextColor];
    self.typeLabel.textLabel.text = self.typeName;
    
    self.previewAndTransctionsLabels = [[LabelWithSeperatorLine alloc] init];
    
    self.topSeperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 8.f)];
    self.topSeperatorView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = [UIColor UIColorFromRGB:0xcdcdcd];
    
    self.statusContaintView = [[UIView alloc] init];
    self.statusContaintView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    self.statusLabel = [[UILabel alloc] init];
    [self.statusContaintView addSubview:self.clockView];
    [self.statusContaintView addSubview:self.statusLabel];
    
    [self.contentView addSubview:self.topSeperatorView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.previewAndTransctionsLabels];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.arrivalTime];
    [self.contentView addSubview:self.scopeLabel];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.statusContaintView];
    [self.contentView addSubview:self.companyInfoContaintView];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.topSeperatorView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(8.f);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 16.f)
    .topSpaceToView(self.topSeperatorView, 8.f)
    .rightSpaceToView(self.previewAndTransctionsLabels, 16.f);
    
    self.previewAndTransctionsLabels.sd_layout
    .topEqualToView(self.titleLabel)
    .rightSpaceToView(self.contentView, 16.f)
    .widthIs(60.f)
    .heightIs(50.f);
    
    self.priceLabel.sd_layout
    .topSpaceToView(self.titleLabel, 4.f)
    .leftSpaceToView(self.contentView, 16.f)
    .heightIs(24.f);
    
    self.typeLabel.sd_layout
    .leftSpaceToView(self.priceLabel, 4.f)
    .bottomEqualToView(self.priceLabel)
    .heightIs(18.f)
    .widthIs(44.f);

    
    self.seperatorLine.sd_layout
    .topSpaceToView(self.priceLabel, 12.f)
    .leftSpaceToView(self.contentView, 16.f)
    .rightSpaceToView(self.contentView, 16.f)
    .heightIs(1.f);
    
    self.arrivalTime.sd_layout
    .topSpaceToView(self.seperatorLine, 12.f)
    .leftSpaceToView(self.contentView, 16.f)
    .rightSpaceToView(self.contentView, 16.f)
    .heightIs(24.f);
    
    self.scopeLabel.sd_layout
    .topSpaceToView(self.arrivalTime, -4.f)
    .rightSpaceToView(self.contentView, 16.f)
    .leftSpaceToView(self.contentView, 16.f);
    
    self.companyInfoContaintView.sd_layout
    .topSpaceToView(self.scopeLabel, 12.f)
    .rightSpaceToView(self.contentView, 16.f)
    .leftSpaceToView(self.contentView, 16.f)
    .heightIs(24.f);
    
    self.statusContaintView.sd_layout
    .topEqualToView(self.companyInfoContaintView)
    .rightEqualToView(self.contentView)
    .heightIs(24.f);
    
    self.bottomLine.sd_layout
    .bottomEqualToView(self.statusContaintView)
    .heightIs(1.f)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
   [self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:1.f];

}

-(void)setSearchResultDto:(SearchResultDTO *)searchResultDTO
{
    _searchResultDto = searchResultDTO;
    
    self.titleLabel.text = searchResultDTO.goodName;
//    [self.titleLabel sizeToFit];
    [self fomartPriceLabel];
    [self.priceLabel sizeToFit];
    
    //    self.titleLabel.text = searchResultDTO.goodName;
    self.arrivalTime.text = [NSString stringWithFormat:@"到货周期: %@", searchResultDTO.deadlineStr];
    
    if ([self.typeName isEqualToString:@"供货"]) {
        self.scopeLabel.text = [NSString stringWithFormat:@"供货范围: %@", searchResultDTO.region];
        
    }
    else {
        self.scopeLabel.text = [NSString stringWithFormat:@"收货地址: %@", searchResultDTO.address];
        
    }
    //[self.scopeLabel sizeToFit];
    CGSize size = [self.self.scopeLabel.text boundingRectWithFont:self.self.scopeLabel.font andWidth:self.self.scopeLabel.width];
    self.scopeLabel.height = ceil(size.height);
    
    
    if (searchResultDTO.isAnoy) {
        [self.companyImageView setImageWithURL:[NSURL URLWithString:COMB_URL(@"/weui/images/img_01.jpg")] placeholderImage:[UIImage imageNamed:@"company_icon"]];
        self.companyLabel.text = @"匿名";
    }
    else {
        if ([searchResultDTO.userImage hasPrefix:@"http"]) {
            [self.companyImageView setImageWithURL:[NSURL URLWithString:searchResultDTO.userImage] placeholderImage:[UIImage imageNamed:@"company_icon"]];
            
        }
        else {
            [self.companyImageView setImageWithURL:[NSURL URLWithString:COMB_URL(searchResultDTO.userImage)] placeholderImage:[UIImage imageNamed:@"company_icon"]];
        }
        self.companyLabel.text = searchResultDTO.userName;
    }
    
//    if (searchResultDTO.isActive && searchResultDTO.duration > 0) {
//        self.countdownLabel.hidden = YES;
//        self.leftTimeLabel.hidden = NO;
//        [self fomartTimeLeftLabel];
//    }
//    else {
//        self.countdownLabel.hidden = NO;
//        self.leftTimeLabel.hidden = YES;
//        
//    }
    
    self.previewAndTransctionsLabels.strings = @[[NSString stringWithFormat:@"浏览: %ld", searchResultDTO.views],
                                                 [NSString stringWithFormat:@"意向: %ld", searchResultDTO.intentions]];
    
    self.typeLabel.textLabel.text = self.typeName;
//    self.fd_enforceFrameLayout = YES;
    
    //[self layoutAllLabels];
    
    
}

-(void)fomartPriceLabel
{
    NSString* price;
    NSString* quantity;
    self.priceLabel.text = @"";
    price = [NSString stringWithFormat:@"%.0f", self.searchResultDto.price];
    quantity = [NSString stringWithFormat:@"%ld", self.searchResultDto.quantity];

    self.priceLabel.text = @"";
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //    self.detailLabel.text = @"￥1020.00起 10台";
    
    UIFont* largFont = [UIFont boldSystemFontOfSize:20];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], /*[UIColor blackColor],*/ [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       /*smallFont,*/ largFont, middleFont];
    
    NSArray* components = @[@"￥", price, @".00   ", /*@"起  ",*/ quantity, @"台"];
    NSMutableArray* stringWithAttrs = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        [stringWithAttrs addObject:@{@"string" : text,
                                     @"attributes" : @{NSForegroundColorAttributeName:[colors objectAtIndex:index],
                                                       NSFontAttributeName : [fonts objectAtIndex:index]}
                                     }];
        index ++;
    }
    
    self.priceLabel.attributedText = [NSAttributedString composedAttributedString:stringWithAttrs];
    
    [self.priceLabel sizeToFit];
}

@end
