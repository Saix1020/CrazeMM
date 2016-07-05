//
//  AddrRegionCell.m
//  CrazeMM
//
//  Created by saix on 16/5/17.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrRegionCell.h"
#import "SuggestViewController.h"
#import "ZZPopoverWindow.h"

@interface AddrRegionCell ()
@property (nonatomic, strong) SuggestViewController* suggestVC;
@property (nonatomic, strong) ZZPopoverWindow* popover;
@end

@implementation AddrRegionCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.regionLabel.adjustsFontSizeToFitWidth = YES;
    // Initialization code
    
//    CGSize fontSize = [self.chooseButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.chooseButton.titleLabel.font}];
//    [self.chooseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.chooseButton.imageView.frame.size.width-2.f, 0, self.chooseButton.imageView.frame.size.width+2.f)];
//    [self.chooseButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)hideChooseButton
{
    self.chooseButton.width = 0;
}

-(void)setValue:(NSString *)value
{
    self.regionLabel.text = value;
}

-(NSString*)value
{
    return self.regionLabel.text;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(NSString*)title
{
    return self.titleLabel.text;
}


-(void)popSelection:(NSArray*)options andDelegate:(id<SuggestVCDelegate>)delegate
{
    if (options.count != 0) {
        self.suggestVC = [[SuggestViewController alloc] init];
        self.suggestVC.suggestedStrings = options;
        self.suggestVC.delegate = delegate;
        self.suggestVC.view.frame = CGRectMake(0, 0, 280, self.suggestVC.height);
        self.popover                    = [[ZZPopoverWindow alloc] init];
        self.popover.popoverPosition = ZZPopoverPositionDown;
        self.popover.contentView        = self.suggestVC.view;
        self.popover.animationSpring = NO;
        self.popover.showArrow = NO;
        self.popover.didShowHandler = ^() {
            //self.popover.layer.cornerRadius = 0;
        };
        self.popover.didDismissHandler = ^() {
            //NSLog(@"Did dismiss");
        };
        
        [self.popover showAtView:self.regionLabel position:ZZPopoverPositionDown];
    }
}
-(void)dismissSelection
{
    [self.popover dismiss];
}


@end
