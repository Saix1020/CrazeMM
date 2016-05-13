//
//  HotCityTableViewCell.m
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "HotCityTableViewCell.h"

@implementation HotCityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)buttonClick:(id)sender {
    NSInteger index;
    if (((UIButton*)sender).tag - 2000 <0  || ((UIButton*)sender).tag>2000+self.cityWithProvinces.count) {
        index = 0;
    }
    else {
        index = ((UIButton*)sender).tag - 2000;
    }
    [self.delegate didSelectHotCity:self.cityWithProvinces[index]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSArray*)cityWithProvinces
{
    NSArray* cityWithProvices = @[
                                  @"上海市",
                                  @"广东省 深圳市",
                                  @"天津市",
                                  @"广东省 广州市",
                                  @"重庆市",
                                  @"四川省 成都市",
                                  @"湖北省 武汉市",
                                  @"云南省 昆明市",
                                  @"辽宁省 沈阳市",
                                  @"浙江省 杭州市",
                                  @"江苏省 南京市",
                                  @"北京市"
                                  ];
    
    return cityWithProvices;
}


@end
