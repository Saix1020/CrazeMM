//
//  AddressEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressEditViewController.h"


@interface AddressEditViewController ()
@property (weak, nonatomic) IBOutlet UIView *lastLine;

@end

@implementation AddressEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改收货地址";
    
    // Do any additional setup after loading the view from its nib.
    self.lastLine.backgroundColor = [UIColor clearColor];
    self.lastLine.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.lastLine.layer.borderWidth = .5f;
    
    self.saveButton.layer.cornerRadius = 4.f;
    CGSize fontSize = [self.locationButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.locationButton.titleLabel.font}];
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.locationButton.imageView.frame.size.width-2.f, 0, self.locationButton.imageView.frame.size.width+2.f)];
    [self.locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];
    
    self.defaultCheckBox.boxType = BEMBoxTypeSquare;
    
    self.saveButton.backgroundColor = [UIColor light_Gray_Color];
//    self.saveButton
    @weakify(self);
    self.saveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    self.locationButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        CityListViewController* vc = [[CityListViewController alloc] init];
        vc.delegete = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        return [RACSignal empty];
    }];
    
//    UITableView* tableView = (UITableView*)self.view;
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];

}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
//    CGFloat offsetY = self.navigationController.navigationBar.bounds.size.height+[UIApplication sharedApplication].statusBarFrame.size.height;
//    self.view.frame = CGRectMake(0, offsetY, self.view.bounds.size.width, self.view.bounds.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -- City list vc delegate
- (void)didSelectCityWithName:(NSString *)cityName
{
    self.cityLabel.text = cityName;
}

@end
