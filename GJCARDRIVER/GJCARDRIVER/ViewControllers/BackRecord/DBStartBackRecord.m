//
//  DBStartBackRecord.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBStartBackRecord.h"
#import "DBNewtWorkData.h"
#import "DBDatePickerView.h"
#import "DBChooseDateViewController.h"
@interface DBStartBackRecord ()<UITextFieldDelegate>

// triptype  1.接机   2送机

@property (nonatomic,strong)NSDate * startDate;
@property (nonatomic,strong)UIButton * startBt ;
@property (nonatomic,strong)UIButton * oilBt;

@property (nonatomic,strong)DBTextField * startTime;
@property (nonatomic,strong)DBTextField * startOil;
@property (nonatomic,strong)DBTextField * startMileage;
@property (nonatomic,strong)DBTextField * startAddress;

@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic,strong)NSMutableDictionary * infoDic ;
@property (nonatomic,strong)DBDatePickerView   *  pickView ;
@property (nonatomic,strong)DBPickerView * oilPickerView ;

@property (nonatomic,strong)NSDictionary * orderInfoDic ;

//@property (nonatomic,strong)NSString *  ;

@end

@implementation DBStartBackRecord

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
           self.vehicleId = [[responseObject objectForKey:@"message"]objectForKey:@"vehicleId"];
 
        }
        
        [self setUI];
        
        [self setDatePicker];
        
        [self setPickerView];

        NSLog(@"%@",responseObject);

    } failure:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}

-(void)setBasicUI{
    
    _infoDic = [NSMutableDictionary dictionary];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    

}


-(void)setNavigation{
    
    
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        self.title = @"取车回录单";
        self.navigationController.navigationBar.barTintColor = BascColor ;
        
    }
    else{
        
        self.title = @"上车回录单";
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
    NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
    [user objectForKey:@"userAddr"];
    
    
    
    //1=短租自驾；2=门到门服务；3=短租代驾; 4=接送机 ordertype
    
    //
    if ([[NSString stringWithFormat:@"%@",self.model.orderType] isEqualToString:@"4"]) {
        
//        if ([[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"tripType"]]isEqualToString:@"2"]) {
            _startAddress = [[DBTextField alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 40) withTitle:@"上车地址"];
            _startAddress.field.frame = CGRectMake(_startAddress.field.frame.origin.x, _startAddress.field.frame.origin.y, _startAddress.field.frame.size.width - 40, _startAddress.field.frame.size.height);
            
            _startAddress.field.placeholder = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
            [_startAddress.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
            _startAddress.field.delegate = self ;
            _startAddress.field.clearButtonMode = UITextFieldViewModeNever;
            [_startAddress.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
            _startAddress.field.adjustsFontSizeToFitWidth = YES ;
            _startAddress.field.text = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
            
            [self.view addSubview:_startAddress];
            
            UIButton * locationBt = [UIButton buttonWithType:UIButtonTypeCustom];
            
            locationBt.frame = CGRectMake(ScreenWidth  - 40 , 0, 30, 40);
            [locationBt setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
            [locationBt addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
            [_startAddress addSubview:locationBt];

//        }

    }
    
    
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        
        if ([[NSString stringWithFormat:@"%@",self.model.orderType] isEqualToString:@"4"] && [[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"tripType"]]isEqualToString:@"2"]) {
            _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 124, ScreenWidth, 40) withTitle:@"取车时间"];

        }
        else {
            _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 40) withTitle:@"取车时间"];

        }
        
        
        [_startTime.field removeFromSuperview];
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBt.frame = _startTime.field.frame ;

        [_startBt setAttrubutwithTitle:@"请选择取车时间" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startTime.frame)+10, ScreenWidth, 40) withTitle:@"取车油量"];
        
        _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];

        [_oilBt setAttrubutwithTitle:@"请选择取车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startOil.frame)+10, ScreenWidth, 40) withTitle:@"取车里程"];
        _startMileage.field.placeholder = @"请输入取车里程";

    }
    
    
    else{

        if ([[NSString stringWithFormat:@"%@",self.model.orderType] isEqualToString:@"4"]) {
            _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 124, ScreenWidth, 40) withTitle:@"上车时间"];
            
        }
        else {
            _startTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 40) withTitle:@"上车时间"];
            
        }
        
    
        [_startTime.field removeFromSuperview];
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBt.frame = _startTime.field.frame ;

        [_startBt setAttrubutwithTitle:dateString withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];

        _startOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_startTime.frame)+10, ScreenWidth, 40) withTitle:@"上车油量"];
        _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];

        [_oilBt setAttrubutwithTitle:@"请选择上车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _startMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startOil.frame)+10, ScreenWidth, 40) withTitle:@"上车里程"];
        _startMileage.field.placeholder = @"请输入上车里程";

    }
    
    
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
  
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        
        [_startBt setAttrubutwithTitle:@"请选择取车时间" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];

    }

    
}


//定位点击了
-(void)changeLocation{
    
    NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
    [user objectForKey:@"userAddr"];
    
    _startAddress.field.text = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
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
    _oilPickerView.chooseBlock = ^(NSString * chooseOil)
    {
        [weak_self.oilBt setTitle:chooseOil forState:UIControlStateNormal];
        [weak_self removeOilPickView];
    };
    _oilPickerView.cancelBlcok =  ^()
    {
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
    }
    else{
        
        [self tipShow:@"请完善信息"];
        return ;
    }
    
    
    
    DBNewtWorkData * netData = [[DBNewtWorkData alloc]init];
    NSLog(@"回执单  %0.f    %ld",dataInterval,[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]]integerValue]);

    if (![self.model.dispatchOrigin isEqualToString:@"1"]) {
        
        if (![self judge:dataInterval]) {
            return ;
        }
    }
    else {
        if (![self doorJudge:dataInterval]) {
            return ;
        }
    }
   
    _infoDic[@"realStartTime"] = [NSString stringWithFormat:@"%0.f",dataInterval];
    _infoDic[@"getOnMileage"] = _startMileage.field.text ;
    _infoDic[@"getOnFuel"] = _oilBt.titleLabel.text;
    _infoDic[@"id"] = self.model.id ;
    _infoDic[@"vehicleId"] = self.vehicleId ;
    
    if (_startAddress) {
        if (_startAddress.field.text) {
            _infoDic[@"onAddress"] = _startAddress.field.text;
        }
    }
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    [netData submitStartRecordPUT:nil parameters:_infoDic with:nil];
    netData.startRecordBlcok = ^(id message)
    {
        if (![message isKindOfClass:[NSError class]]) {
            
            if ([message isKindOfClass:[NSString class]]) {
                
                [self tipShow:message];
            }
            
            if ([message isKindOfClass:[NSDictionary class]]) {
                if ([[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"status"]isEqualToString:@"true"]) {
                    [self tipShow:@"上车提交成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
                else{
                    [self tipShow:@"提交失败"];
                }
            }
        }
    };


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
    NSString * takeDate ;
    NSDate  * date ;
    
//    if ([[self.orderInfoDic allKeys]containsObject:@"driverTakeCarMileage"]) {
//        takeCarMileage =[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"driverTakeCarMileage"]];
//
//    }
    
    if ([[self.orderInfoDic allKeys]containsObject:@"driverTakeCarDate"]){
        
        if (![[self.orderInfoDic objectForKey:@"driverTakeCarDate"]isKindOfClass:[NSNull class]]) {
            takeDate = [NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"driverTakeCarDate"]] ;
            
            date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"driverTakeCarDate"]]integerValue]/1000];
        }
    }
    else{
        if (![[self.orderInfoDic objectForKey:@"takeCarActualDate"]isKindOfClass:[NSNull class]]){
            takeDate =  [NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]];
            date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"takeCarActualDate"]]integerValue]/1000];
        }
    }
    
//    NSArray *array = [[self.orderInfoDic objectForKey:@"takeCarFuel"] componentsSeparatedByString:@"/"];
//    NSInteger takefuel = [[array firstObject]integerValue];
//    NSArray * nowFuelArray  = [self.oilBt.titleLabel.text componentsSeparatedByString:@"/"];
//    NSInteger nowFuel = [[nowFuelArray firstObject]integerValue];
    
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
    else if (dataInterval <= [takeDate integerValue]){
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
        NSString *  dateString = [formatter stringFromDate:date];
        
        [self tipShow:[NSString stringWithFormat:@"时间不能早于%@",dateString]];
        return NO;
    }
    else if ( !self.startMileage.field.text ){
         [self tipShow:@"请填写正确里程"];
        return NO;
    }
    else if ([self.startMileage.field.text integerValue] <=  [takeCarMileage integerValue]){
        [self tipShow:[NSString stringWithFormat:@"里程数应大于%@",takeCarMileage]];
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

- (void)tipShow:(NSString *)str{
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
     [_pickView removeFromSuperview];
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
