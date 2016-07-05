//
//  ProductListCell.m
//  CrazeMM
//
//  Created by saix on 16/5/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ProductListCell.h"

@interface ProductListCell()

@property (nonatomic, strong) UIImageView* clockView;
@property (nonatomic, strong) UIImageView* triangleView;

@end


//@property (strong, nonatomic)  UIImageView *phoneImageView;
//@property (strong, nonatomic)  UILabel *titleLabel;
//@property (copy, nonatomic)  NSString* arrawString;
//@property (strong, nonatomic)  UIView *bottomLine;
//@property (strong, nonatomic)  UILabel *statusLabel;
//@property (strong, nonatomic)  M80AttributedLabel *timeLeftLabel;
//@property (strong, nonatomic)  M80AttributedLabel *detailLabel;


@implementation ProductListCell


-(UIImageView*)phoneImageView
{
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.contentView addSubview:_phoneImageView];
    }
    return _phoneImageView;
}

-(UIImageView*)triangleView
{
    if (!_triangleView) {
        _triangleView = [[UIImageView alloc] initWithImage:[@"triangle" image]];
        [self.contentView addSubview:_triangleView];

    }
    return _triangleView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLeftLabel];
    }
    
    return _titleLabel;
}

-(UIView*)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        [self.contentView addSubview:_bottomLine];
    }
    
    return _bottomLine;
}

-(UILabel*)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_statusLabel];

    }
    
    return _statusLabel;
}

-(M80AttributedLabel*)timeLeftLabel
{
    if (!_timeLeftLabel) {
        _timeLeftLabel = [[M80AttributedLabel alloc] init];
        [self.contentView addSubview:_statusLabel];
        
    }
    
    return _timeLeftLabel;
}

-(M80AttributedLabel*)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[M80AttributedLabel alloc] init];
        [self.contentView addSubview:_detailLabel];
        
    }
    
    return _detailLabel;
}

-(UIImageView*)clockView
{
    if (!_clockView) {
        _clockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        _clockView.image = [UIImage imageNamed:@"Clock-1"];
        
    }
    return _clockView;
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

#define kImageViewStartX 24.f
#define kImageViewStartY 8.f

#define kStatusLabelStartX (kImageViewStartX-6.f)
#define kStatusLabelStartY (kImageViewStartY+16.f)

-(void)layoutAllSubviews
{
//    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.phoneImageView.frame = CGRectMake(kImageViewStartX, kImageViewStartY, 100.f, 100.f);
    self.statusLabel.frame = CGRectMake(kStatusLabelStartX, kStatusLabelStartY, 30.f, 16.f);
    self.triangleView.frame = CGRectMake(kStatusLabelStartX, CGRectGetMaxY(self.statusLabel.frame), 6.f, 6.f);
    [self.contentView bringSubviewToFront:self.statusLabel];
    [self.contentView bringSubviewToFront:self.triangleView];

    
//    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.phoneImageView.frame), kImageViewStartY, screenWidth-8.f-CGRectGetMaxX(self.phoneImageView.frame), 36.f);
//    
//    self.detailLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.bottom+4.f, self.titleLabel.width, 32.f);
//    self.titleLabel.frame = CGRectMake(self.titleLabel.x, self.detailLabel.bottom+4.f, self.titleLabel.width, 22);
//    
//    self.bottomLine.frame = CGRectMake(16.f, self.contentView.height-1, screenWidth-16.f, 1);
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self commInit];
        
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];
        
    }
    return self;
}

-(void)commInit
{
    self.detailLabel.text = @"￥1020.00起 10台";
    [self fomartDetailLabel];
    
    self.timeLeftLabel.text = [NSDateComponents timeLabelString:361345]; // 4 days 4 hours 22 mins
    [self fomartTimeLeftLabel];
    
    self.phoneImageView.image = [UIImage imageNamed:@"product_placehoder.jpg"];
    self.statusLabel.text = @"正常";
}


-(void)setProductDescDTO:(ProductDescriptionDTO *)productDescDTO
{
    [self initWithDTO:productDescDTO];
}


-(void)initWithDTO:(ProductDescriptionDTO*)productDescDTO
{
    _productDescDTO = productDescDTO;
    
    self.titleLabel.text = productDescDTO.title;
    self.detailLabel.text = productDescDTO.detail;
    
    NSInteger leftSeconds = productDescDTO.remainingTime - productDescDTO.elapseTime;
    if (leftSeconds < 0) {
        leftSeconds = 0;
    }
    self.timeLeftLabel.text = [NSDateComponents timeLabelString:leftSeconds];
    
    [self fomartDetailLabel];
    [self fomartTimeLeftLabel];
    
    //    self.phoneImageView.image = [UIImage imageNamed:@"prod_placeholder.jpg"];
    [self.phoneImageView setImageWithURL:[NSURL URLWithString:productDescDTO.imageURL] placeholderImage:[UIImage imageNamed:@"product_placehoder.jpg"]];
    self.statusLabel.text = productDescDTO.status;
    if([self.statusLabel.text isEqualToString:@"已过期"]){
        self.statusLabel.backgroundColor = [UIColor redColor];
        self.triangleView.tintColor = [UIColor redColor];
    }
    else {
        self.statusLabel.backgroundColor = [UIColor greenColor];
        self.triangleView.tintColor = [UIColor greenColor];
    }
    @weakify(self);
    
//    [[RACObserve(productDescDTO, elapseTime)
//      takeUntil:self.rac_prepareForReuseSignal]
//     subscribeNext:^(id x){
//         @strongify(self);
//         [self fomartTimeLeftLabel];
//     }];
}

//-(void)setTimeSignal:(RACSignal *)timeSignal
//{
//    _timeSignal = timeSignal;
//    if (_timeSignal) {
//        @weakify(self);
//
//        [_timeSignal subscribeNext:^(id x){
//            @strongify(self);
//            if (self.productDescDTO) {
//                NSDate* now = [NSDate date];
//                NSTimeInterval interval = [now timeIntervalSinceDate:self.productDescDTO.createTime];
//                self.productDescDTO.elapseTime = (int)interval*60;
//                //self.timeLeftLabel.text = [NSDateComponents timeLabelString:self.productDescDTO.remainingTime];
//                [self fomartTimeLeftLabel];
//
//            }
//
//            //NSLog(@"%@", x);
//        }];
//    }
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setArrawString:(NSString *)arrawString
{
    self.arrowView.textLabel.text = arrawString;
}

-(NSString*)arrawString
{
    return self.arrowView.textLabel.text;
}

+(CGFloat)cellHeight
{
    return 140.f;
}

-(void)fomartTimeLeftLabel
{
    NSString* timeLeftString;
    if (self.productDescDTO) {
        NSInteger leftSeconds = self.productDescDTO.remainingTime - self.productDescDTO.elapseTime;
        if (leftSeconds < 0) {
            leftSeconds = 0;
        }
        
        timeLeftString = [NSDateComponents timeLabelString:leftSeconds];
    }
    else {
        timeLeftString = @"03 天 00 小时 20 分钟";
    }
    self.timeLeftLabel.text = @"";
    self.timeLeftLabel.textAlignment = kCTTextAlignmentCenter;
    [self.timeLeftLabel appendView:self.clockView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    [self.timeLeftLabel appendText:@" "];
    
    NSArray *colors = @[[UIColor redColor], [UIColor blackColor]];
    NSArray *components = [timeLeftString componentsSeparatedByString:@" "];
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[UIFont systemFontOfSize:14.f]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index%2]];
        [self.timeLeftLabel appendAttributedText:attributedText];
        [self.timeLeftLabel appendText:@" "];
        index ++;
    }
    
    //self.timeLeftLabel.offsetY = -8.f;
    
}

-(void)fomartDetailLabel
{
    self.detailLabel.text = @"";
    
    //    self.detailLabel.text = @"￥1020.00起 10台";
    
    UIFont* largFont = [UIFont boldSystemFontOfSize:20];
    UIFont* middleFont = [UIFont systemFontOfSize:14];
    UIFont* smallFont = [UIFont systemFontOfSize:12];
    
    
    NSArray *colors = @[[UIColor redColor], [UIColor redColor], [UIColor redColor], [UIColor blackColor], [UIColor greenTextColor], [UIColor greenTextColor]];
    NSArray *fonts = @[smallFont, largFont, smallFont,
                       smallFont, largFont, middleFont];
    
    NSArray* components;
    if (_productDescDTO) {
        components = @[@"￥", self.productDescDTO.miniumPriceString1, self.productDescDTO.miniumPriceString2, @"起  ", self.productDescDTO.minimumNumberString, @"台"];
    }
    else {
        components = @[@"￥", @"2000", @".00", @"起  ", @"10", @"台"];
        
    }
    NSInteger index = 0;
    for (NSString *text in components)
    {
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedText m80_setFont:[fonts objectAtIndex:index]];
        [attributedText m80_setTextColor:[colors objectAtIndex:index]];
        [self.detailLabel appendAttributedText:attributedText];
        index ++;
    }
    [self.detailLabel appendText:@" "];
    [self.detailLabel appendView:self.arrowView margin:UIEdgeInsetsZero alignment:M80ImageAlignmentCenter];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // why we need reset backgroud color here?
    self.statusLabel.backgroundColor = [UIColor greenTextColor];
    
    
    //self.bottomLine.frame = CGRectMake(8.f, self.bottom, self.width-2*8.f, 1);
}

@end
