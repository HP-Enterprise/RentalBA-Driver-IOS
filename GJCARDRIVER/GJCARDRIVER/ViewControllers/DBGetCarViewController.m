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

#import "DBDatePickViewController.h"

#import "DBCarModel.h"

@interface DBGetCarViewController ()
{
    UILabel * vehicleLable ;
    UILabel * stateLable ;
    
    UILabel * carInfo ;
}
@property (nonatomic,strong)NSArray * vehicleData ;
@property (nonatomic,strong)NSMutableArray * vehicleArray ;


@property (nonatomic,strong)DBCarModel * currentModel ;


@property (nonatomic,strong)DBGetCarView * getCarView ;

//车型选择控件
@property (nonatomic,strong)DBDatePickViewController * carTypePicker;

@end

@implementation DBGetCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self setBasicUI];
    [self loadAllVehicle];
    [self loadAllCars];

}

-(NSArray*)vehicleData{
    if (!_vehicleData) {
        _vehicleData = [NSArray array];
    }
    return _vehicleData ;
}
-(NSMutableArray*)vehicleArray{
    if (!_vehicleArray) {
        _vehicleArray = [NSMutableArray array];
    }
    return _vehicleArray ;
}
-(DBCarModel*)currentModel{
    if (!_currentModel) {
        _currentModel  = [[DBCarModel alloc]init];
    }
    return _currentModel ;
    
}
-(void)loadAllCars{
    
//    [self setCarListView:nil];
    
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

-(void)loadCars{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [DBNewtWorkData loadCarsWithparameters:self.currentModel withModel:self.model success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
           
            
            if (self.getCarView) {
                
                [self.getCarView reloadData:[responseObject objectForKey:@"message"]];

            }
            else{
                [self setCarListView:[responseObject objectForKey:@"message"]];
            }
            
            if ([NSArray arrayWithArray:[responseObject objectForKey:@"message"]].count > 0) {
                [carInfo removeFromSuperview];
            }
            else{
                [self showCarInfo];
            }
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


-(void)loadAllVehicle{
    
    [DBNewtWorkData loadAllVehicleWithparameters:nil success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
          
            if ([NSArray arrayWithArray:[responseObject objectForKey:@"message"]].count > 0) {
                
                self.vehicleData = [NSArray arrayWithArray:[responseObject objectForKey:@"message"]] ;
               
                for (NSDictionary * dic  in [NSArray arrayWithArray:[responseObject objectForKey:@"message"]]) {
                    [self.vehicleArray addObject:[dic objectForKey:@"model"]];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)setBasicUI{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
//    [self setCarListView:nil];
    [self setChooseBt];
}

-(void)setChooseBt{
    
    UIView * shooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 60)];
    shooseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shooseView];

    
    //车型选择
    UIView * vehicleView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth / 2 - 40, 30)];
    vehicleView.layer.borderWidth = 0.5 ;
    vehicleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [shooseView addSubview:vehicleView];
    
    vehicleLable  =[[ UILabel alloc]initWithFrame:CGRectMake(10, 0, vehicleView.frame.size.width - 20, vehicleView.frame.size.height)];
    vehicleLable.text = [NSString stringWithFormat:@"%@",self.model.modelName] ;
    vehicleLable.font = [UIFont systemFontOfSize:12];

    vehicleLable.textColor = [UIColor blackColor];
    [vehicleView addSubview:vehicleLable];
    
    
    UIImageView * vehicleImage = [[UIImageView alloc]initWithFrame:CGRectMake(vehicleView.frame.size.width - 20, 13, 7 , 4 )];
    vehicleImage.image = [UIImage imageNamed:@"more-image"];
    [vehicleView addSubview:vehicleImage];
    
    
    
    
    UIControl * vehicleControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, vehicleView.frame.size.width, vehicleView.frame.size.height)];
    [vehicleView addSubview:vehicleControl];
    [vehicleControl addTarget:self action:@selector(vehicleClick) forControlEvents:UIControlEventTouchUpInside];
    
    //状态选择
    UIView * stateView = [[UIView alloc]initWithFrame:CGRectMake(20 + ScreenWidth / 2, 20, ScreenWidth / 2 - 40, 30)];
    stateView.layer.borderWidth = 0.5 ;
    stateView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [shooseView addSubview:stateView];
    
    stateLable  =[[ UILabel alloc]initWithFrame:CGRectMake(10, 0, vehicleView.frame.size.width - 20, vehicleView.frame.size.height)];
    stateLable.text = @"全部";
    stateLable.font = [UIFont systemFontOfSize:12];
    stateLable.textColor = [UIColor blackColor];
    [stateView addSubview:stateLable];
    
    UIImageView * stateImage = [[UIImageView alloc]initWithFrame:CGRectMake(stateView.frame.size.width - 20, 13, 7 , 4 )];
    stateImage.image = [UIImage imageNamed:@"more-image"];
    [stateView addSubview:stateImage];
    
    UIControl *  stateControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, vehicleView.frame.size.width, vehicleView.frame.size.height)];
    [stateView addSubview:stateControl];
    [stateControl addTarget:self action:@selector(stateClick) forControlEvents:UIControlEventTouchUpInside];

    
    
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
    
    if (_getCarView == nil) {
       
        _getCarView = [[DBGetCarView alloc]initWithFrame:CGRectMake(0, 64 + 60, ScreenWidth, ScreenHeight - 64) withDic:dicArray];
    }
    
    
    [self.view addSubview:_getCarView];
    __weak typeof(self)weak_self = self;
    _getCarView.chooseBlock = ^(NSDictionary * dic){
        
        DBLog(@"%@",dic);
        DBReturnCarViewController * returnCar = [[DBReturnCarViewController alloc]init];
        returnCar.index = @"提车";
        returnCar.model = weak_self.model ;
        returnCar.infoddic = dic ;
        [weak_self.navigationController pushViewController:returnCar animated:YES];
    };
}


-(void)vehicleClick{
    
    NSArray * dataArray = @[@"全部"];
    
    if (self.vehicleArray.count > 0) {
    
        [self setCarPickerView:@"vehicle" withData:self.vehicleArray];
    }
    else{
        [self setCarPickerView:@"vehicle" withData:dataArray];

    }

}

-(void)stateClick{
    NSArray * stateArray = @[@"全部",@"待租赁",@"租赁中"];
    [self setCarPickerView:nil withData:stateArray];
}


//设置车型选择pickerView
-(void)setCarPickerView:(NSString*)kind withData:(NSArray *)array
{

    if (!_carTypePicker){
        _carTypePicker = [[DBDatePickViewController alloc]init];
        _carTypePicker.view.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240 * ScreenHeight / 667);
    }
    
    [_carTypePicker initWithProData:array withCityData:nil];
    
    [self addChildViewController:_carTypePicker];
    [self.view addSubview:_carTypePicker.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = _carTypePicker.view.frame ;
        frame = CGRectMake(0, ScreenHeight - 250 * ScreenHeight / 667, ScreenWidth, 250 * ScreenHeight / 667);
        _carTypePicker.view.frame = frame ;
        
    } completion:^(BOOL finished) {
    
    }];
    _carTypePicker.pickerView.frame = CGRectMake(0 , 50 * ScreenHeight / 667, ScreenWidth, 200 * ScreenHeight / 667);
    
    __weak typeof(_carTypePicker)weak_carTypePicker = _carTypePicker;
    __weak typeof(self)weak_self = self;
    weak_carTypePicker.btBlock = ^(NSString * str,NSInteger index){
        DBLog(@"%ld",index);
        if ([kind isEqualToString:@"vehicle"]) {
            self.currentModel.carModel = self.vehicleData[index] ;
            vehicleLable.text = str ;
        }
        else{
            self.currentModel.state = str ;
            stateLable.text = str ;
        }
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = weak_carTypePicker.view.frame ;
            frame = CGRectMake(0, ScreenHeight , ScreenWidth, 250 * ScreenHeight / 667);
            weak_carTypePicker.view.frame = frame ;
        } completion:^(BOOL finished) {
            [weak_carTypePicker removeFromParentViewController];
            [weak_carTypePicker.view removeFromSuperview];
        }];
        [weak_self loadCars];
    };
}

-(void)showCarInfo{
    
//    UILabel * carInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 + 60, ScreenWidth, 20)];
//    [carInfoLabel setAttrubutwithText:[NSString stringWithFormat:@"%@",self.model.modelName] withFont:13 withBackColor:nil withTextColor:[UIColor blackColor] withTextAlignment:0];
//    [self.view addSubview:carInfoLabel];
    if (!carInfo) {
        carInfo = [[UILabel alloc]initWithFrame:CGRectMake(20,64 + 60, ScreenWidth - 15, 40)];
    }
    [carInfo setAttrubutwithText:@"没有可用车辆" withFont:12 withBackColor:nil withTextColor:[UIColor blackColor] withTextAlignment:0];
    [self.view addSubview:carInfo];
}


-(void)BackBtClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
//    for (UIView * view  in self.view.subviews) {
//        [view removeFromSuperview];
//    }
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
