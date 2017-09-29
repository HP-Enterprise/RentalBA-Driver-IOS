//
//  DBUserCentreController.m
//  SelfRental
//
//  Created by 段博 on 2017/2/21.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBUserCentreController.h"
#import "DBUserInfoManager.h"
#import "DBUserInfoView.h"
#import "DBNetManager.h"


#import "DBDriverReturnCarViewController.h"



@interface DBUserCentreController ()


@property (nonatomic,strong)DBUserInfoView * userView;
@property (nonatomic,strong)UIView * tipView ;




@end

@implementation DBUserCentreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBase];
     self.view.backgroundColor = [UIColor whiteColor];
   
    
}


-(void)setBase{
    
    [self setUI];
    [self setNavigation];
}

//导航设置
-(void)setNavigation{
    
    self.title = @"个人信息";
    self.navigationController.navigationBar.barTintColor = BascColor ;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    //导航栏个人信息按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self leftBarButtonItem]];
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self rightBarButtonItem]];
    
}

//返回按钮
-(UIButton*)leftBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(20, 8, 30, 28);
    [userButton setAttrubutwithTitle:@"返回" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(BackBtClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}

//还车按钮
-(UIButton*)rightBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(ScreenWidth - 70, 8, 50, 28);
    [userButton setAttrubutwithTitle:@"提还车" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(ReturnCar) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}

-(void)setUI{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * infoDic;
    if ([user objectForKey:@"userInfo"]) {
        infoDic  = [user objectForKey:@"userInfo"] ;
    }
    _userView = [[DBUserInfoView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight- 64) withDic:[DBUserInfoManager sharedManager].infoDic withModel:nil];
    [self.view addSubview:_userView];

    __weak typeof(self)weak_self = self ;
    _userView.deletBtBlock = ^(){
        [weak_self.navigationController popToRootViewControllerAnimated:YES];
    };
    
//    [[DBUserInfoManager sharedManager]checkLogIn];
    //                [[NSNotificationCenter defaultCenter]postNotificationName:@"reset" object:nil];
}
-(void)ReturnCar{
    DBDriverReturnCarViewController * returncar = [[DBDriverReturnCarViewController alloc]init];
    [self.navigationController pushViewController:returncar animated:YES];

}

-(void)BackBtClick{
    
    [self.navigationController popViewControllerAnimated:YES];
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
