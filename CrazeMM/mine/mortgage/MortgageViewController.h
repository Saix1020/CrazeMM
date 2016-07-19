//
//  MortgageViewController.h
//  CrazeMM
//
//  Created by saix on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonOrderListViewController.h"
#import "HttpMortgage.h"
#import "MortgageEditViewController.h"

@interface MortgageViewController : CommonOrderListViewController<MortgageEditViewControllerDelegate, UIActionSheetDelegate>

@end
