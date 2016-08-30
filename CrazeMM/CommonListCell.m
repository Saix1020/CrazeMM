//
//  CommonListCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//



#import "CommonListCell.h"

@interface CommonListCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderLabelLeadingContraint;

@end

@implementation CommonListCell

//-(instancetype)initWithNibName:(NSString*)nibNameOrNil
//{
//    self = (CommonListCell*)[UINib viewFromNib:@"CommonListCell"];
//    
//    return self;
//}
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [self initWithNibName:@"CommonListCell"];
//    self.reuseIdentifier = reuseIdentifier;
//    
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.checkBox.onCheckColor = [UIColor whiteColor];
    self.checkBox.onTintColor = [UIColor redColor];
    self.checkBox.onFillColor = [UIColor redColor];
    self.checkBox.boxType = BEMBoxTypeCircle;
    self.checkBox.on = NO  ;
    self.checkBox.animationDuration = 0.f;
    self.checkBox.delegate = self;
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    
    self.seperatorLine.backgroundColor  = [UIColor light_Gray_Color];
    
    self.leftButton.tintColor = [UIColor UIColorFromRGB:0x444444];
    self.rightButton.tintColor = [UIColor UIColorFromRGB:0x444444];

    [self.leftButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    self.bottomView.backgroundColor = [UIColor UIColorFromRGB:0xf7f7f7];
    
    self.statusLabel.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];//
    self.statusLabel.layer.cornerRadius = 4.f;
    self.statusLabel.clipsToBounds = YES;
    self.statusLabel.textColor = [UIColor UIColorFromRGB:0x3972a2];
    self.statusLabel2.backgroundColor = [UIColor UIColorFromRGB:0xbddcfa];//
    self.statusLabel2.layer.cornerRadius = 4.f;
    self.statusLabel2.clipsToBounds = YES;
    self.statusLabel2.textColor = [UIColor UIColorFromRGB:0x3972a2];
    
    [self.topButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //Top button 默认隐藏
    self.topButton.hidden =YES;
    
    // image default hidden
    self.image.hidden = YES;
    
    // bottom label default hidden
    self.bottomLabel.textAlignment = NSTextAlignmentRight;
    self.bottomLabel.hidden = YES;

    @weakify(self);
    [RACObserve(self.checkBox, hidden) subscribeNext:^(id x){
        @strongify(self);

        if (self.checkBox.hidden) {
            self.orderLabelLeadingContraint.constant = 0;
        }
        else {
            self.orderLabelLeadingContraint.constant = 24.f;
        }
        
        [self updateConstraintsIfNeeded];
    }];
    
    
    
}

-(void)setDto:(BaseListDTO *)dto
{
    @weakify(self);
    
    if (_dto == dto) {
        
    }
    else {
        _dto = dto;
        [RACObserve(dto, selected) subscribeNext:^(id x){
            @strongify(self);
            self.checkBox.on = dto.selected;
        }];
        NSString* className = NSStringFromClass(dto.class);
        NSString* selectorName = [NSString stringWithFormat:@"set%@%@:", [[className substringToIndex:1] uppercaseString], [className substringFromIndex:1]];
        SEL selector = NSSelectorFromString(selectorName);
        if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:dto];
#pragma clang diagnostic pop
        }
    }
    
//    [self renderAllSubviews];
}

//-(void)renderAllSubviews
//{
//    
//}

-(void)formatOrderLabel:(NSInteger)orderId
{
    self.orderLabel.text = [NSString stringWithFormat:@"编号: %ld", orderId];
}

-(void)formatStatusLabel:(NSString*)status
{
    if (status.length>0) {
        self.statusLabel.text = [NSString stringWithFormat:@" %@ ", status];
    }
}

-(void)formatTimeLabel:(NSString*)timeString
{
    self.timeLabel.text = timeString;
}

-(void)formatGoodNameLabel:(NSString*)goodName
{
    self.titleLabel.text = goodName;
}



-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    self.dto.selected = checkBox.on;
    if ([self.delegate respondsToSelector:@selector(didSelectedListCell:)]) {
        [self.delegate didSelectedListCell:self];
    }
}

-(void)buttonClicked:(UIButton*)button
{
    if (button == self.leftButton) {
        if ([self.delegate respondsToSelector:@selector(leftButtonClicked:)]) {
            [self.delegate leftButtonClicked:self];
        }
    }
    else if (button == self.rightButton) {
        if ([self.delegate respondsToSelector:@selector(rightButtonClicked:)]) {
            [self.delegate rightButtonClicked:self];
        }
        
    }
    else if (button == self.topButton) {
        if ([self.delegate respondsToSelector:@selector(topButtonClicked:)]) {
            [self.delegate topButtonClicked:self];
        }
        
    }

}

+(CGFloat)cellHeight
{
    return 160.f;
}

-(void)dealloc
{
    NSLog(@"dealloc %@", self.class);
}

@end
