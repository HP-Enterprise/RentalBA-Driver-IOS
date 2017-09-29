//
//  DBDoorBackRecord.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/12/21.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBDoorBackRecord.h"
#import "DBDatePickerView.h"

@interface DBDoorBackRecord ()<UITextFieldDelegate>


@property (nonatomic,strong)NSDate * startDate;
@property (nonatomic,strong)UIButton * startBt ;
@property (nonatomic,strong)UIButton * oilBt;
@property (nonatomic,strong)DBTextField * endTime;
@property (nonatomic,strong)DBTextField * endOil;
@property (nonatomic,strong)DBTextField * endMileage;
@property (nonatomic,strong)NSMutableDictionary * infoDic ;
@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic,strong)DBDatePickerView   *  pickView ;
@property (nonatomic,strong)DBPickerView * oilPickerView ;

@property (nonatomic,strong)NSDictionary * orderInfoDic ;

@end


@implementation DBDoorBackRecord


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
            
        }
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



-(void)setBasicUI{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
    [self setUI];
    
    [self setDatePicker];
    
    [self setPickerView];
    
    _infoDic = [NSMutableDictionary dictionary];
    
}


-(void)setNavigation{
    self.title = @"下车回录单";
    self.navigationController.navigationBar.barTintColor = BascColor ;

}


-(void)setUI{
    _endTime = [[DBTextField alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, 40) withTitle:@"下车时间"];
    //    _endTime.field.placeholder = @"2016/01/08 10:00";
    //    [_endTime.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_endTime.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [_endTime.field removeFromSuperview];
    _startBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _startBt.frame = _endTime.field.frame ;
    
    [_startBt setAttrubutwithTitle:@"选择下车时间" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
    _startBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_startBt addTarget:self action:@selector(showPickView) forControlEvents:UIControlEventTouchUpInside];
    [_endTime addSubview:_startBt];
    
    
    [self.view addSubview:_endTime];
    
    _endOil = [[DBTextField alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_endTime.frame)+10, ScreenWidth, 40) withTitle:@"下车油量"];
    
    
    _oilBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _oilBt.frame = _endTime.field.frame ;
    
    [_oilBt setAttrubutwithTitle:@"选择上车油量" withTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] withFont:12];
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
    _endMileage = [[DBTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_endOil.frame)+10, ScreenWidth, 40) withTitle:@"下车里程"];
    _endMileage.field.placeholder = @"请输入下车里程";
    [_endMileage.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    _endMileage.field.delegate = self ;
    [_endMileage.field setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_endMileage];
    
    
    //提交按钮
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBt.frame = CGRectMake(50, CGRectGetMaxY(_endMileage.frame)+60, ScreenWidth - 100 , 35);
    [submitBt setAttrubutwithTitle:@"提交" TitleColor:[UIColor whiteColor] BackColor:BascColor Font:14 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    
    [submitBt addTarget:self action:@selector(submitRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBt];
    
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
    
    
    if (![self judge:dataInterval]) {
        return ;
    }
    
    _infoDic[@"realEndTime"] = [NSString stringWithFormat:@"%0.f",dataInterval];
    _infoDic[@"getOffMileage"] = _endMileage.field.text ;
    _infoDic[@"getOffFuel"] = _oilBt.titleLabel.text ;
    _infoDic[@"id"] = self.model.id ;
    [netData submitEndRecordPUT:nil parameters:_infoDic with:self.model];
    netData.endRecordBlcok = ^(id message)
    {
        if (![message isKindOfClass:[NSError class]]) {
            
            [self tipShow:[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"message"]];
            if ([[[NSDictionary dictionaryWithDictionary:message]objectForKey:@"status"]isEqualToString:@"true"]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
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
    else if (dataInterval < [[NSString stringWithFormat:@"%@",[self.orderInfoDic objectForKey:@"clientUpCarDate"]]integerValue]){
        
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
    else if ([self.endMileage.field.text integerValue] <  [clientUpMileage integerValue]){
        [self tipShow:[NSString stringWithFormat:@"里程应大于%@",clientUpMileage]];
        return NO;
        
    }
    return YES ;
}


//设置文本框只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _endMileage.field) {
        
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
