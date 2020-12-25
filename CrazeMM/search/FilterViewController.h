//
//  FilterViewController.h
//  CrazeMM
//
//  Created by saix on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTagLabel.h"


@protocol FilterViewControllerDelegate <NSObject>

-(void)dismiss;
-(void)didSetSerachConditions:(NSDictionary*)conditions;
@end

@interface FilterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, FilterTagLabelDelegate>

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* filterType; // 'buy'/'supply'

-(instancetype)initWithSearchConditions:(NSDictionary*)conditons;

@end
