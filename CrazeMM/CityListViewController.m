//
//  CitySelectTableViewController.h
//  Wear
//
//  Created by 孙恺 on 15/11/26.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "CityListViewController.h"
#import "CitySelectTableViewController.h"
#import "HotCityTableViewCell.h"

@interface CityListViewController ()<UITableViewDelegate, UITableViewDataSource, CitySelectDelegate, HotCityCellDelegate>

@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *searchList;

@property NSUInteger curSection;
@property NSUInteger curRow;
@end

@implementation CityListViewController

@synthesize cities, keys, curSection, curRow;

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UINavigationBar *naviBar = [[UINavigationBar alloc] init];
    [self setTitle:@"选择省份"];
    self.view.backgroundColor = [UIColor clearColor];

    NSString *path=[[NSBundle mainBundle] pathForResource:@"provincedictionary"
                                                   ofType:@"plist"]; 
    self.cities = [[NSDictionary alloc]   
                        initWithContentsOfFile:path];
    
    self.keys = [[cities allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSUInteger len0 = [(NSString *)obj1 length];
        NSUInteger len1 = [(NSString *)obj2 length];
        return len0 > len1 ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.keys = nil;
    self.cities = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (self.searchController.active) {
//        return 1;
//    }else {
        // Return the number of sections.
        return [keys count];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.searchController.active) {
//        return self.searchList.count;
//    }else {
        // Return the number of rows in the section.
        NSString *key = [keys objectAtIndex:section];  
        NSArray *citySection = [cities objectForKey:key];
        return [citySection count];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotcityCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotCityTableViewCell" owner:self options:nil] lastObject];
        }
        cell.delegate = self;
        return cell;
    } else {
    
    
        static NSString *CellIdentifier = @"Cell";
        
        NSString *key = [keys objectAtIndex:indexPath.section];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
//        if (self.searchController.active) {
//            [cell.textLabel setText:self.searchList[indexPath.row]];
//        } else {
            // Configure the cell...
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [[cities objectForKey:key] objectAtIndex:indexPath.row];
//        }
        return cell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [keys objectAtIndex:section];
    return key;  
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchString = [self.searchController.searchBar text];
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (self.searchList!= nil) {
//        [self.searchList removeAllObjects];
//    }
//    //过滤数据
//    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return 160;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CitySelectTableViewController *tablevc = [[CitySelectTableViewController alloc] init];
    tablevc.provinceName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    tablevc.delegete = self;
//    [self pushViewController:tablevc animated:YES];
//    [self presentViewController:tablevc animated:YES completion:nil];
    [self.navigationController pushViewController:tablevc animated:YES];
}

- (void)didSelectCityWithName:(NSString *)cityName {
    [self.delegete didSelectCityWithName:cityName];
}

- (void)didSelectHotCity:(NSString *)cityName {

    [self.delegete didSelectCityWithName:cityName];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
