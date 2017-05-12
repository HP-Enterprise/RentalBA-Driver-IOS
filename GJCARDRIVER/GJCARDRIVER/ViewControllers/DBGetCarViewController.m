//
//  DBGetCarViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBGetCarViewController.h"
#import "DBGetCarView.h" 

#import "DBReturnCarViewController.h"

@interface DBGetCarViewController ()

@property (nonatomic,strong)DBGetCarView * getCarView ;

@end

@implementation DBGetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    
    [self setBasicUI];

}

-(void)loadData{
    
    
    [DBNewtWorkData loadAllCarsWithparameters:self.model success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            if ([NSArray arrayWithArray:[responseObject objectForKey:@"message"]].count > 0) {
               [self setCarListView:[responseObject objectForKey:@"message"]];
            }
            else{
                [self showCarInfo];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setBasicUI{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
//    [self setCarListView:nil];

}

-(void)setNavigation{

    self.title = @"分配车辆";
    self.navigationController.navigationBar.barTintColor = BascColor ;

    
    
    //导航栏搜索按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self rightBarButtonItem]];
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

-(UIButton*)rightBarButtonItem{
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(20, 12, 60, 20);
    [searchButton setTitle:@"修改车辆" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(changeCar) forControlEvents:UIControlEventTouchUpInside];
    return searchButton ;
}


-(void)changeCar{
    
    
    
    
}

-(void)setCarListView:(NSArray*)dicArray{
    
    _getCarView = [[DBGetCarView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) withDic:dicArray];
    [self.view addSubview:_getCarView];
    
    _getCarView.chooseBlock = ^(NSDictionary * dic){
        
        DBLog(@"%@",dic);
        
        DBReturnCarViewController * returnCar = [[DBReturnCarViewController alloc]init];
        returnCar.index = @"提车";
        returnCar.model = self.model ;
        returnCar.infoddic = dic ;
        [self.navigationController pushViewController:returnCar animated:YES];
    };
}


-(void)showCarInfo{
    
    UILabel * carInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 64, ScreenWidth - 15, 40)];
    [carInfoLabel setAttrubutwithText:[NSString stringWithFormat:@"%@",self.model.modelName] withFont:13 withBackColor:nil withTextColor:[UIColor blackColor] withTextAlignment:0];
    [self.view addSubview:carInfoLabel];
    
    UILabel * carInfo = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(carInfoLabel.frame), ScreenWidth - 15, 40)];
    [carInfo setAttrubutwithText:@"没有可用车辆" withFont:12 withBackColor:nil withTextColor:[UIColor blackColor] withTextAlignment:0];
    [self.view addSubview:carInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
    [self loadData];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    for (UIView * view  in self.view.subviews) {
        [view removeFromSuperview];
    }
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
