//
//  MineSupplyInfoViewController.m
//  CrazeMM
//
//  Created by saix on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSupplyInfoViewController.h"
#import "TimeLineViewControl.h"
#import "HttpMineSupply.h"

@interface MineSupplyInfoViewController ()
@property (nonatomic) NSInteger sid;
@property (nonatomic, strong) MineSupplyDetailDTO* supplyDetailDto;
@property (nonatomic, strong) TimeLineViewControl *timeline;
@property (nonatomic, strong) UIScrollView* scrollView;
@end

@implementation MineSupplyInfoViewController

-(instancetype)initWithId:(NSUInteger)sid
{
    self = [super init];
    if (self) {
        self.sid = sid;
    }
    return self;
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    HttpMineStockDetailRequest* request = [[HttpMineStockDetailRequest alloc]initWithId:self.sid];
    
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpMineStockDetailResponse * response = (HttpMineStockDetailResponse*)request.response;
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

@end
