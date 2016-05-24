//
//  AddressListViewController.m
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressListViewController.h"
#import "SelectdAddrCell.h"
#import "AddressListCell.h"
#import "AddressEditViewController.h"
#import "HttpAddress.h"

typedef NS_ENUM(NSInteger, MineAddressListSection){
    kSectionRecommand = 0,
    kSectionAllAddress = 1,
    kSectionNumber
};

@interface AddressListViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) AddressListCell* recommandCell;
@property (nonatomic, copy) NSArray* addresses;

@end


@implementation AddressListViewController

-(AddressListCell*)recommandCell
{
    if (!_recommandCell) {
        _recommandCell = [[[NSBundle mainBundle]loadNibNamed:@"AddressListCell" owner:nil options:nil] firstObject];
        _recommandCell.isDefault = YES;
        _recommandCell.delegate = self;
    }
    
    return _recommandCell;
}

-(instancetype)initWithAddresses:(NSArray*)addresses
{
    self = [super init];
    if (self) {
        self.addresses = addresses;
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择收货地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addr_add_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
        
        AddressEditViewController* addrEditVC = [[AddressEditViewController alloc] init];
        [self.navigationController pushViewController:addrEditVC animated:YES];
        
        return [RACSignal empty];
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBCOLOR(240, 240, 240);
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressListCell" bundle:nil] forCellReuseIdentifier:@"AddressListCell"];
}



-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HttpAddressDetailRequest* request = [[HttpAddressDetailRequest  alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpAddressDetailResponse* response = (HttpAddressDetailResponse*)request.response;
        if (response.ok) {
            self.addresses = response.addresses;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.addresses) {
        return 0;
    }
    return kSectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case kSectionRecommand:
        {
            return 1;
        }
            break;
        case kSectionAllAddress:
        {
            return self.addresses.count>1?self.addresses.count-1:0;
        }
            break;
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell;
    
    switch (indexPath.section) {
        case kSectionRecommand:
        {
            self.recommandCell.addrDto = self.addresses[0];
            cell = self.recommandCell;
        }
            break;
        case kSectionAllAddress:
        {
            AddressListCell* addressCell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
            addressCell.isDefault = NO;
            addressCell.addrDto = self.addresses[indexPath.row+1];
//            if(addressCell.editButton.rac_command == nil){
//                addressCell.editButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x) {
//                    
//                    AddressEditViewController* addrEditVC = [[AddressEditViewController alloc] init];
//                    [self.navigationController pushViewController:addrEditVC animated:YES];
//                    
//                    return [RACSignal empty];
//                }];
//            }
            addressCell.delegate = self;
            cell = addressCell;
        }
            break;
        default:
            break;
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case kSectionRecommand:
        {
            return 85.f;
        }
            break;
        case kSectionAllAddress:
        {
            return 85.f;
        }
            break;
        default:
            break;
    }
    
    return 80.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        AddrDTO* addrDto = self.addresses[indexPath.row+1];
        
        //    AddressEditViewController* addrEditVC = [[AddressEditViewController alloc] initWithAddress:addrDto];
        //    [self.navigationController pushViewController:addrEditVC animated:YES];
        
        if ([self.delegate respondsToSelector:@selector(didSelectedAddress:)]) {
            [self.delegate didSelectedAddress:addrDto];
        }
        [self.navigationController popViewControllerAnimated:YES];


    }
    
}

#pragma -- mark AddressListCell delegate
-(void)editButtonClicked:(AddressListCell *)cell
{
    AddressEditViewController* addrEditVC = [[AddressEditViewController alloc] initWithAddress:cell.addrDto];
    [self.navigationController pushViewController:addrEditVC animated:YES];

}

@end
