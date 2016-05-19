//
//  AddressEditViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"
#import "BEMCheckBox.h" 
#import "AddressDTO.h"
@interface AddressEditViewController : UIViewController<CityListDelegate, UITableViewDataSource, UITableViewDelegate>
/*
@property (weak, nonatomic) IBOutlet UITextField *receiverField;
@property (weak, nonatomic) IBOutlet UILabel *zipField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet BEMCheckBox *defaultCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
*/

@property (strong, nonatomic) AddressDTO* address;

-(instancetype)initWithAddress:(AddressDTO*)address;


@end
