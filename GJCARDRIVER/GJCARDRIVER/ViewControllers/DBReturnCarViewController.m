//
//  DBReturnCarViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/16.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBReturnCarViewController.h"


#import "DBOrderController.h"

#import "DBNewtWorkData.h"
#import "DBDatePickerView.h"
#import "DBChooseDateViewController.h"
@interface DBReturnCarViewController ()<UITextFieldDelegate>


@property (nonatomic,strong)NSDate * startDate;
@property (nonatomic,strong)UIButton * startBt ;
@property (nonatomic,strong)UIButton * oilBt;

@property (nonatomic,strong)UILabel * carInfoLabel ;
@property (nonatomic,strong)DBTextField * startTime;
@property (nonatomic,strong)DBTextField * startOil;
@property (nonatomic,strong)DBTextField * startMileage;
@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic,strong)NSMutableDictionary * infoDic ;
@property (nonatomic,strong)DBDatePickerView   *  pickView ;
@property (nonatomic,strong)DBPickerView * oilPickerView ;

@property (nonatomic,strong)NSDictionary * orderInfoDic ;

//@property (nonatomic,strong)NSString *  ;

@end


@implementation DBReturnCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBasicUI];
    
    [self loadData];
}

-(void)loadData{
    
    [DBNewtWorkData orderIdGet:nil parameters:self.model success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            self.orderInfoDic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"message"]];
            [self setUI];
        }
        else{
            [self tipShow:@"没有相关数据"];
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self tipShow:@"连接失败"];
    }];
}

-(void)setBasicUI{
    
    _infoDic = [NSMutableDictionary dictionary];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
    [self setDatePicker];
    
    [self setPickerView];
}


-(void)setNavigation{
    
    if ([self.index isEqualToString:@"提车"]) {
        self.title = @"提车信息";
        self.navigationController.navigationBar.barTintColor = BascColor ;
    }
    else{
        self.title = @"还车信息";
        self.navigationController.navigationBar.barTintColor = BascColor ;
    }
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

-(void)setUI{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSString *  dateString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",dateString);
    
    
    self.startDate = [NSDate date];

    _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([self.index isEqualToString:@"提车"]){
        
        _carInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 70, ScreenWidth, 30)];
        
        [_carInfoLabel setAttrubutwithText:[NSString stringWithFormat:@"车牌号 ：%@",[self.infoddic objectForKey:@"plate"]] withFont:12 withBackColor:nil withTextColor:[UIColor blackColor]  withTextAlignment:0];
        [self.view addSubview:_carInfoLabel];

        
        _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0,100, ScreenWidth, 40) withTitle:@"提车时间"];
        [_startBt setAttrubutwithTitle:dateString withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startTime.frame)+10, ScreenWidth, 40) withTitle:@"提车油量"];
        
        [_oilBt setAttrubutwithTitle:@"请选择提车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startOil.frame)+10, ScreenWidth, 40) withTitle:@"提车里程"];
        
        
        _startMileage.field.placeholder =  @"请输入提车里程";
//        _startMileage.field.placeholder = [NSString stringWithFormat:@"当前里程%@公里",[self.infoddic objectForKey:@"mileage"]];

    }
    
    else{
        
        _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, 40) withTitle:@"还车时间"];
        [_startBt setAttrubutwithTitle:dateString withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startTime.frame)+10, ScreenWidth, 40) withTitle:@"还车油量"];
        
        [_oilBt setAttrubutwithTitle:@"请选择还车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startOil.frame)+10, ScreenWidth, 40) withTitle:@"还车里程"];
        _startMileage.field.placeholder = @"请输入还车里程";

    }

    [_startTime.field removeFromSuperview];
    _startBt.frame = _startTime.field.frame ;

    
       //    _startTime.field.placeholder = @"2016/01/08 10:00";
    //    [_startTime.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_startTime.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    //
    
    
    _startBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_startBt addTarget:self action:@selector(showPickView) forControlEvents:UIControlEventTouchUpInside];
    [_startTime addSubview:_startBt];
    
    [self.view addSubview:_startTime];
    //       _startOil.field.placeholder = @"1/16";
    //    [_startOil.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    _oilBt.frame = _startTime.field.frame ;
    
    //    [_oilBt setAttrubutwithTitle:@"请选择上车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
    _oilBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_oilBt addTarget:self action:@selector(showOilPickView) forControlEvents:UIControlEventTouchUpInside];
    [_startOil addSubview:_oilBt];
    
    
    //    [_startOil.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_startOil];
    
    [_startOil.field removeFromSuperview];
    
    
    
    
    
    [_startMileage.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]
                       forKeyPath:@"_placeholderLabel.textColor"];
    _startMileage.field.delegate = self ;
    _startMileage.field.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] ;
    [_startMileage.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_startMileage];
    
    //提交按钮
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBt.frame = CGRectMake(50, CGRectGetMaxY(_startMileage.frame)+60, ScreenWidth - 100 , 35);
    [submitBt setAttrubutwithTitle:@"提交" TitleColor:[UIColor whiteColor] BackColor:BascColor Font:14 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    
    [submitBt addTarget:self action:@selector(submitRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBt];
    
    
    if ([self.index isEqualToString:@"提车"]) {
        
        [_startBt setAttrubutwithTitle:dateString withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
    }
    
    else{
        [_startBt setAttrubutwithTitle:dateString withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
    }

}

-(void)setDatePicker{
    _pickView = [[DBDatePickerView alloc]initWithFrame:CGRectMake( 0,  ScreenHeight, ScreenWidth, 230)];
    [self.view addSubview:_pickView];
    __weak typeof(self)weak_self = self;
    _pickView.cancelDateBlcok=^(){
        [weak_self removePickView] ;
    };
    
    _pickView.chooseDateBlock= ^(NSDate * date){
        DBLog(@"%@",date);
        [weak_self removePickView] ;
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
        NSString *  dateString = [formatter stringFromDate:date];
        [weak_self.startBt setTitle:dateString forState:UIControlStateNormal];
        weak_self.startDate = date ;
        
    };
    
}
-(void)showPickView{
    
    [self removeOilPickView];
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect newFrame = _pickView.frame ;
        newFrame.origin.y = ScreenHeight - 230 ;
        _pickView.frame = newFrame;
        
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)removePickView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect newFrame = _pickView.frame ;
        newFrame.origin.y = ScreenHeight ;
        _pickView.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)setPickerView{
    
    NSArray * oilArray = @[@"1/16",@"2/16",@"3/16",@"4/16",@"5/16",@"6/16",@"7/16",@"8/16",@"9/16",@"10/16",@"11/16",@"12/16",@"13/16",@"14/16",@"15/16",@"16/16"];
    _oilPickerView = [[DBPickerView alloc]initWithFrame:CGRectMake( 0,  ScreenHeight, ScreenWidth, 230) withData:oilArray];
    [self.view addSubview:_oilPickerView];
    
    __weak typeof(self)weak_self = self ;
    _oilPickerView.chooseBlock = ^(NSString * chooseOil){
        [weak_self.oilBt setTitle:chooseOil forState:UIControlStateNormal];
        [weak_self removeOilPickView];
    };
    _oilPickerView.cancelBlcok =  ^(){
        [weak_self removeOilPickView];
    };
}

-(void)showOilPickView{
    
    [self removePickView];
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect newFrame = _oilPickerView.frame ;
        newFrame.origin.y = ScreenHeight - 230 ;
        _oilPickerView.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)removeOilPickView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect newFrame = _oilPickerView.frame ;
        newFrame.origin.y = ScreenHeight ;
        _oilPickerView.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [self removeOilPickView];
    [self removePickView];
    
    return YES;
}



-(void)submitRecord{
    
    [self.tipView removeFromSuperview];
    DBLog(@"上车回执单提交");
    NSTimeInterval dataInterval;
    if (self.startDate) {
        dataInterval=[self.startDate timeIntervalSince1970]*1000;
        
        if (dataInterval <= [[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientDownDate"]]integerValue]){
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
            NSDate  * date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientDownDate"]]integerValue]/1000];
            NSString *  dateString = [formatter stringFromDate:date];
            [self tipShow:[NSString stringWithFormat:@"时间不能早于%@",dateString]];
            return ;
        }
    }
    else{
        [self tipShow:@"请完善信息"];
        return ;
    }
    
    if (!_startMileage.field.text || [_startMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请完善信息"];
        return ;
    }
    
    if ([self.index isEqualToString:@"提车"]){
        if ([_startMileage.field.text integerValue] <= [[self.infoddic objectForKey:@"mileage"]integerValue]){
            [self tipShow:[NSString stringWithFormat:@"提车里程数应大于%@",[self.infoddic objectForKey:@"mileage"]]];
            return ;
        }
    }
    else{
        if ([_startMileage.field.text integerValue] <= [[self.orderInfoDic objectForKey:@"clientDownMileage"]integerValue]){
            [self tipShow:[NSString stringWithFormat:@"还车里程数应大于%@",[self.orderInfoDic objectForKey:@"clientDownMileage"]]];
            return ;
        }
    }
    if ([_oilBt.titleLabel.text isEqualToString:@"请选择提车油量"]|| [_oilBt.titleLabel.text isEqualToString:@"请选择还车油量"]){
        [self tipShow:@"请完善信息"];
        return ;
    }
    DBNewtWorkData * netData = [[DBNewtWorkData alloc]init];
//    NSLog(@"回执单  %0.f    %ld",dataInterval,[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]]integerValue]);

    if ([self.index isEqualToString:@"提车"]) {
        _infoDic[@"modelId"] = [self.infoddic objectForKey:@"modelId"];
        _infoDic[@"vehicleId"] = [[self.infoddic objectForKey:@"vehicleIdShow"]objectForKey:@"id"];
    }
    _infoDic[@"realStartTime"] = [NSString stringWithFormat:@"%0.f",dataInterval];
    _infoDic[@"getOnMileage"] = _startMileage.field.text ;
    _infoDic[@"getOnFuel"] = _oilBt.titleLabel.text;
    _infoDic[@"orderCode"] = _model.orderCode;
    
    NSString * type ;
    if ([self.model.orderType isEqualToString:@"3"]) {
        type = @"driverContract";
    }
    else if([self.model.orderType isEqualToString:@"4"]){
        type = @"airContract";
    }

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    if ([self.index isEqualToString:@"提车"]) {
        [DBNewtWorkData allocateCarUrl:type parameters:_infoDic success:^(id responseObject) {
            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                [self tipShow:@"提车成功"];
                
                for (UIViewController  * control in self.navigationController.viewControllers) {
                    
                    if ([control isKindOfClass:[DBOrderController class]]) {
                        [self.navigationController popToViewController:control animated:YES];
                    }
                }
            }
            else{
                [self tipShow:[responseObject objectForKey:@"message"]];
            }

        } failure:^(NSError *error) {
            [self tipShow:@"连接失败"];
        }];
    }
    else{
        [DBNewtWorkData returnCarUrl:type parameters:_infoDic success:^(id responseObject) {
            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                [self tipShow:@"还车成功"];
                self.returnCar();
                for (UIViewController  * control in self.navigationController.viewControllers) {
                    
                    if ([control isKindOfClass:[DBOrderController class]]) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }
                }
            }
            else{
                [self tipShow:[responseObject objectForKey:@"message"]];
            }
        } failure:^(NSError *error) {
            [self tipShow:@"连接失败"];
        }];
    }
}
-(BOOL)judge:(NSTimeInterval)dataInterval{
    
    
    [self.tipView removeFromSuperview];
    
    if (!self.orderInfoDic) {
        if ([[self.orderInfoDic objectForKey:@"takeCarFuel"]isKindOfClass:[NSNull class]]) {
            [self tipShow:@"数据加载失败"];
            [self loadData];
            return NO;
        }
        
    }
    
    
    NSString * takeCarMileage =[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarMileage"]];
    
    NSArray *array = [[self.orderInfoDic objectForKey:@"takeCarFuel"] componentsSeparatedByString:@"/"];
    NSInteger takefuel = [[array firstObject]integerValue];
    
    NSArray * nowFuelArray  = [self.oilBt.titleLabel.text componentsSeparatedByString:@"/"];
    NSInteger nowFuel = [[nowFuelArray firstObject]integerValue];
    
    
    if (!dataInterval) {
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (!_startMileage.field.text || [_startMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if ([_oilBt.titleLabel.text isEqualToString:@"请选择上车油量"]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (dataInterval < [[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]]integerValue]){
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
        NSDate  * date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]]integerValue]/1000];
        NSString *  dateString = [formatter stringFromDate:date];
        
        [self tipShow:[NSString stringWithFormat:@"时间不能早于%@",dateString]];
        return NO;
    }
    else if ( !self.startMileage.field.text ){
        [self tipShow:@"请填写正确里程"];
        return NO;
    }
    else if ([self.startMileage.field.text integerValue] <  [takeCarMileage integerValue]){
        [self tipShow:[NSString stringWithFormat:@"里程应大于%@",takeCarMileage]];
        return NO;
    }
    
    
    return YES ;
}

-(BOOL)doorJudge:(NSTimeInterval)dataInterval{
    if (!dataInterval) {
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (!_startMileage.field.text || [_startMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if ([_oilBt.titleLabel.text isEqualToString:@"请选择取车油量"]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    return YES ;
    
}

//没有加载vehicleId时重新加载

-(void)loadVehicleId{
    
    DBNewtWorkData * netData = [[DBNewtWorkData alloc]init];
    
    [DBNewtWorkData orderIdGet:nil parameters:self.model success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            if ([[[responseObject objectForKey:@"message"]objectForKey:@"vehicleId"] isKindOfClass:[NSNull class]] || [[responseObject objectForKey:@"message"]objectForKey:@"vehicleId"] == nil) {
                [self tipShow:@"合同生成中"];
            }
            else{
                
                self.vehicleId = [[responseObject objectForKey:@"message"]objectForKey:@"vehicleId"];
                _infoDic[@"vehicleId"] = self.vehicleId ;
                
                [netData submitStartRecordPUT:nil parameters:_infoDic with:self.model];
                
                netData.startRecordBlcok = ^(id message){
                    
                    if (![message isKindOfClass:[NSError class]]) {
                        
                        [self tipShow:[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"message"]];
                        
                        if ([[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"status"]isEqualToString:@"true"]) {
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.navigationController popViewControllerAnimated:YES];
                            });
                            
                        }
                    }
                    if (![message isEqualToString:@"加载失败"]) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                };
                
            }
            
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//设置文本框只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容

    if (textField == _startMileage.field) {
        
        if (toBeString.length > 9) {
            return  NO ;
        }
        return [self validateNumber:string];

    }
    return YES ;
}

- (BOOL)validateNumber:(NSString*)number {
    
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)tipShow:(NSString *)str
{
    
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_pickView removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
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
