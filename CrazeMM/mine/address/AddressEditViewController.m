//
//  AddressEditViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AddressEditTableViewCell.h"
#import "AddressLocationTableViewCell.h"
#import "AddressDefaultTableViewCell.h"


@interface AddressEditViewController ()
/*
@property (weak, nonatomic) IBOutlet UIView *lastLine;
 */

@end

@implementation AddressEditViewController

@synthesize listData;

/*
- (id)init
{
    self = [super initWithNibName:@"AddressEditViewController" bundle:nil];
    if (self) {
    }
    return self;
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改收货地址";
    
    
    //[self.addressEditTableView setSeparatorColor:[UIColor light_Gray_Color]];
    //[self.addressEditTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"收货人", @"联系电话", @"所在地区", @"详细地址", @"邮政编码", @"设为默认值",  nil];
    self.listData = array;
    
    
    UINib *nib1 = [UINib nibWithNibName:@"AddressEditTableViewCell"
                                bundle:nil];
    [self.addressEditTableView registerNib:nib1
         forCellReuseIdentifier:@"AddressEditTableViewCell"];
    
    /*
    UINib *nib2 = [UINib nibWithNibName:@"AddressLocationTableViewCell"
                                bundle:nil];
    [self.addressEditTableView registerNib:nib2
                    forCellReuseIdentifier:@"AddressLocationTableViewCell"];
    */
   

    
    /*
    // Do any additional setup after loading the view from its nib.
    self.lastLine.backgroundColor = [UIColor clearColor];
    self.lastLine.layer.borderColor = [UIColor light_Gray_Color].CGColor;
    self.lastLine.layer.borderWidth = .5f;
    
    self.saveButton.layer.cornerRadius = 4.f;
    CGSize fontSize = [self.locationButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.locationButton.titleLabel.font}];
    [self.locationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.locationButton.imageView.frame.size.width-2.f, 0, self.locationButton.imageView.frame.size.width+2.f)];
    [self.locationButton setImageEdgeInsets:UIEdgeInsetsMake(0, fontSize.width, 0, -fontSize.width)];
    
    self.defaultCheckBox.boxType = BEMBoxTypeSquare;
     */
    
    self.saveButton.backgroundColor = [UIColor light_Gray_Color];
//    self.saveButton
    @weakify(self);
    self.saveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    /*
    self.locationButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
        @strongify(self);
        CityListViewController* vc = [[CityListViewController alloc] init];
        vc.delegete = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        return [RACSignal empty];
    }];
     */
    
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
    //self.cityLabel.text = cityName;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSLog(@"%@", [listData objectAtIndex:row]);
    UITableViewCell *cell;
    switch (row) {
        case 0:
        case 1:
        case 3:
        case 4:
        {
            NSString *TableIdentifier = @"AddressEditTableViewCell";
            
            AddressEditTableViewCell *addressCell;
            addressCell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
            
            if (addressCell == nil) {
                addressCell = [[AddressEditTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:TableIdentifier];
            }
            
            addressCell.AddressEditLabel.text = [listData objectAtIndex:row];
            cell = addressCell;
            break;
        }
            
        case 2:
        {
            NSString *TableIdentifier = @"AddressLocationTableViewCell";
            
            AddressLocationTableViewCell *locationCell;
            locationCell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
            
            if (locationCell == nil) {
                locationCell = [[[NSBundle mainBundle]loadNibNamed:TableIdentifier owner:nil options:nil] firstObject];

            }
            locationCell.locationLabel.text = [listData objectAtIndex:row];
            cell = locationCell;
            break;
        }
            
        case 5:
        {
            NSString *TableIdentifier = @"AddressDefaultTableViewCell";
            
            AddressDefaultTableViewCell *defaultCheckCell;
            defaultCheckCell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
            
            if (defaultCheckCell == nil) {
                defaultCheckCell = [[[NSBundle mainBundle]loadNibNamed:TableIdentifier owner:nil options:nil] firstObject];
                
            }
            cell = defaultCheckCell;
            break;
        }
            
            
        default:
            break;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
    

@end
