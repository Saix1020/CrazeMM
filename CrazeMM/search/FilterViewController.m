//
//  FilterViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterGoodInfo.h"
#import "HttpGoodInfoQuery.h"
#import "HttpGoodCatagory.h"
#import "FilterPriceCell.h"
#import "FilterTagsCell.h"
//#import "TPKeyboardAvoidingTableView.h"
#import "BrandHeadView.h"
#import "HttpSearchRequest.h"
#import "HttpSearchKeyword.h"

@interface FilterViewController ()

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) FilterPriceCell* priceCell;
@property (nonatomic, strong) FilterTagsCell* brandsCell;
@property (nonatomic, strong) FilterTagsCell* colorsCell;
@property (nonatomic, strong) FilterTagsCell* networksCell;
@property (nonatomic, strong) FilterTagsCell* volumesCell;


@property (nonatomic, readonly) NSArray* brandsArray;
//@property (nonatomic, copy) NSArray* colorsArray;
//@property (nonatomic, copy) NSArray* networksArray;
//@property (nonatomic, copy) NSArray* volumesArray;
@property (nonatomic, strong) FilterGoodInfo* filterGoodInfo;

@property (nonatomic) BOOL showAllBrands;


@property (nonatomic) BrandHeadView* brandCellHeadView;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) UIButton* cancelButton;


@property (nonatomic, copy) NSDictionary* orignalConditions;
@end

@implementation FilterViewController

-(instancetype)initWithSearchConditions:(NSDictionary*)conditons
{
    self = [super init];
    if (self) {
        self.orignalConditions = conditons;
    }
    return self;
}

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [self.view addSubview:_bottomView];
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.tintColor = [UIColor whiteColor];
        _confirmButton.backgroundColor = [UIColor redColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.backgroundColor = [UIColor light_Gray_Color];
        _cancelButton.tintColor = [UIColor blackColor];
        [_cancelButton setTitle:@"重置" forState:UIControlStateNormal];
        
        [_bottomView addSubview:_confirmButton];
        [_bottomView addSubview:_cancelButton];
        
        [_confirmButton addTarget:self action:@selector(addSearchCond:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton addTarget:self action:@selector(resetSearchCond:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bottomView;
}

-(void)addSearchCond:(id)sender
{
    NSMutableDictionary* conditions = [[NSMutableDictionary alloc] init];
    
    if (self.priceCell.minPrice >= 0) {
        [conditions setValue:@(self.priceCell.minPrice)
                       forKey:@"minPrice"];
        
    }
    
    if (self.priceCell.maxPrice>=0) {
        [conditions setValue:@(self.priceCell.maxPrice)
                       forKey:@"maxPrice"];
        
    }
    
    if (self.brandsCell.selectedTags.count>0) {
        [conditions setValue:self.brandsCell.selectedTags forKey: @"brands"];
        
    }
    if (self.colorsCell.selectedTags.count>0) {
        [conditions setValue:self.colorsCell.selectedTags forKey: @"colors"];
        
    }
    if (self.networksCell.selectedTags.count>0) {
        [conditions setValue:self.networksCell.selectedTags forKey: @"networks"];
        
    }
    if (self.volumesCell.selectedTags.count>0) {
        [conditions setValue:self.volumesCell.selectedTags forKey: @"volumes"];
        
    }
    
    if ([self.delegate respondsToSelector:@selector(didSetSerachConditions:)]) {
        [self.delegate didSetSerachConditions:conditions];
    }
    [self cancelFilter];
}

-(void)resetSearchCond:(id)sender
{
    [self.priceCell reset];
    [self.brandsCell reset];
    [self.colorsCell reset];
    [self.networksCell reset];
    [self.volumesCell reset];

//    self.networksCell.delegate = self;
//    self.volumesCell.delegate = self;
}

-(BrandHeadView*)brandCellHeadView
{
    if (!_brandCellHeadView) {
        _brandCellHeadView = (BrandHeadView*)[UINib viewFromNib:@"BrandHeadView"];
        [_brandCellHeadView.expandButton addTarget:self action:@selector(expandButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _brandCellHeadView;
}

-(void)expandButtonClicked:(id)sender
{
    self.showAllBrands = !self.showAllBrands;
    if (self.showAllBrands) {
        [self.brandCellHeadView.expandButton setImage:[@"icon_pullup" image] forState:UIControlStateNormal];

    }
    else {
        [self.brandCellHeadView.expandButton setImage:[@"icon_pulldown" image] forState:UIControlStateNormal];

    }
//    [self.brandCellHeadView.expandButton setTitle:@"全部" forState:UIControlStateNormal];

    
    [self.tableView reloadData];
}

-(NSArray*)brandsArray
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSInteger count = 0;
    for (GoodBrandDTO* dto in self.filterGoodInfo.brands){
        [array addObject:dto.name];
        count++;
        if (!self.showAllBrands &&  count==9) {
            break;
        }
    }
    return array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    [self.tableView setTableFooterView:view];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.frame = self.view.bounds;
    
    self.navigationItem.title  = @"筛选";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelFilter) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    self.priceCell = (FilterPriceCell*)[UINib viewFromNib:@"FilterPriceCell"];
    self.brandsCell = [[FilterTagsCell alloc] init];
    self.colorsCell = [[FilterTagsCell alloc] init];
    self.networksCell = [[FilterTagsCell alloc] init];
    self.volumesCell = [[FilterTagsCell alloc] init];
    self.brandsCell.delegate = self;
    self.colorsCell.delegate = self;
    self.networksCell.delegate = self;
    self.volumesCell.delegate = self;
    
    self.filterGoodInfo = [FilterGoodInfo sharedInstance];
    
    // TODO we should use promise all here
    
    if (!self.filterGoodInfo.brands.count) {
        //
        HttpBrandQueryRequest* request = [[HttpBrandQueryRequest alloc] init];
        [request request]
        .then(^(id responseObj){
            HttpBrandQueryResponse* response = (HttpBrandQueryResponse*)request.response;
            if (response.ok) {
                self.filterGoodInfo.brands = response.brandDtos;
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }
    else {
        self.brandsCell.filterTags = self.brandsArray;
    }
    if (!self.filterGoodInfo.colors.count) {
        //
        HttpGoodColorRequest* request = [[HttpGoodColorRequest alloc] init];
        [request request]
        .then(^(id responseObj){
            HttpGoodColorResponse* response = (HttpGoodColorResponse*)request.response;
            if (response.ok) {
                self.filterGoodInfo.colors = response.colors;
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }
    else {
        self.colorsCell.filterTags = self.filterGoodInfo.colors;
    }
    if (!self.filterGoodInfo.networks.count) {
        //
        HttpGoodNetworkRequest* request = [[HttpGoodNetworkRequest alloc] init];
        [request request]
        .then(^(id responseObj){
            HttpGoodNetworkResponse* response = (HttpGoodNetworkResponse*)request.response;
            if (response.ok) {
                self.filterGoodInfo.networks = response.networks;
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }
    else {
        self.networksCell.filterTags = self.filterGoodInfo.networks;
    }
    if (!self.filterGoodInfo.volumes.count) {
        //
        HttpGoodVolumeRequest* request = [[HttpGoodVolumeRequest alloc] init];
        [request request]
        .then(^(id responseObj){
            HttpGoodVolumeResponse* response = (HttpGoodVolumeResponse*)request.response;
            if (response.ok) {
                self.filterGoodInfo.volumes = response.volums;
                [self.tableView reloadData];
            }
            else {
                [self showAlertViewWithMessage:response.errorMsg];
            }
        })
        .catch(^(NSError* error){
            [self showAlertViewWithMessage:error.localizedDescription];
        });
    }
    else{
       self.volumesCell.filterTags = self.filterGoodInfo.volumes;
    }
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];

}

-(void)tap
{
    [self.view endEditing:YES];
}

-(void)cancelFilter
{
    if ([self.delegate respondsToSelector:@selector(dismiss)]){
        [self.delegate dismiss];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    self.bottomView.frame = CGRectMake(0, self.view.height-40.f, self.view.bounds.size.width, 40.f);
    self.confirmButton.frame = CGRectMake(self.bottomView.width/2, 0, self.bottomView.width/2, self.bottomView.height);
    self.cancelButton.frame = CGRectMake(0, 0, self.bottomView.width/2, self.bottomView.height);
    
//    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height+self.bottomView.height);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==1) {
        return self.brandCellHeadView;
    }
    
    UIView* containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 0, 200, 28)];
    label.font = [UIFont systemFontOfSize:14.f];
    [containerView addSubview:label];
    switch (section) {
        case 0:
            label.text = @"价格区级";
            break;
//        case 1:
//            label.text = @"品牌";
//            break;
        case 2:
            label.text = @"颜色";
            break;
        case 3:
            label.text = @"网络制式";
            break;
        case 4:
            label.text = @"容量";
            break;

        default:
            break;
    }
    [label sizeToFit];
    label.x = 8.f;
    label.y = ceil((32.f-label.height)/2);
    return containerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = self.priceCell;
            break;
        case 1:
            cell = self.brandsCell;
            self.brandsCell.filterTags = self.brandsArray;
            break;
        case 2:
            cell = self.colorsCell;
            self.colorsCell.filterTags = self.filterGoodInfo.colors;
            break;
        case 3:
            cell = self.networksCell;
            self.networksCell.filterTags = self.filterGoodInfo.networks;

            break;
        case 4:
            cell = self.volumesCell;
            self.volumesCell.filterTags = self.filterGoodInfo.volumes;

            break;
            
        default:
            cell = [[UITableViewCell alloc] init];
            cell.backgroundColor = [UIColor clearColor];
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    switch (indexPath.section) {
        case 0:
            cell = self.priceCell;
            break;
        case 1:
            cell = self.brandsCell;
            break;
        case 2:
            cell = self.colorsCell;
            break;
        case 3:
            cell = self.networksCell;
            
            break;
        case 4:
            cell = self.volumesCell;
            
            break;
            
        default:
            return 40.f;
            break;
    }
    
    return cell.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// resign first respond
-(void)didTaped:(id)sender
{
    [self.view endEditing:YES];
}

-(void)dealloc
{
    NSLog(@"dealloc: %@", [self class]);
}

@end
