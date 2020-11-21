//
//  ConsigneeAddViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsigneeDTO.h"
@interface ConsigneeAddViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

-(instancetype)initWithConsigneeDTO:(ConsigneeDTO*)dto;

@end
