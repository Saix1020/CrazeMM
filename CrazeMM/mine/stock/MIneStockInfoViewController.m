//
//  MIneStockInfoViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MIneStockInfoViewController.h"
#import "HttpStock.h"

@interface MIneStockInfoViewController ()

@property (nonatomic) NSInteger stockId;

@property (nonatomic, strong) StockDetailDTO* stockDto;

@property (nonatomic, strong) TimeLineViewControl *timeline;

@property (nonatomic, strong) UIScrollView* scrollView;

@end

@implementation MIneStockInfoViewController

-(instancetype)initWithId:(NSUInteger)stockId
{
    self = [super init];
    if (self)
    {
        self.stockId = stockId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"库存%ld详情", self.stockId];

    
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
    [self getStockInfo];
    
    self.scrollView.backgroundColor = [UIColor UIColorFromRGB:0xF0F0F0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getStockInfo];
    [super viewWillAppear:animated];
    
}

-(void)deplayTimeLine: (NSArray*)logs
{
    logs = [logs sortedArrayUsingComparator:^NSComparisonResult(StockLogDTO* obj1, StockLogDTO* obj2){
        return [obj2.createTime localizedCompare:obj1.createTime];
    }];
    
    [self.timeline removeFromSuperview];
    
    NSMutableArray* timesPlacehoderArray = [[NSMutableArray alloc] init];
    NSMutableArray* commentsArray = [[NSMutableArray alloc] init];
    
    for (StockLogDTO* logDto in logs) {
        [timesPlacehoderArray addObject:@""];
        [commentsArray addObject:[NSString stringWithFormat:@"%@\n%@", logDto.content, logDto.createTime]];
    }
    
    self.timeline = [[TimeLineViewControl alloc] initWithTimeArray:timesPlacehoderArray
                                           andTimeDescriptionArray:commentsArray
                                                  andCurrentStatus:1
                                                          andFrame:CGRectMake(-40, 16+20.f, self.view.bounds.size.width*0.8 , self.view.bounds.size.height+40.f)];
    [self.scrollView addSubview:self.timeline];
    [self.timeline sizeToFit];

}

- (AnyPromise*)getStockInfo
{
     HttpStockDetailRequest* request = [[HttpStockDetailRequest alloc]initWithId:self.stockId];
    
    return [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
        HttpStockDetailResponse * response = (HttpStockDetailResponse*)request.response;
        if (response.ok) {
            self.stockDto = response.stockDto;
            [self deplayTimeLine:self.stockDto.logs];
            }
            
        else{
            [self showAlertViewWithMessage:response.errorMsg];
        }
    })
    .catch(^(NSError* error){
        [self showAlertViewWithMessage:error.localizedDescription];
        
    });

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
