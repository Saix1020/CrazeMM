//
//  SupplyBottomOffView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyBottomOffView.h"

@implementation SupplyBottomOffView

-(void)awakeFromNib
{
}

//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:nibBundleOrNil];
//    return self;
//}

-(instancetype)init
{
    self = (SupplyBottomOffView*)[UINib viewFromNibByClass:[self superclass]];
    
    if (self) {
        
    }
    return self;
}
-(void)myInit
{
    [self.confirmButton setTitle:@"下架" forState:UIControlStateNormal];
    [self.totalPriceLabel setText:@""];

}


@end
