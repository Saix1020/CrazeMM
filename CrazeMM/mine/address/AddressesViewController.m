//
//  AddressesViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressesViewController.h"
#import "AddrDetailCell.h"
#import "AddressEditViewController.h"
#import "HttpAddress.h"

@interface AddressesViewController ()

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* addresses;
@property (nonatomic, strong) AddrDTO* defaultAddrDto;
@end

@implementation AddressesViewController

-(instancetype)initWithAddresses:(NSArray*)addresses
{
    self = [super init];
    if (self) {
        self.addresses = (NSMutableArray*)addresses;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收货地址管理";
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
    [self.tableView registerNib:[UINib nibWithNibName:@"AddrDetailCell" bundle:nil] forCellReuseIdentifier:@"AddrDetailCell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTabBarHidden:YES animated:YES];
    [self refreshAddressList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.addresses) {
        return 0;
    }
    return [self.addresses count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddrDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AddrDetailCell"];
    cell.addrDto = self.addresses[indexPath.section];
    cell.delegate = self;
    cell.defaultCheckBox.tag = 1000 + indexPath.section;
    cell.defaultCheckBox.delegate = self;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectedAddress:)]) {
        [self.delegate didSelectedAddress:self.addresses[indexPath.row]];
    }
}

#pragma -- mark AddressListCell delegate
-(void)editButtonClicked:(AddrDetailCell *)cell
{
    AddressEditViewController* addrEditVC = [[AddressEditViewController alloc] initWithAddress:cell.addrDto];
    [self.navigationController pushViewController:addrEditVC animated:YES];
    
}

-(void)deleteButtonClicked:(AddrDetailCell *)cell
{
   
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"确认要删除该地址吗?"]
                    withOKCallback:^(id x){
                        @strongify(self);
                        HttpAddressDeleteRequest* request = [[HttpAddressDeleteRequest alloc] initWithAddrId:cell.addrDto.id];
                        [request request]
                        .then(^(id responseObj){
                            if (request.response.ok) {
                                [self refreshAddressList];
                            }
                            else {
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                 andCancelCallback:nil];
}

#pragma mark - didTapCheckBox delegate
-(BOOL)willTapCheckBox:(BEMCheckBox*)checkBox
{
    NSInteger index = checkBox.tag - 1000;
    AddrDTO* addrDto = self.addresses[index];
    if (addrDto.isDefault) {
        return NO;
    }
    
    addrDto.isDefault = YES;
    
    @weakify(self);
    [self showAlertViewWithMessage:[NSString stringWithFormat:@"确认要设为默认地址吗?"]
                    withOKCallback:^(id x){
                        @strongify(self);
                        HttpAddressUpdateRequest* request = [[HttpAddressUpdateRequest alloc] initWithAddrDto:addrDto];
                        [request request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (request.response.ok) {
                                self.defaultAddrDto.isDefault = NO;
                                self.defaultAddrDto = addrDto;
                                [self sortAddressByDefault];
                                [self.tableView reloadData];
                                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                      atScrollPosition:UITableViewScrollPositionTop
                                                              animated:YES];
                            }
                            else {
                                addrDto.isDefault = NO;
                                [self showAlertViewWithMessage:request.response.errorMsg];
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        });
                    }
                 andCancelCallback:nil];
    
    return NO;
}

//- (void)didTapCheckBox:(BEMCheckBox*)checkBox
//{
//    NSInteger index = checkBox.tag - 1000;
//    //NSLog(@"index %ld is checked!", index);
//    AddrDTO* addrDto = self.addresses[index];
//    AddrDTO* defaultAddrDto = nil;
//    if(NO == addrDto.isDefault)
//    {
//        NSInteger index = 0;
//        for (AddrDTO* addr in self.addresses)
//        {
//             if (YES == addr.isDefault)
//             {
//                 addr.isDefault = NO;
//                 defaultAddrDto = addr;
//                 
//                 break;
//             }else
//             {
//                 index++;
//             }
//            
//            
//        }
//        addrDto.isDefault = YES;
//        
//        //update 2 addrDto
//        //we has a risk here: the first addrDto is updated failed, then the sencond one will not be launched. TBD
//        
//        @weakify(self);
//        [self showAlertViewWithMessage:[NSString stringWithFormat:@"确认要设为默认地址吗?"]
//                        withOKCallback:^(id x){
//                            @strongify(self);
//                            HttpAddressUpdateRequest * request = [[HttpAddressUpdateRequest alloc] initWithAddrDto:defaultAddrDto];
//                            [request request]
//                            .then(^(id responseObj){
//                                //NSLog(@"1.%@", responseObj);
//                                if (!request.response.ok) {
//                                    [self showAlertViewWithMessage:request.response.errorMsg];
//                                }
//                                else {
//                                    HttpAddressUpdateRequest* request = [[HttpAddressUpdateRequest alloc] initWithAddrDto:addrDto];
//                                    [request request]
//                                    .then(^(id responseObj){
//                                        //NSLog(@"2.%@", responseObj);
//                                        if (!request.response.ok) {
//                                            [self showAlertViewWithMessage:request.response.errorMsg];
//                                        }
//                                        else {
//                                            [self refreshAddressList];
//                                        }
//                                    })
//                                    .catch(^(NSError* error){
//                                        
//                                        [self showAlertViewWithMessage:error.localizedDescription];
//                                    })
//                                    .finally(^(){
//                                    });
//                                    
//                                }
//                            })
//                            .catch(^(NSError* error){
//                                
//                                [self showAlertViewWithMessage:error.localizedDescription];
//                            })
//                            .finally(^(){
//                            });
//                        }
//                     andCancelCallback:^(id x){
//                         [self refreshAddressList];
//                     }];
//        
//    }
//    else
//    {
//        [self refreshAddressList];
//    }
//    
//    
//}

#pragma mark - sort address by default
- (void) sortAddressByDefault
{
    self.defaultAddrDto = nil;

    for (AddrDTO* addr in self.addresses)
    {
        if (addr.isDefault == YES) {
            self.defaultAddrDto = addr;
            break;
        }
        else {
            addr.isDefault = nil;
        }
    }
    if (self.defaultAddrDto && self.addresses.firstObject != self.defaultAddrDto) {
        [self.addresses removeObject:self.defaultAddrDto];
        [self.addresses insertObject:self.defaultAddrDto atIndex:0];
    }
}

- (void)refreshAddressList
{
    HttpAddressDetailRequest* request = [[HttpAddressDetailRequest  alloc] init];
    [request request]
    .then(^(id responseObj){
        HttpAddressDetailResponse* response = (HttpAddressDetailResponse*)request.response;
        if (response.ok) {
            self.addresses = [response.addresses mutableCopy];
            [self sortAddressByDefault];
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

@end
