//
//  CitySelectTableViewController.m
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "CitySelectTableViewController.h"

@interface CitySelectTableViewController ()

@end

@implementation CitySelectTableViewController

@synthesize cities, keys;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.provinceName = [[NSString alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择城市"];
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydictionary"
                                                   ofType:@"plist"];
    self.cities = [[NSDictionary alloc]
                   initWithContentsOfFile:path];
    
    //    self.keys = [[cities allKeys] sortedArrayUsingSelector:
    //                    @selector(compare:)];
    
    self.keys = cities[self.provinceName];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"listCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.keys[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString* cityWithProvince = [NSString stringWithFormat:@"%@ %@", self.provinceName, [tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [self.delegete didSelectCityWithName:cityWithProvince];
    
    NSMutableArray* vcs = [self.navigationController.viewControllers mutableCopy];
    if (vcs.count>=2 && [vcs[vcs.count-2] isKindOfClass:NSClassFromString(@"CityListViewController")]) {
        [vcs removeObject:vcs[vcs.count-2]];
    }
    self.navigationController.viewControllers = [vcs copy];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
