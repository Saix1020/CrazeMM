//
//  MineSupplyInfoViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSupplyInfoViewController.h"
#import "TimeLineViewControl.h"
#import "HttpMineSupply.h"
#import "MineSupplyEditViewController.h"
#import "HttpMineSupplyShelve.h"


@interface MineSupplyInfoViewController ()
@property (nonatomic) NSInteger sid;
@property (nonatomic) NSInteger state;
@property (nonatomic, strong) MineSupplyDetailDTO* supplyDetailDto;
@property (nonatomic, strong) TimeLineViewControl *timeline;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, readonly) NSArray* bottomButtonsTitle;
@property (nonatomic, strong) NSArray* bottomButtons;

@end

//kNomalStyle = 0,
//kOffShelfStyle,
//kDealStyle,

@implementation MineSupplyInfoViewController

-(NSArray*)bottomButtonsTitle
{
    NSArray* titles;
    switch (self.state) {
        case 100: //正常
            titles = @[@"下架"];
            break;
        case 400:
        case 500: //下架
            titles = @[@"上架", @"修改"];
            break;
        case 150:
        case 200: //成交
            break;
        default:
            break;
    }
    
    return titles;
}

-(BOOL)needHideBottomView
{
    switch (self.state) {
        case 100: //正常
            return NO;
        case 400:
        case 500: //下架
            return NO;
        case 150:
        case 200: //成交
            return YES;
            break;
        default:
            break;
    }
    return YES;
}

-(NSArray*)bottomButtons
{
    if(!_bottomButtons) {
        NSMutableArray* buttons = [[NSMutableArray alloc] init];
        
        for(NSString* title in self.bottomButtonsTitle){
            UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont middleFont];
            button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(handleClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            [buttons addObject:button];
            [self.bottomView addSubview:button];
            [button sizeToFit];
            
        }
        _bottomButtons = buttons;
    }
    
    return _bottomButtons;
}

-(UIView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f)];
        [self.view addSubview:_bottomView];
        //        [_bottomView addSubview:self.confirmButton];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        // we hide it now
        // _bottomView.hidden = NO;
    }
    
    return _bottomView;
}



-(instancetype)initWithId:(NSUInteger)sid andState:(NSInteger)state;
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.state = state;
    }
    return self;
}

-(void)handleClickEvent:(id)sender
{
    switch (self.state) {
        case 100: //正常
        {
            HttpMineSupplyUnshelveRequest* request = [[HttpMineSupplyUnshelveRequest alloc] initWithIds:@[@(self.sid)]];
            [self invokeHttpRequest:request
                    andConfirmTitle: [NSString stringWithFormat:@"确认要下架%ld吗?", self.sid]
                    andSuccessTitle:@"下架成功"];
        }
            break;
        case 400:
        case 500: //
            if ([self.bottomButtons indexOfObject:sender] == 0) { //上架
                HttpMineSupplyReshelveRequest* request = [[HttpMineSupplyReshelveRequest alloc] initWithIds:@[@(self.sid)]];
                [self invokeHttpRequest:request
                        andConfirmTitle: [NSString stringWithFormat:@"确认要上架%ld吗?", self.sid]
                        andSuccessTitle:@"上架成功"];
            }
            else { //修改
                MineSupplyEditViewController* vc = [[MineSupplyEditViewController alloc] initWithId:self.sid];
                [self showAlertViewWithMessage:@"暂不支持"];
            }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"供货%ld详情", self.sid];
    
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
        
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height)];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.contentSize = self.view.bounds.size;
    [self.view addSubview:self.scrollView];
//    [self getSupplyDetailInfo];
    
    self.scrollView.backgroundColor = [UIColor UIColorFromRGB:0xF0F0F0];
    // Do any additional setup after loading the view.
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.bottomView.hidden = self.needHideBottomView;
    
    self.bottomView.frame = CGRectMake(0, self.view.height-44.f, self.view.bounds.size.width, 44.f);
    CGFloat rightX = self.view.bounds.size.width;
    for(UIButton* button in self.bottomButtons){
        button.height = 44.f;
        button.width = 80;
        button.right = rightX;
        button.y = 0;
        
        rightX -= button.width+1.f;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getDtoDetailInfo];
}

-(void)getDtoDetailInfo
{
    [self getSupplyDetailInfo];
}

-(void)deplayTimeLine: (NSArray*)logs
{
    logs = [logs sortedArrayUsingComparator:^NSComparisonResult(MineSupplyLogDTO* obj1, MineSupplyLogDTO* obj2){
        return [obj2.createTime localizedCompare:obj1.createTime];
    }];
    
    [self.timeline removeFromSuperview];
    
    NSMutableArray* timesPlacehoderArray = [[NSMutableArray alloc] init];
    NSMutableArray* commentsArray = [[NSMutableArray alloc] init];
    
    for (MineSupplyLogDTO* logDto in logs) {
        [timesPlacehoderArray addObject:@""];
        [commentsArray addObject:[NSString stringWithFormat:@"%@\n%@", logDto.message, logDto.createTime]];
    }
    
    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:timesPlacehoderArray
                                           andTimeDescriptionArray:commentsArray
                                                  andCurrentStatus:1
                                                          andFrame:CGRectMake(-40, 16+20.f, [UIScreen mainScreen].bounds.size.width , self.view.bounds.size.height+40.f)];
    [self.scrollView addSubview:self.timeline];
    [self.timeline sizeToFit];
    CGFloat needHeight = MAX(self.timeline.timeLabelsHeight, self.timeline.descLabelsHeight) + 40.f;
    //needHeight = MAX(self.view.bounds.size.height, needHeight);
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, needHeight);
}

- (AnyPromise*)getSupplyDetailInfo
{
    HttpMineSupplyDetailRequest* request = [[HttpMineSupplyDetailRequest alloc]initWithId:self.sid];
    
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpMineSupplyDetailResponse * response = (HttpMineSupplyDetailResponse*)request.response;
        if (response.ok) {
            self.supplyDetailDto = response.supplyDtailDto;
            [self deplayTimeLine:self.supplyDetailDto.logs];
        }
        
        else{
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
        
    });
    
}


-(void)httpRequestSuccess:(BaseHttpRequest*)request andSuccessMsg:(NSString *)msg
{
    if ([self.delegate respondsToSelector:@selector(didOperatorSuccessWithIds:)]) {
        [self.delegate didOperatorSuccessWithIds:@[@(self.sid)]];
    }
    [self showAlertViewWithMessage:msg withCallback:^(id x){
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
-(void)httpRequestFailed:(BaseHttpRequest*)request andFailedMsg:(NSString*)msg
{
    [self showAlertViewWithMessage:msg];
}



@end
