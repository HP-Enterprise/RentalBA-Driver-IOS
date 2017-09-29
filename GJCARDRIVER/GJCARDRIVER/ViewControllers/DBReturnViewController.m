//
//  DBReturnViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/7/7.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBReturnViewController.h"
#import "DBEndBackRecord.h"
#import "DBDatePickerView.h"
@interface DBReturnViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSDate * startDate;
@property (nonatomic,strong)UIButton * startBt ;
@property (nonatomic,strong)UIButton * oilBt;
@property (nonatomic)BOOL returnCar ;


@property (nonatomic,strong)DBTextField * endAddr;
@property (nonatomic,strong)DBTextField * endTime;
@property (nonatomic,strong)DBTextField * endOil;
@property (nonatomic,strong)DBTextField * endMileage;
@property (nonatomic,strong)DBTextField * recipientName;
@property (nonatomic,strong)NSMutableDictionary * infoDic ;

@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic,strong)DBDatePickerView   *  pickView ;
@property (nonatomic,strong)DBPickerView * oilPickerView ;

@property (nonatomic,strong)NSDictionary * orderInfoDic ;

@end


@implementation DBReturnViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self loadData];
}

-(void)loadData{
    
    
    [DBNewtWorkData orderIdGet:nil parameters:self.model success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            self.orderInfoDic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"message"]];
            [self setBasicUI];
        }
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)setBasicUI{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    
    
    [self setUI];
    
    
    [self setDatePicker];
    
    [self setPickerView];
    
    _returnCar = YES ;
    _infoDic = [NSMutableDictionary dictionary];
    
    if ([[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"orderState"]]  isEqualToString:@"3"]) {
        self.title = @"客户取车";
    }
    else{
        self.title = @"门店还车";
    }
}


-(void)setNavigation{
    
    self.title = @"还车";
    self.view.backgroundColor = [UIColor whiteColor];
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

-(void)setUI{
    
    [self.view addSubview:_endTime];
    
    /*
     
     city",@"streetName",@"address",@"location
     
     */
    
    
    NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
    [user objectForKey:@"userAddr"];
    
    
    _endAddr = [[DBTextField alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 40) withTitle:@"下车地址"];
    _endAddr.field.frame = CGRectMake(_endAddr.field.frame.origin.x, _endAddr.field.frame.origin.y, _endAddr.field.frame.size.width - 40, _endAddr.field.frame.size.height);
    
    _endAddr.field.placeholder = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
    [_endAddr.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _endAddr.field.delegate = self ;
    _endAddr.field.clearButtonMode = UITextFieldViewModeNever;
    [_endAddr.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    _endAddr.field.adjustsFontSizeToFitWidth = YES ;
    _endAddr.field.text = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
    
    
    [self.view addSubview:_endAddr];
    
    UIButton * locationBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    locationBt.frame = CGRectMake(ScreenWidth  - 40 , 0, 30, 40);
    [locationBt setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locationBt addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    [_endAddr addSubview:locationBt];
    
    
    
    
    
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        
        _endTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 124, ScreenWidth, 40) withTitle:@"送车时间"];
        [self.view addSubview:_endTime];
        [_endTime.field removeFromSuperview];
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_startBt setAttrubutwithTitle:@"请选择送车时间" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _endOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_endTime.frame)+10, ScreenWidth, 40) withTitle:@"送车油量"];
        _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_oilBt setAttrubutwithTitle:@"请选择送车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _endMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endOil.frame)+10, ScreenWidth, 40) withTitle:@"送车里程"];
        _endMileage.field.placeholder = @"请输入送车里程";
        
    }
    
    else{
        
        _endTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 124, ScreenWidth, 40) withTitle:@"下车时间"];
        //    _endTime.field.placeholder = @"2016/01/08 10:00";
        //    [_endTime.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
        //    [_endTime.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        [_endTime.field removeFromSuperview];
        [self.view addSubview:_endTime];
        _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBt setAttrubutwithTitle:@"选择下车时间" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _endOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_endTime.frame)+10, ScreenWidth, 40) withTitle:@"下车油量"];
        [_oilBt setAttrubutwithTitle:@"请选择下车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
        
        _endMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endOil.frame)+10, ScreenWidth, 40) withTitle:@"下车里程"];
        _endMileage.field.placeholder = @"请输入下车里程";
    }
    
    UIView * isReturnVview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endMileage.frame)+10, ScreenWidth, 40)];
    isReturnVview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:isReturnVview];
    
    UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    topLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1];
    [isReturnVview addSubview:topLine];
    
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, ScreenWidth, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1];
    [isReturnVview addSubview:bottomLine];
    
    
    UILabel * isreturnLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth / 2, 40)];
    [isreturnLabel setAttrubutwithText:@"是否还车" withFont:12 withBackColor:nil withTextColor:nil withTextAlignment:0];
    [isReturnVview addSubview:isreturnLabel];
    
    
    //    选择开关
    UISwitch * invoiceSwitch = [[UISwitch alloc]initWithFrame:CGRectMake( ScreenWidth - 60 ,5, 51, 20)];
    
    invoiceSwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
    invoiceSwitch.onTintColor = [UIColor colorWithRed:0.95 green:0.78 blue:0.11 alpha:1];
    
    [isReturnVview addSubview:invoiceSwitch];
    [invoiceSwitch addTarget:self action:@selector(switchIsOn:) forControlEvents:UIControlEventValueChanged];
    [invoiceSwitch setOn:YES animated:NO] ;
    
    
    
    
    
    
    
    _startBt.frame = _endTime.field.frame ;
    
    _startBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_startBt addTarget:self action:@selector(showPickView) forControlEvents:UIControlEventTouchUpInside];
    [_endTime addSubview:_startBt];
    
    _oilBt.frame = _endTime.field.frame ;
    
    
    _oilBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_oilBt addTarget:self action:@selector(showOilPickView) forControlEvents:UIControlEventTouchUpInside];
    [_endOil addSubview:_oilBt];
    
    
    
    
    //    [_startOil.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_endOil];
    
    [_endOil.field removeFromSuperview];
    //    _endOil.field.placeholder = @"1/16";
    //    [_endOil.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_endOil.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    //    [self.view addSubview:_endOil];
    //
    
    [_endMileage.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _endMileage.field.delegate = self ;
    _endMileage.field.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] ;
    
    [_endMileage.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_endMileage];
    
    
    
    
    _recipientName = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endMileage.frame)+10, ScreenWidth, 40) withTitle:@"接收人姓名"];
    _recipientName.field.placeholder = @"请输入接收人姓名";
    [_recipientName.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _recipientName.field.delegate = self ;
    [_recipientName.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    
    
    
    
    //提交按钮
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBt.frame = CGRectMake(50, CGRectGetMaxY(isReturnVview.frame)+60, ScreenWidth - 100 , 35);
    [submitBt setAttrubutwithTitle:@"提交" TitleColor:[UIColor whiteColor] BackColor:BascColor Font:14 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    
    [submitBt addTarget:self action:@selector(submitRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBt];
    
    
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        
        [self.view addSubview:_recipientName];
        submitBt.frame = CGRectMake(50, CGRectGetMaxY(_recipientName.frame)+60, ScreenWidth - 100 , 35);
        
        
    }
    
    
}

-(void)switchIsOn:(UISwitch*)chooseSwitch{
    if (chooseSwitch.isOn) {
        _returnCar = YES ;
    }
    else{
        _returnCar = NO ;
    }
    
    DBLog(@"%d",chooseSwitch.isOn)
    
}


//定位点击了
-(void)changeLocation{
    
    NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
    [user objectForKey:@"userAddr"];
    
    _endAddr.field.text = [NSString stringWithFormat:@"%@",[[user objectForKey:@"userAddr"] objectForKey:@"address"]];
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
    DBLog(@"下车回执单提交");
    NSTimeInterval dataInterval;
    if (self.startDate) {
        dataInterval=[self.startDate timeIntervalSince1970]*1000;
    }
    else{
        
        [self tipShow:@"请完善信息"];
        return ;
    }
    DBNewtWorkData * netData = [[DBNewtWorkData alloc]init];
    
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
    NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
    [user objectForKey:@"userAddr"];
    
    
    if (!_endAddr.field.text || [_endAddr.field.text isEqualToString:@""]){
        
        _endAddr.field.text = _endAddr.field.placeholder ;
        
    }
    
    _infoDic[@"realEndTime"] = [NSString stringWithFormat:@"%0.f",dataInterval];
    _infoDic[@"getOffMileage"] = _endMileage.field.text ;
    _infoDic[@"getOffFuel"] = _oilBt.titleLabel.text ;
    _infoDic[@"id"] = self.model.id ;
    _infoDic[@"clientActualDebusAddress"] = _endAddr.field.text;
    _infoDic[@"returnCar"] = [NSString stringWithFormat:@"%d",_returnCar] ;
    
    
    if ([self.model.dispatchOrigin isEqualToString:@"1"]) {
        _infoDic[@"recipientName"] = _recipientName.field.text;
        
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    [netData submitEndRecordPUT:nil parameters:_infoDic with:self.model];
    netData.endRecordBlcok = ^(id message)
    {
        if (![message isKindOfClass:[NSError class]]) {
            
            if ([[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"status"]isEqualToString:@"true"]) {
                
                if ([[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"orderState"]]  isEqualToString:@"3"]) {
                     [self tipShow:@"客户取车成功"];
                }
                else{
                   [self tipShow:@"还车成功"];
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }
            else{
                [self tipShow:@"提交失败"];
            }
        }
        
    };
    
}

-(BOOL)judge:(NSTimeInterval)dataInterval{
    
    
    [self.tipView removeFromSuperview];
    
    if (!self.orderInfoDic) {
        if ([[self.orderInfoDic objectForKey:@"clientUpFuel"]isKindOfClass:[NSNull class]]) {
            [self tipShow:@"数据加载失败"];
            [self loadData];
            return NO;
        }
        
    }
    
    NSString * clientUpMileage =[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientUpMileage"]];
    
    
    NSArray *array = [[self.orderInfoDic objectForKey:@"clientUpFuel"] componentsSeparatedByString:@"/"];
    NSInteger takefuel = [[array firstObject]integerValue];
    
    NSArray * nowFuelArray  = [self.oilBt.titleLabel.text componentsSeparatedByString:@"/"];
    NSInteger nowFuel = [[nowFuelArray firstObject]integerValue];
    
    if (!dataInterval) {
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (!_endMileage.field.text || [_endMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if ([_oilBt.titleLabel.text isEqualToString:@"请选择下车油量"]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    
    else if (dataInterval <= [[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientUpCarDate"]]integerValue]){
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
        NSDate  * date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientUpCarDate"]]integerValue]/1000];
        NSString *  dateString = [formatter stringFromDate:date];
        
        [self tipShow:[NSString stringWithFormat:@"时间不能早于%@",dateString]];
        
        return NO;
        
    }
    
    else if (!self.endMileage.field.text){
        [self tipShow:@"请填写正确里程"];
        
    }
    else if ([self.endMileage.field.text integerValue] <=  [clientUpMileage integerValue]){
        [self tipShow:[NSString stringWithFormat:@"里程数应大于%@",clientUpMileage]];
        return NO;
        
    }
    return YES ;
}
-(BOOL)doorJudge:(NSTimeInterval)dataInterval{
    if (!dataInterval) {
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (!_endMileage.field.text || [_endMileage.field.text isEqualToString:@""]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if ([_oilBt.titleLabel.text isEqualToString:@"请选择送车油量"]){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    else if (!_recipientName.field.text){
        [self tipShow:@"请完善信息"];
        return NO;
    }
    
    return YES ;
}


//设置文本框只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (textField == _endMileage.field) {
        
        if (toBeString.length > 9) {
            return  NO ;
        }
        return [self validateNumber:string];
        
    }
    if (textField == _endAddr.field) {
        
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


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [_pickView removeFromSuperview];
}

- (void)tipShow:(NSString *)str
{
    
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
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
