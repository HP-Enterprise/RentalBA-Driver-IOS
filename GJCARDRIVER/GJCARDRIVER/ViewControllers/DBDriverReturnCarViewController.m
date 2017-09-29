
//
//  DBDriverReturnCarViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/7/24.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBDriverReturnCarViewController.h"
#import "DBDatePickViewController.h"

#import "DBUserInfoManager.h"
@interface DBDriverReturnCarViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL keyboardDidShow  ;
    //记录移动的距离
    CGFloat moveLenth ;
}

//@property (nonatomic,strong)UIScrollView * mainScrillView ;
@property (nonatomic,strong)UIView * mainScrillView ;
@property (nonatomic,strong)UILabel * name ;
@property (nonatomic,strong)UILabel * phone ;
@property (nonatomic,strong)DBTextField * startTime;

@property (nonatomic,strong)DBTextField * startKind ;
@property (nonatomic,strong)UIButton * startBt ;

@property (nonatomic,strong)DBTextField * startOil;
@property (nonatomic,strong)UIButton * oilBt ;

@property (nonatomic,strong)DBTextField * startMileage;
@property (nonatomic,strong)DBTextField * startRemark;

//记录选择的类型，油量
@property (nonatomic,strong)NSString * type ;
@property (nonatomic,strong)NSString * oil ;
@property (nonatomic,strong)NSString * plate ;

@property (nonatomic,strong)NSDictionary * carInfoDic ;
//记录上次提车车型
@property (nonatomic,strong)NSDictionary * lastCarDic ;
@property (nonatomic,strong)NSArray * carArray ;

//车型选择控件
@property (nonatomic,strong)DBDatePickViewController * carTypePicker;

@property (nonatomic,strong)UITableView * vehicleList ;

@property (nonatomic,strong)UIView * tipView ;

@end

@implementation DBDriverReturnCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBase];
    [self loadData];
}



-(void)loadData{
    self.lastCarDic = [NSDictionary dictionary] ;
    [DBNewtWorkData loadDriverCarGetsuccess:^(id responseObject) {
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
          
            //@"type" 判断上一次操作  1.提车 2.还车
            
            [self setUI];
            if (![[responseObject objectForKey:@"message"]isKindOfClass:[NSNull class]]) {
                self.lastCarDic = [responseObject objectForKey:@"message"];
                
                if ([[NSString stringWithFormat:@"%@",self.lastCarDic[@"type"]]isEqualToString:@"1"]) {
                    self.plate = self.lastCarDic[@"vehiclePlate"];
                    self.startTime.field.text = self.lastCarDic[@"vehiclePlate"];
                    self.startMileage.field.text =[NSString stringWithFormat:@"%@", self.lastCarDic[@"vehicleMileage"]];
                    [self.oilBt setTitle:[NSString stringWithFormat:@"%@", self.lastCarDic[@"vehicleOil"]] forState:UIControlStateNormal];
                    [self.startBt setTitle:@"还车" forState:UIControlStateNormal];
                    self.type = @"2";

                }
            }
        }
    } failure:^(NSError *error) {
        [self tipShow:@"连接失败"];
    }];
}

-(void)setBase{
    
    
    [self setTableView];
    [self setNavigation];
    self.view.backgroundColor = [UIColor whiteColor];
}

//导航设置
-(void)setNavigation{
    
    self.title = @"提还车";
    self.navigationController.navigationBar.barTintColor = BascColor ;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    //导航栏个人信息按钮
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

-(void)setTableView{
    
    _vehicleList = [[UITableView alloc]initWithFrame:CGRectMake(_startTime.field.frame.origin.x - 15, CGRectGetMaxY(_startTime.frame) - 1, _startTime.field.frame.size.width, 300)];
    _vehicleList.delegate = self ;
    _vehicleList.dataSource = self ;
    _vehicleList.showsVerticalScrollIndicator = YES ;
    _vehicleList.showsHorizontalScrollIndicator = YES;
    _vehicleList.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    [_mainScrillView addSubview:_vehicleList];
    _vehicleList.hidden = YES ;
    _vehicleList.layer.borderWidth = 0.5 ;
    _vehicleList.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1].CGColor;

    
}

-(void)setUI{
    
    CGFloat height = 40 ;
   
    _mainScrillView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 , ScreenWidth, ScreenHeight - 64 )];
   /* _mainScrillView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight )];
    _mainScrillView.delegate = self ;
    _mainScrillView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight ) ;
    _mainScrillView.showsVerticalScrollIndicator = NO ;
    _mainScrillView.showsHorizontalScrollIndicator = NO ;
    _mainScrillView.bounces = NO ;
  */  _mainScrillView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:_mainScrillView ];
    
    
    UIView * nameView  = [[UIView alloc]initWithFrame:CGRectMake(0 , 10 , ScreenWidth, height)];
    nameView.backgroundColor = [UIColor whiteColor];
    nameView.layer.borderWidth = 0.5 ;
    nameView.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1].CGColor;
    
    [_mainScrillView addSubview:nameView];
    
    
    UILabel * driveName = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth  / 3, height)];
    driveName.text = @"司机姓名" ;
    driveName.font = [UIFont systemFontOfSize:12];
    driveName.textColor = [UIColor blackColor];
    [nameView addSubview:driveName];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(driveName.frame), 0, ScreenWidth * 2 / 3 - 15, height)];
    _name.textColor = [UIColor blackColor];
    _name.font = [UIFont systemFontOfSize:12];
    _name.text = [[DBUserInfoManager sharedManager].infoDic objectForKey:@"name"] ;
    [nameView addSubview:_name];
    
    
    
    UIView * phoneView  = [[UIView alloc]initWithFrame:CGRectMake(0 , CGRectGetMaxY(nameView.frame) + 10 , ScreenWidth, height)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.borderWidth = 0.5 ;
    phoneView.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1].CGColor;
    
    [_mainScrillView addSubview:phoneView];
    
    
    UILabel * drivePhone = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth  / 3, height)];
    drivePhone.text = @"司机电话" ;
    drivePhone.font = [UIFont systemFontOfSize:12];
    drivePhone.textColor = [UIColor blackColor];
    [phoneView addSubview:drivePhone];
    
    
    _phone = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(driveName.frame), 0, ScreenWidth * 2 / 3 - 15, height)];
    _phone.textColor = [UIColor blackColor];
    _phone.font = [UIFont systemFontOfSize:12];
    _phone.text = [[DBUserInfoManager sharedManager].infoDic objectForKey:@"phone"] ;;
    [phoneView addSubview:_phone];
    
    
    _startKind =  [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(phoneView.frame)+10, ScreenWidth, 40) withTitle:@"类型"];
    [_mainScrillView addSubview:_startKind ];
  
    _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startBt setAttrubutwithTitle:@"请选择类型" withTitleColor:[UIColor blackColor] withFont:12];
  
    [_startKind.field removeFromSuperview];
    
    
    _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startKind.frame) + 10, ScreenWidth, 40) withTitle:@"车辆牌号"];
    _startTime.field.placeholder = @"请填写车辆牌号" ;
    [_startTime.field setValue:[UIColor darkGrayColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    _startTime.field.delegate = self ;
    [_mainScrillView addSubview:_startTime];
    //添加事件
    [_startTime.field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _startBt.frame = _startKind.field.frame ;
    _startBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_startBt addTarget:self action:@selector(stateClick) forControlEvents:UIControlEventTouchUpInside];
    [_startKind addSubview:_startBt];
    
    _startOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startTime .frame)+10, ScreenWidth, 40) withTitle:@"油量"];
    [_mainScrillView addSubview:_startOil];
    _startOil.field.enabled = NO ;
    _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_oilBt setAttrubutwithTitle:@"请选择油量" withTitleColor:[UIColor blackColor] withFont:12];
    
    [_startOil.field removeFromSuperview];
    _oilBt.frame = _startOil.field.frame ;
    _oilBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_oilBt addTarget:self action:@selector(oilClick) forControlEvents:UIControlEventTouchUpInside];
    [_startOil addSubview:_oilBt];

    

    _startMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startOil.frame)+10, ScreenWidth, 40) withTitle:@"里程"];
//    _startMileage.field.enabled = NO ;
    _startMileage.field.placeholder = @"请填写公里数" ;
    [_startMileage.field setValue:[UIColor darkGrayColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    _startMileage.field.delegate = self ;

    [_mainScrillView addSubview:_startMileage];
    
    
    _startRemark = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startMileage.frame)+10, ScreenWidth, 40) withTitle:@"备注"];
    _startRemark.field.delegate = self ;
    _startRemark.field.placeholder = @"请填写备注" ;
    [_startRemark.field setValue:[UIColor darkGrayColor]
                       forKeyPath:@"_placeholderLabel.textColor"];

    [_mainScrillView addSubview:_startRemark];
    [_startRemark.field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    //提交按钮
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBt.frame = CGRectMake(50, CGRectGetMaxY(_startRemark.frame) + 30, ScreenWidth - 100 , 35);
    [submitBt setAttrubutwithTitle:@"提交" TitleColor:[UIColor whiteColor] BackColor:BascColor Font:14 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    
    [submitBt addTarget:self action:@selector(submitRecord) forControlEvents:UIControlEventTouchUpInside];
    [_mainScrillView addSubview:submitBt];

}



-(void)stateClick{
    [self.view endEditing:YES];
    NSArray * stateArray = @[@"提车",@"还车"];
    [self setCarPickerView:@"kind" withData:stateArray];
}

-(void)oilClick{
    
    [self.view endEditing:YES];
    NSArray * oilArray = @[@"1/16",@"2/16",@"3/16",@"4/16",@"5/16",@"6/16",@"7/16",@"8/16",@"9/16",@"10/16",@"11/16",@"12/16",@"13/16",@"14/16",@"15/16",@"16/16"];
    [self setCarPickerView:@"oil" withData:oilArray];

}



//设置车型选择pickerView
-(void)setCarPickerView:(NSString*)kind withData:(NSArray *)array{
    
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
        if ([kind isEqualToString:@"kind"]) {
            if ([str isEqualToString:@"提车"]) {
                weak_self.type = @"1";
            }
            else{
                weak_self.type = @"2";
                 [self judgeLastCar];
            }
            [_startBt setTitle:str forState:UIControlStateNormal];
        }
        else{

            weak_self.oil = str ;
            [_oilBt setTitle:str forState:UIControlStateNormal];
        }
        
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = weak_carTypePicker.view.frame ;
            frame = CGRectMake(0, ScreenHeight , ScreenWidth, 250 * ScreenHeight / 667);
            weak_carTypePicker.view.frame = frame ;
        } completion:^(BOOL finished) {
            [weak_carTypePicker removeFromParentViewController];
            [weak_carTypePicker.view removeFromSuperview];
        }];
    };
}

-(void)judgeLastCar{
    
    if (self.lastCarDic == nil) {
        [self loadData] ;
        return ;
    }
    
    if ([[NSString stringWithFormat:@"%@",[self.lastCarDic objectForKey:@"type"]]isEqualToString:@"1"]) {
        self.plate = [self.lastCarDic objectForKey:@"vehiclePlate"] ;
        self.startTime.field.text = [NSString stringWithFormat:@"%@",[self.lastCarDic objectForKey:@"vehiclePlate"]];
        self.startMileage.field.text = [NSString stringWithFormat:@"%@",[self.lastCarDic objectForKey:@"vehicleMileage"]];
    }
    else{
    }
}


-(void)submitRecord{
    

    if (!_startTime.field.text || _startTime.field.text.length == 0){
        [self tipShow:@"请填写车牌号"];
        return ;
    }
    if ([_startBt.titleLabel.text isEqualToString:@"请选择类型"]){
        [self tipShow:@"请选择类型"];
        return ;
    }
    if ([_oilBt.titleLabel.text isEqualToString:@"请选择油量"]){
        [self tipShow:@"请填写油量"];
        return ;
    }
    if (!_startMileage.field.text  || [_startMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请填写里程"];
        return ;
    }
    
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    waitDic[@"driverPhone"] = [[DBUserInfoManager sharedManager].infoDic objectForKey:@"phone"] ;
    waitDic[@"vehiclePlate"]= _plate ;
    waitDic[@"type"]= _type;
    waitDic[@"vehicleOil"]= _oilBt.titleLabel.text;
    waitDic[@"vehicleMileage"]= _startMileage.field.text ;
    waitDic[@"orderId"] = @"";
    
    if (!_startRemark.field.text  || _startRemark.field.text.length == 0) {
        waitDic[@"note"]= @"";
    }else{
        waitDic[@"note"]= _startRemark.field.text;
    }
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DBNewtWorkData driverReturnCarUrl:nil parameters:waitDic success:^(id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            [self tipShow:@"操作成功"];
        }
        else{
            [self tipShow:responseObject[@"message"]];

        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [self tipShow:@"连接失败"];

    }];
    
}


//检测搜索框输入的字符
-(void)textFieldDidChange:(UITextField*)textField
{
    if (textField == _startTime.field) {
        
        NSString *strUrl = [_startTime.field.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@",strUrl);
        if (strUrl.length == 0) {
            _vehicleList.hidden =YES;
            
        }else{
            [DBNewtWorkData loadCarPlateGet:strUrl success:^(id responseObject) {
                
                if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                    
                    if (![[responseObject objectForKey:@"message"]isKindOfClass:[NSNull class]]) {
                        
                        self.carArray = [responseObject objectForKey:@"message"] ;
                        [_vehicleList performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                        if (self.carArray.count>0) {
                            _vehicleList.hidden = NO ;
                        }
                        else{
                            _vehicleList.hidden =YES;
                        }
                    }
                }
            } failure:^(NSError *error) {
                
            }];
        }

    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _startTime.field) {
        moveLenth = 100 ;
    }
    else{
        moveLenth = 200 ;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carArray.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30 ;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@ / %@",[_carArray[indexPath.row] objectForKey:@"plate"],[[_carArray[indexPath.row]objectForKey:@"vehicleModelShow"]objectForKey:@"model"]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.selectionStyle = 0 ;
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.carInfoDic = self.carArray[indexPath.row];
    
    self.plate = [_carArray[indexPath.row] objectForKey:@"plate"] ;
    self.startTime.field.text = [NSString stringWithFormat:@"%@ / %@",[_carArray[indexPath.row] objectForKey:@"plate"],[[_carArray[indexPath.row]objectForKey:@"vehicleModelShow"]objectForKey:@"model"]];
    self.startMileage.field.text = [NSString stringWithFormat:@"%@",[self.carInfoDic objectForKey:@"mileage"]];
    _vehicleList.hidden = YES  ;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _mainScrillView) {
        
    }
    else{

    }
}

-(void)BackBtClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSDictionary*)carInfoDic{
    if (!_carInfoDic) {
        _carInfoDic = [NSDictionary dictionary];
    }
    return _carInfoDic ;
}

-(NSArray*)carArray{
    if(!_carArray){
        _carArray = [NSArray array];
    }
    return _carArray ;
}
- (void)tipShow:(NSString *)str
{
    
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
    
}
//键盘位置监控
- (void)keyBoardDidShow:(NSNotification *)notif {
    NSLog(@"===keyboar showed====");
    if (keyboardDidShow) return;
    //    get keyboard size
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //    CGSize keyboardSize = [aValue CGRectValue].size;
    CGPoint keyboardPoint = [aValue CGRectValue].origin;
    
    [UIView animateWithDuration:0.1 animations:^{
        CGRect viewFrame = _mainScrillView.frame ;
        
        viewFrame.origin.y -= moveLenth ;
        
        _mainScrillView.frame = viewFrame;
    }];
    
    
 //  [_mainScrillView scrollRectToVisible:_mainScrillView.frame animated:YES];
    
    keyboardDidShow = YES;

    

}

- (void)keyBoardDidHide:(NSNotification *)notif {
    NSLog(@"====keyboard hidden====");
    //    NSDictionary *info = [notif userInfo];
    //    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //    CGSize keyboardSize = [aValue CGRectValue].size;
    //    CGPoint keyboardPoint = [aValue CGRectValue].origin;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect viewFrame = _mainScrillView.frame;
        viewFrame.origin.y += moveLenth ;
        _mainScrillView.frame = viewFrame;
    }];

    
    
    if (!keyboardDidShow) {
        return;
    }
    keyboardDidShow = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
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
