//
//  CustomSegment.m
//  suning6iphone
//
//  Created by  liukun on 13-7-23.
//  Copyright (c) 2013年 liukun. All rights reserved.
//

#import "CustomSegment.h"

#define kSegmentLineImage               @"segment_line_vertical_gray.png"
#define kSegmentBottomLine              @"segment_line_Horizontal_orange.png"

@interface CustomSegment()
{
    BOOL  setupFinished;
}

@property (nonatomic, strong) NSArray *lines;
@property (nonatomic) ButtonStyle buttonStyle;
@property (nonatomic, strong) UIImageView *bottomLine;

@end

/*********************************************************************/

@implementation CustomSegment

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 40)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self commonSetup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonSetup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonSetup];
}

- (void)commonSetup
{
    if (setupFinished)
    {
        return;
    }
    
    self.lineHeight = 15.f;
    
    self.backgroundColor =[UIColor whiteColor];
    
    setupFinished = YES;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    v.backgroundColor = [UIColor UIColorFromRGB:0xdcdcdc];
    [self addSubview:v];
    [self bringSubviewToFront:v];
}

- (void)setItems:(NSArray *)items
{
    if (_items != items)
    {
        _items = items;
        
        [self setButtons];
        
        [self setBottomLine:self.bottomLine];
        
        //[self bringSubviewToFront:];
    }
    
}

- (void)setItems:(NSArray *)items andIcons:(NSArray*)icons andStyle:(ButtonStyle)style
{

    [self setItems:items];
    
    for (NSUInteger i=0; i<self.buttons.count; ++i) {
        UIButton* button = self.buttons[i];
        NSString* icon = [icons objectAtIndex:i];
        if(icons){
            UIImage* image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [button setImage:image forState:UIControlStateNormal];
            CGSize fontSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
            if (style == kButtonStyleV) {
                //top, left, bottom, right
                
                button.imageEdgeInsets = UIEdgeInsetsMake(-fontSize.height, fontSize.width+button.imageView.bounds.size.width/2, 0, 0);
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.bounds.size.width/2, -button.imageView.bounds.size.height, 0);
            }
            else if (style == kButtonStyleB){
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.frame.size.width-4.f, 0, button.imageView.frame.size.width+4.f)];
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];
            }
        }
    }
    
    self.buttonStyle = style;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _prevIndex = _currentIndex;
    if (currentIndex != _currentIndex)
    {
        _currentIndex = currentIndex;
        
        for (int i =0; i<[self.buttons count]; i ++) {
            UIButton *btn =(UIButton *)[self.buttons objectAtIndex:i];
            [btn setTitleColor:[self getBtnColorAtIndex:i] forState:UIControlStateNormal];
            btn.tintColor = [self getBtnColorAtIndex:i];
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            NSInteger count = [_items count];
            CGFloat width = self.bounds.size.width / count;
            CGFloat height = self.bounds.size.height;
            
            CGFloat left =0;
            if (currentIndex > 0) {
                UIImageView *l = [self.lines objectAtIndex:currentIndex-1];
                left = l.right;
            }
            self.bottomLine.frame = CGRectMake(left, height-1.5, width-1, 1.5);
        }];
    }
    
    if ([_delegate respondsToSelector:@selector(segment:didSelectAtIndex:)])
    {
        [_delegate segment:self didSelectAtIndex:_currentIndex];
    }
}

-(UIColor*)selectedTineColor
{
    if (!_selectedTineColor) {
        _selectedTineColor = [UIColor redColor];
    }
    
    return _selectedColor;
}

- (void)setButtons
{
    NSInteger count = [_items count];
    CGFloat width = self.bounds.size.width / count - 1;
    CGFloat height = self.bounds.size.height;
    NSMutableArray *btnArr = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *lineArr = [NSMutableArray arrayWithCapacity:count-1];
    for (int i = 0; i < [_items count]; i++)
    {
        NSString *title = [_items objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width, 0, width, height);
        [btn addTarget:self
                action:@selector(buttonTapped:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[self getBtnColorAtIndex:i] forState:UIControlStateNormal];
        btn.tintColor = [self getBtnColorAtIndex:i];

        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btnArr addObject:btn];
        [self addSubview:btn];
        
        if (i > 0)
        {
            UIImageView *line = [[UIImageView alloc] init];
            line.frame = CGRectMake(btn.x, 0, 0.5, self.frame.size.height);
            line.backgroundColor = [UIColor UIColorFromRGB:0xdcdcdc];
            
            [self addSubview:line];
            [lineArr addObject:line];
        }
    }
    self.buttons = btnArr;
    self.lines = lineArr;
}

- (UIImageView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine =[[UIImageView alloc]init];
                
        _bottomLine.frame = CGRectMake(0, self.bounds.size.height-1.5, self.bounds.size.width / _items.count, 1.5);
        _bottomLine.layer.borderWidth = 1;
        _bottomLine.layer.borderColor = _selectedColor ? _selectedColor.CGColor : [UIColor redColor].CGColor;
        
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}


- (UIColor *)getBtnColorAtIndex:(NSInteger)index
{
    if (self.currentIndex == index)
    {
        return self.selectedTineColor;
    }
    else
    {
        return [UIColor UIColorFromRGB:0x707070];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark -
#pragma mark actions

- (void)buttonTapped:(id)sender
{
    NSInteger index = [(UIButton *)sender tag];
    
    self.currentIndex = index;
}

@end
