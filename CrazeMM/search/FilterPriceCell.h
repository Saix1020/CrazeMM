//
//  FilterPriceCell.h
//  CrazeMM
//
//  Created by saix on 16/6/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterPriceCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, readonly) float minPrice;
@property (nonatomic, readonly) float maxPrice;

@property (weak, nonatomic) IBOutlet UITextField *minField;
@property (weak, nonatomic) IBOutlet UITextField *maxField;

-(void)reset;


@end
