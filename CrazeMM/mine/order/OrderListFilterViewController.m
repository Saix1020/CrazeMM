//
//  OrderListFilterViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderListFilterViewController.h"
//#import "UIViewController+KNSemiModal.h"

@interface OrderListFilterViewController ()

@property (nonatomic, strong) TPKeyboardAvoidingTableView* tableView;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) UIButton* cancelButton;


@property (nonatomic, copy) NSDictionary* orignalConditions;

@property (nonatomic, strong) UITextField* nameField;
@property (nonatomic, strong) UITableViewCell* nameFieldCell;
@property (nonatomic, strong) UITableViewCell* nameLabelCell;
@property (nonatomic, strong) UITableViewCell* createLabelCell;
@property (nonatomic, strong) UITableViewCell* updateLabelCell;
@property (nonatomic, strong) DateRangePickerCell* createDateCell;
@property (nonatomic, strong) DateRangePickerCell* updateDateCell;

@property (nonatomic, strong) UILabel* nameLabel;

@end




@implementation OrderListFilterViewController

-(NSArray*)cellArray
{
    return @[self.nameLabelCell, self.nameFieldCell, self.createLabelCell, self.createDateCell, self.updateLabelCell, self.updateDateCell];
}

-(UITextField*)nameField
{
    if (!_nameField) {
        _nameField = [[UITextField alloc] initWithFrame:CGRectMake(16.f, 4.f, 0, 30.f)];
        _nameField.placeholder = @"请输入订单号/商品名称";
        _nameField.borderStyle = UITextBorderStyleRoundedRect;
        _nameField.font = [UIFont smallFont];
    }
    return _nameField;
}

-(UITableViewCell*)nameFieldCell
{
    if (!_nameFieldCell) {
        _nameFieldCell = [[UITableViewCell alloc] init];
        [_nameFieldCell.contentView addSubview:self.nameField];
        _nameFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _nameFieldCell;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 2.f, 180, 26.f)];
        _nameLabel.font = [UIFont smallFont];
        _nameLabel.text = @"订单号/商品名称";
    }
    
    return _nameLabel;
}

-(UITableViewCell*)nameLabelCell
{
    if (!_nameLabelCell) {
        _nameLabelCell = [[UITableViewCell alloc] init];
        [_nameLabelCell.contentView addSubview:self.nameLabel];
        _nameLabelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _nameLabelCell;
}

-(UITableViewCell*)createLabelCell
{
    if (!_createLabelCell) {
        _createLabelCell = [[UITableViewCell alloc] init];
        UILabel* createLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 2.f, 180, 26.f)];
        createLabel.font = [UIFont smallFont];
        createLabel.text = @"下单时间";
        [_createLabelCell.contentView addSubview:createLabel];
        _createLabelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _createLabelCell;
}

-(UITableViewCell*)updateLabelCell
{
    if (!_updateLabelCell) {
        _updateLabelCell = [[UITableViewCell alloc] init];
        UILabel* updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 2.f, 180, 26.f)];
        updateLabel.font = [UIFont smallFont];
        updateLabel.text = @"更新时间";
        [_updateLabelCell.contentView addSubview:updateLabel];
        _updateLabelCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return _updateLabelCell;
}

-(DateRangePickerCell*)createDateCell
{
    if(!_createDateCell){
        _createDateCell = (DateRangePickerCell*)[UINib viewFromNib:@"DateRangePickerCell"];
        _createDateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _createDateCell.delegate = self;
    }
    
    return _createDateCell;
}

-(DateRangePickerCell*)updateDateCell
{
    if(!_updateDateCell){
        _updateDateCell = (DateRangePickerCell*)[UINib viewFromNib:@"DateRangePickerCell"];
        _updateDateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _updateDateCell.delegate = self;

    }
    
    return _updateDateCell;
}

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
        
        [_confirmButton addTarget:self action:@selector(setSearchCond:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton addTarget:self action:@selector(resetSearchCond) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _bottomView;
}

-(NSDictionary*)conditions
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString* name = self.nameField.text;
    if (!name) {
        name = @"";
    }
    //http://b.189mm.net/rest/order?pn=1&state=100&t=b&complex=111&cbegin=2016-08-10&cend=2016-08-31&ubegin=2016-08-09&uend=
    NSString* createFromDateString = self.createDateCell.fromDate?[inputFormatter stringFromDate:self.createDateCell.fromDate]:@"";
    NSString* createToDateString = self.createDateCell.toDate?[inputFormatter stringFromDate:self.createDateCell.toDate]:@"";
    NSString* updateFromDateString = self.updateDateCell.fromDate?[inputFormatter stringFromDate:self.updateDateCell.fromDate]:@"";
    NSString* updateToDateString = self.updateDateCell.toDate?[inputFormatter stringFromDate:self.updateDateCell.toDate]:@"";
    
    NSDictionary* conditions = @{
                                 @"complex" : name,
                                 @"cbegin" : createFromDateString,
                                 @"cend" : createToDateString,
                                 @"ubegin" : updateFromDateString,
                                 @"uend" : updateToDateString
                                 };
    return conditions;
}

-(void)setSearchCond:(UIButton*)button
{
    
    if ([self.delegate respondsToSelector:@selector(didSetSerachConditions:)]){
        [self.delegate didSetSerachConditions:self.conditions];
    }
    
    if ([self.delegate respondsToSelector:@selector(dismiss)]){
        [self.delegate dismiss];
    }
}

-(void)resetSearchCond
{
    [self.createDateCell reset];
    [self.updateDateCell reset];
    self.nameField.text = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

    
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)tap:(UITapGestureRecognizer*)guesture
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
    
    self.nameField.width = self.view.width - 16.f*2;
}


#pragma - mark tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* view = [[UIView alloc] init];
//    [view addSubview:self.nameLabel];
//    return view;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell* cell;
    
    return self.cellArray[indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0) {
        return 30.f;
    }
    return 38.f;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.f;
//}
#pragma  - mark DateRangePickerCellDelegate 
-(void)startDatePicking:(THDatePickerViewController*)datePicker
{
    [self.view endEditing:YES];
    @weakify(self);
    [self presentSemiViewController:datePicker withOptions:@{
                                                             KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                             KNSemiModalOptionKeys.animationDuration : @(.5),
                                                             KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                             }
                         completion:^(){
                             @strongify(self);
                             [self datePickingViewDidAppeared];
                         }
                       dismissBlock:^(){
                           @strongify(self);
                           [self datePickingViewDidDisappeared];
                       }];

}

-(void)datePickingViewDidAppeared
{
    
}

-(void)datePickingViewDidDisappeared
{
    
}

-(void)endDatePicking:(THDatePickerViewController *)datePicker
{
    [datePicker dismissSemiModalView];
}

-(void)alertWithMessage:(NSString *)message
{
    [self showAlertViewWithMessage:message];
}

@end
