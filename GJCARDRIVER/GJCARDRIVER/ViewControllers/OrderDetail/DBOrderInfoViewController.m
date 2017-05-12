
//
//  DBOrderInfoViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBOrderInfoViewController.h"
#import "DBOrderInfoView.h"
@interface DBOrderInfoViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong)UIScrollView * detailScrollView ;

@property (nonatomic,strong)DBOrderInfoView * orderView ;

@end

@implementation DBOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBasicUI];
    
    [self loadData];
}

-(void)loadData{
    

    [DBNewtWorkData orderInfoGet:nil parameters:self.model success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            [self setUI:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)setBasicUI{
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
    
}

-(void)setNavigation{
    
    self.title = @"订单详情";
    self.navigationController.navigationBar.barTintColor = BascColor ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self leftBarButtonItem]];
    
    
}

//返回按钮
-(UIButton*)leftBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(20, 8, 30, 28);
    [userButton setAttrubutwithTitle:@"返回" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(BackBtClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}
-(void)BackBtClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUI:(NSDictionary*)dic{
    
    
//    [self setScrollView];
    
    _orderView = [[DBOrderInfoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) withData:dic withOder:nil withModel:self.model];
    [self.view addSubview:_orderView];
    
}

-(void)setScrollView{
    
    _detailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _detailScrollView.backgroundColor  = [UIColor whiteColor];
    _detailScrollView.showsVerticalScrollIndicator = NO;
    _detailScrollView.showsHorizontalScrollIndicator = NO ;
    _detailScrollView.delegate =self ;
    [self.view addSubview:_detailScrollView ];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
