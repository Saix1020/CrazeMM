//
//  MortgageRefundViewController.m
//  CrazeMM
//
//  Created by Mao Mao on 16/9/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageRefundViewController.h"

@interface MortgageRefundViewController ()

@property (nonatomic, strong) UIView* buttomView;
@property (nonatomic, strong) UIButton* payButton;
@property (nonatomic, strong) NSMutableArray* selectedDtos;

@end

@implementation MortgageRefundViewController

-(instancetype)initWithDtos:(NSMutableArray *)selectedDtos
{
    self =[super init];
    
    if (self)
    {
        self.selectedDtos = [selectedDtos mutableCopy];
    }
    
    return self;
}

-(UIView*)buttomView
{
    if(!_buttomView){
        _buttomView = [[UIView alloc] init];
        [self.view addSubview:_buttomView];
        _buttomView.backgroundColor = [UIColor clearColor];
    }
    
    return _buttomView;
}


-(UIButton*)payButton
{
    if (!_payButton)
    {
        _payButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_payButton setTitle:@"确认付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _payButton.layer.cornerRadius = 0;
        [_payButton setBackgroundColor:[UIColor redColor]];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [self.buttomView addSubview:_payButton];
        
        /*
        @weakify(self);
        self.payButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal*(id x){
            
            @strongify(self);
            
            NSLog(@"need to call pay methods here");
            return [RACSignal empty];
        }];
         */
        
    }
    return _payButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"抵押还款";
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
        @weakify(self)
        self.navigationItem.leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
        
    }
    
    self.view.backgroundColor = [UIColor light_Gray_Color];
    

    
    // Do any additional setup after loading the view.
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
     self.buttomView.frame = CGRectMake(0, self.view.bounds.size.height-70, self.view.bounds.size.width, 70);
    self.payButton.frame = CGRectMake(0, 20, self.view.bounds.size.width, 50);
}

-(void)dealloc
{
    NSLog(@"dealloc %@", [self class]);
}
@end
