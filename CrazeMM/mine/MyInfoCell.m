//
//  MyInfoCell.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MyInfoCell.h"

@interface MyInfoCell()

@property (nonatomic, strong) UIView* bottomLine;

@end

@implementation MyInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
//        self.imageView.image = [UIImage imageNamed:@"account"];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_left"]];
        self.textLabel.font = [UIFont systemFontOfSize:15.f];
        self.textLabel.textColor = [UIColor grayColorL2];
    }
    
    return  self;
}

-(UIView*)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView lineViewWithColor:[UIColor lightGrayColor188] andWidth:1.f];
        
        [self.contentView addSubview:_bottomLine];
    }
    
    return _bottomLine;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 12.f;
    self.imageView.y += 6.f;
//    self.imageView.centerY = self.contentView.height/2;
    self.imageView.width = 18.f;
    self.imageView.height = 18.f;
    
//    self.accessoryView.y += 6.f;
    self.accessoryView.width = 18.f;
    self.accessoryView.height = 18.f;
    self.accessoryView.x = [UIScreen mainScreen].bounds.size.width - self.accessoryView.width - 8.f;

    
    self.textLabel.x = 36.f;
    self.textLabel.centerY = self.contentView.height/2;
    
    self.bottomLine.y = self.height;
    self.bottomLine.x = self.textLabel.x;
    self.bottomLine.width = self.width - self.bottomLine.x;

}

@end
