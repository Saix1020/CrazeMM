//
//  SearchListCell.m
//  CrazeMM
//
//  Created by saix on 16/4/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchListCell.h"
#import "NSAttributedString+Utils.h"

#define kMaxTitleLength 36

@interface SearchListCell()
@property(nonatomic, strong) UIImageView* clockView;
@property(nonatomic, strong) UILabel* tagLabel;
@property(nonatomic, strong) UIView* topSeperatorView;
@property(nonatomic, strong) UIView* buttonLine;
@property(nonatomic, strong) UIView* topLine;

@end

@implementation SearchListCell

//-(instancetype)initWithSearchResultDTO:(SearchResultDTO*)dto
//{
//    self = [self ini]
//}

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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andType:(NSString*)type
{
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeName = type;
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

-(void)setSearchResultDTO:(SearchResultDTO *)searchResultDTO
{
    _searchResultDTO = searchResultDTO;
    
    [self fomartTitleLabel];
    [self fomartPriceLabel];

//    self.titleLabel.text = searchResultDTO.goodName;
    self.arrivalTime.text = [NSString stringWithFormat:@"到货周期: %@", searchResultDTO.deadlineStr];
    self.scopeLabel.text = [NSString stringWithFormat:@"供货范围: %@", searchResultDTO.region];
    [self.scopeLabel sizeToFit];
    
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
    
    if (searchResultDTO.isActive && searchResultDTO.duration > 0) {
        self.countdownLabel.hidden = YES;
        self.leftTimeLabel.hidden = NO;
        [self fomartTimeLeftLabel];
    }
    else {
        self.countdownLabel.hidden = NO;
        self.leftTimeLabel.hidden = YES;

    }
    
    self.previewAndTransctionsLabels.strings = @[[NSString stringWithFormat:@"浏览: %ld", searchResultDTO.views],
                                                 [NSString stringWithFormat:@"意向: %ld", searchResultDTO.intentions]];
    
    [self layoutAllLabels];


}

-(void)initAllSubviews
{
    //self.titleLabel = [[M80AttributedLabel alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 4;
    self.titleLabel.font = [UIFont systemFontOfSize:20.f];

    self.priceLabel = [[UILabel alloc] init];

    self.seperatorLine = [[UIView alloc] init];
    self.seperatorLine.layer.borderWidth = .25f;
    self.seperatorLine.layer.borderColor = RGBCOLOR(240, 240, 240).CGColor;
    
    
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
    
    self.leftTimeLabel = [[M80AttributedLabel alloc] init];
    self.leftTimeLabel.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    [self fomartTimeLeftLabel];
    self.leftTimeLabel.hidden = YES;
    
    self.countdownLabel = [[M80AttributedLabel alloc] init];
    self.countdownLabel.backgroundColor = [UIColor lightGrayColor188];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:@"已成交"];
    [attributedText m80_setFont:[UIFont systemFontOfSize:12.f]];
    [self.countdownLabel appendAttributedText:attributedText];
    [self.countdownLabel sizeToFit];
    self.countdownLabel.textAlignment = kCTTextAlignmentCenter;
    self.countdownLabel.hidden = YES;
    
    self.typeLabel = [[ArrowView alloc] init];
    self.typeLabel.textLabel.textColor = [UIColor greenTextColor];
    self.typeLabel.textLabel.text = self.typeName;
    
    self.previewAndTransctionsLabels = [[LabelWithSeperatorLine alloc] init];
    self.topSeperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 8.f)];
    self.topSeperatorView.backgroundColor = [UIColor UIColorFromRGB:0xf1f1f1];
    
    
    self.buttonLine = [[UIView alloc] initWithFrame:CGRectMake(0, [SearchListCell cellHeight]-1.f, [UIScreen mainScreen].bounds.size.width, 1.f)];
    self.buttonLine.backgroundColor = [UIColor UIColorFromRGB:0xcdcdcd];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.seperatorLine];
    [self.contentView addSubview:self.arrivalTime];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.companyImageView];
    [self.contentView addSubview:self.scopeLabel];
    [self.contentView addSubview:self.leftTimeLabel];
    [self.contentView addSubview:self.countdownLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.previewAndTransctionsLabels];
    [self.contentView addSubview:self.topSeperatorView];
    [self.contentView addSubview:self.buttonLine];
//    [self.contentView addSubview:self.topLine];

    
    [self layoutAllLabels];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

-(void)fomartTitleLabel
{
    self.titleLabel.text = @"";
    NSString* title;
    if (_searchResultDTO) {
        title = _searchResultDTO.goodName;
    }
    else {
        title = @"飞利浦 -V387 黑色 1GB 联通 3G WCDMA";
    }
    
    self.titleLabel.text = title;
//    UIFont* font = [UIFont systemFontOfSize:20.f];
//    
//    if (title.length > kMaxTitleLength) {
//        title = [NSString stringWithFormat:@"%@...", [title substringToIndex:kMaxTitleLength]];
//    }
//    
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:title];
//    [attributedText m80_setFont:font];
//    [self.titleLabel appendAttributedText:attributedText];
//    [self.titleLabel appendText:@" "];
//    [self.titleLabel appendView:self.tagLabel margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.titleLabel sizeToFit];
//    self.titleLabel.numberOfLines = 2;
    //[attributedText

}


-(void)fomartTimeLeftLabel
{
    NSString* timeLeftString;
    self.leftTimeLabel.text = @"";
    self.leftTimeLabel.textAlignment = kCTTextAlignmentCenter;
    [self.leftTimeLabel appendView:self.clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.leftTimeLabel appendText:@" "];
    if (_searchResultDTO) {
        timeLeftString = [NSString leftTimeString:_searchResultDTO.millisecond];
    }
    else {
        timeLeftString = @"10 天 18 小时 20 分钟";
    }
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
    NSString* price;
    NSString* quantity;
    self.priceLabel.text = @"";
    if (_searchResultDTO) {
        price = [NSString stringWithFormat:@"%.0f", _searchResultDTO.price];
        quantity = [NSString stringWithFormat:@"%ld", _searchResultDTO.quantity];
    }
    else {
        price = @"1020";
        quantity = @"100";
    }
//    NSString* detailString = self.priceLabel.text;
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
//        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
//        [attributedText m80_setFont:[fonts objectAtIndex:index]];
//        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
//        [self.priceLabel appendAttributedText:attributedText];
        [stringWithAttrs addObject:@{@"string" : text,
                                     @"attributes" : @{NSForegroundColorAttributeName:[colors objectAtIndex:index],
                                                       NSFontAttributeName : [fonts objectAtIndex:index]}
                                     }];
        index ++;
    }
    
    self.priceLabel.attributedText = [NSAttributedString composedAttributedString:stringWithAttrs];
    
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
                                       bounds.size.width-70-16.f*2, self.titleLabel.height+6.f);
    y += self.titleLabel.frame.size.height + 4.f;
    
    
    self.priceLabel.frame = CGRectMake(16.f, y,
                                       self.priceLabel.frame.size.width, self.priceLabel.height);
    self.typeLabel.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame)+4.f, self.priceLabel.center.y - self.typeLabel.frame.size.height/2,
                                      43.f, 18.f);
    self.typeLabel.y = self.titleLabel.bottom+6.f;
    //self.typeLabel.height = self.priceLabel.height;
    
    y += self.priceLabel.frame.size.height+12.f;
    
    self.seperatorLine.frame = CGRectMake(16.f, y, bounds.size.width-2*16.f, 1);
    
    y += self.seperatorLine.frame.size.height+12.f;
    self.arrivalTime.frame = CGRectMake(16.f, y,
                                        bounds.size.width-2*16.f, 24.f);
    
    y += self.arrivalTime.frame.size.height-4.f;
    self.scopeLabel.frame = CGRectMake(16.f, y,
                                       bounds.size.width-2*16.f, self.scopeLabel.height);
    
    y += self.scopeLabel.frame.size.height + 12.f;
    

    
    self.companyImageView.frame = CGRectMake(12.f, y+2.f, 20.f, 20.f);
    self.companyLabel.frame = CGRectMake(self.companyImageView.right+4.f, y,
                                         bounds.size.width-2*16.f-150.f, 24.f);
    
    y += self.companyLabel.height + 4.f;
    
        self.leftTimeLabel.frame = CGRectMake(bounds.size.width-150.f, y-self.leftTimeLabel.height,
                                             150.f, self.leftTimeLabel.height);
    
        self.countdownLabel.frame = CGRectMake(bounds.size.width-60.f, y-self.countdownLabel.height,
                                             60.f, self.countdownLabel.height);
    
    self.buttonLine.y = y-1.0f;
    
    self.height = y;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

+(CGFloat)cellHeight
{
    return 204.f;
}


@end
