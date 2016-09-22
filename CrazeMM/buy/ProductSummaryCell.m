//
//  ProductSummaryCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductSummaryCell.h"
#import "SupplyProductDTO.h"
#import "NSAttributedString+Utils.h"

#define kProductSummaryCellHeight 132.f
#define kHAlignPading 16.f
#define kVAlignPading 16.f
@interface ProductSummaryCell()

//@property (strong, nonatomic)  UIImageView *phoneImageView;
//@property (strong, nonatomic)  M80AttributedLabel *titleLabel;
//@property (strong, nonatomic)  UILabel *detailLabel;
//@property (strong, nonatomic)  ArrowView *arrawView;
//@property (strong, nonatomic)  UIView *bottomLine;
//@property (strong, nonatomic)  UILabel *statusLabel;
//@property (strong, nonatomic)  M80AttributedLabel *timeLeftLabel;
@property (strong, nonatomic)  UIImageView* triangleImageView;
@property (strong, nonatomic) UIView* phoneImageBackgroundView;

@end

@implementation ProductSummaryCell

-(UIImageView*)phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] init];
        _phoneImageView.frame = CGRectMake(0, 0, 100, 100);
        [self.phoneImageBackgroundView addSubview:_phoneImageView];
        _phoneImageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    
    return _phoneImageView;
}

-(UIView*)phoneImageBackgroundView
{
    if (!_phoneImageBackgroundView) {
        _phoneImageBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _phoneImageBackgroundView.layer.borderWidth = 1;
        _phoneImageBackgroundView.layer.borderColor = [UIColor lightGrayColor188].CGColor;

        [self.contentView addSubview:_phoneImageBackgroundView];
    }
    
    return _phoneImageBackgroundView;
}

-(UIImageView*)triangleImageView {
    if (!_triangleImageView) {
        _triangleImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"triangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _triangleImageView.frame = CGRectMake(0, 0, 4, 4);
        [self.contentView addSubview:_triangleImageView];
        _triangleImageView.hidden = YES;
    }
    
    return _triangleImageView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        //_titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:_titleLabel];
//        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.layer.masksToBounds = YES;


    }
    
    return _titleLabel;
}

-(ArrowView*)arrowView
{
    if (!_arrowView) {
        _arrowView = [[ArrowView alloc] init];
        _arrowView.textLabel.text = @"求购";
        _arrowView.frame = CGRectMake(0, 0, 38, 16);
        [self.contentView addSubview:_arrowView];
    }
    
    return _arrowView;
}

-(UILabel*)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.numberOfLines = 1;
//        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.layer.masksToBounds = YES;

        [self.contentView addSubview:_priceLabel];
    }
    
    return _priceLabel;
}

-(UILabel*)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_statusLabel];
        _statusLabel.backgroundColor = [UIColor greenTextColor];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.text = @"正常";
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        // no need, hide it
        _statusLabel.hidden = YES;
    }
    
    return _statusLabel;
}

-(UIView*)timeBackgroundView
{
    if (!_timeBackgroundView) {
        _timeBackgroundView = [[UIView alloc] init];
        _timeBackgroundView.backgroundColor = [UIColor lightGrayColor188];
        [self.contentView addSubview:_timeBackgroundView];
    }
    return _timeBackgroundView;
}

-(UILabel*)timeLeftLabel
{
    if (!_timeLeftLabel) {
        _timeLeftLabel = [[UILabel alloc] init];
        _timeLeftLabel.numberOfLines  = 1;
        _timeLeftLabel.font = [UIFont systemFontOfSize:14.f];
        [self.timeBackgroundView addSubview:_timeLeftLabel];
    }
    
    return _timeLeftLabel;
}

-(UIImageView*)clockIcon
{
    if (!_clockIcon) {
        _clockIcon = [[UIImageView alloc] initWithImage:[@"Clock-1" image]];
        _clockIcon.frame = CGRectMake(0, 0, 16, 16);
        [self.timeBackgroundView addSubview:_clockIcon];
    }
    
    return _clockIcon;
}

-(UIView*)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-16.f*2, 1)];
        [self.contentView addSubview:_bottomLine];

    }
    return _bottomLine;
}

-(void)setCellType:(NSString *)cellType
{
    _cellType = cellType;
    self.arrowView.textLabel.text = _cellType;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.layer.drawsAsynchronously = YES;
        [self commInit];
        [self layoutAllSubviews];

    }
    
    return self;
}


-(void)commInit
{
    if (!self.productDto) {
        self.titleLabel.text = @"";
        self.timeLeftLabel.text = @"";
        self.priceLabel.text = @"";
        [self.phoneImageView setImage:[@"product_placehoder.png" image]];
    }
    else {
        NSString* goodImge = self.productDto.goodImage;
        if (![goodImge hasPrefix:@"http"]) {
            goodImge = COMB_URL(goodImge);
        }
        [self.phoneImageView setImageWithURL:[NSURL URLWithString:goodImge] placeholderImage:[@"product_placehoder.png" image]];
        self.titleLabel.text = self.productDto.goodName;

    }

    [self fomartPriceLabel];
    [self fomartTimeLabel];
    self.statusLabel.text = self.productDto.stateLabel;
    if([self.statusLabel.text isEqualToString:@"已过期"]){
        self.statusLabel.backgroundColor = [UIColor redColor];
        self.triangleImageView.tintColor = [UIColor redColor];
    }
    else {
        self.statusLabel.backgroundColor = [UIColor UIColorFromRGB:0x097939];
        self.triangleImageView.tintColor = [UIColor UIColorFromRGB:0x097939];
    }
}

-(void)layoutAllSubviews
{
    //[self commInit];
    
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.phoneImageBackgroundView.x = self.phoneImageBackgroundView.y = kHAlignPading;
    
    self.titleLabel.width = maxWidth - kHAlignPading - 8.f - self.phoneImageBackgroundView.right;
    [self.titleLabel sizeToFit];
    self.titleLabel.x = self.phoneImageBackgroundView.right + 8.f;
    self.titleLabel.y = self.phoneImageBackgroundView.y;
    
    //self.priceLabel.width = 128.f;
    [self.priceLabel sizeToFit];
    self.priceLabel.x = self.titleLabel.x;
    self.priceLabel.y = self.titleLabel.bottom + 10.f;
    
    self.arrowView.bottom = self.priceLabel.bottom - 4.f;
    self.arrowView.x = self.priceLabel.right + 4.f;
    
    self.timeBackgroundView.x = self.titleLabel.x;
    self.timeBackgroundView.width = maxWidth - kHAlignPading - 8.f - self.phoneImageBackgroundView.right;
    self.timeBackgroundView.bottom = self.phoneImageBackgroundView.bottom;
    self.timeBackgroundView.height = 22.f;
    
//    self.clockIcon.centerY = self.timeBackgroundView.centerY;
    [self.timeLeftLabel sizeToFit];
//    self.timeLeftLabel.centerY = self.timeBackgroundView.centerY;
    CGFloat totalWidth;
    CGFloat startX;
    if (self.productDto && !self.productDto.isActive) {
        self.clockIcon.hidden = YES;
        totalWidth = self.timeLeftLabel.width;
        startX = ceil(self.timeBackgroundView.width/2 - totalWidth/2);
        self.timeLeftLabel.x = startX;
        self.timeLeftLabel.centerY = self.timeBackgroundView.height/2;
    }
    else{
        self.clockIcon.hidden = NO;
        totalWidth = self.clockIcon.width + 4.f + self.timeLeftLabel.width;
        startX = ceil(self.timeBackgroundView.width/2 - totalWidth/2);
        self.clockIcon.x = startX;
        self.timeLeftLabel.x = self.clockIcon.right + 4.f;
        self.clockIcon.centerY = self.timeLeftLabel.centerY = self.timeBackgroundView.height/2;
    }
    
    
    [self.statusLabel sizeToFit];
    self.statusLabel.width += 4.f;
    self.statusLabel.x = self.phoneImageBackgroundView.x - 4.f;
    self.statusLabel.y = self.phoneImageBackgroundView.y + 6.f;
    
    self.triangleImageView.x = self.statusLabel.x;
    self.triangleImageView.y = self.statusLabel.bottom;
}

-(void)fomartPriceLabel
{
    NSString* price;
    NSString* quantity;
    self.priceLabel.text = @"";
    if (self.productDto) {
        price = [NSString stringWithFormat:@"%.02f", self.productDto.price];
        quantity = [NSString stringWithFormat:@"%ld", self.productDto.quantity];
    }
    else {
        price = @"";
        quantity = @"";
    }
    NSArray* priceComp = [NSString  formatePrice:self.productDto.price];
    NSString* string = [priceComp[0] stringByReplacingOccurrencesOfString:@"," withString:@""];
    self.priceLabel.text = @"";
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    
    UIFont* largFont = [UIFont boldSystemFontOfSize:20];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], /*[UIColor blackColor],*/ [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       /*smallFont,*/ largFont, middleFont];
    
    NSArray* components = @[@"￥", string, [NSString stringWithFormat:@"%@   ", priceComp[1]], /*@"起  ",*/ quantity, @"台"];
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

-(void)fomartTimeLabel
{
    if (self.productDto && (!self.productDto.isActive || self.productDto.millisecond<0)) {
        self.timeLeftLabel.attributedText = nil;
        self.timeLeftLabel.text = [NSString stringWithFormat:@"%@发布", self.productDto.createTime];
        [self.timeLeftLabel sizeToFit];
        self.clockIcon.frame = CGRectZero;
        return;
    }
    
    self.clockIcon.frame = CGRectMake(0, 0, 16, 16);
    NSArray *colors = @[[UIColor redColor], [UIColor blackColor]];
    NSString* timeLeftString = @"";//@"10 天 18 小时 20 分钟";
    
    if (self.productDto){
        timeLeftString = [NSString leftTimeString:self.productDto.millisecond];
    }

    NSArray *components = [timeLeftString componentsSeparatedByString:@" "];
    NSMutableArray* stringWithAttrs = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSString* newString;
        if (index != components.count-1) {
            newString = [NSString stringWithFormat:@"%@ ", text];
        }
        else{
            newString = text;
        }
        [stringWithAttrs addObject:@{@"string" : newString,
                                     @"attributes" : @{NSForegroundColorAttributeName:[colors objectAtIndex:index%2]}
                                     }];
        index ++;

    }
    
    self.timeLeftLabel.attributedText = [NSAttributedString composedAttributedString:stringWithAttrs];
    [self.timeLeftLabel sizeToFit];
}


-(void)setProductDto:(BaseProductDTO *)productDto
{
//    if (![productDto isKindOfClass:NSClassFromString(@"SupplyProductDTO")]) {
//        return;
//    }
    _productDto = productDto;
    [self commInit];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutAllSubviews];
}

+(CGFloat)cellHeight
{
    return kProductSummaryCellHeight;
}

@end
