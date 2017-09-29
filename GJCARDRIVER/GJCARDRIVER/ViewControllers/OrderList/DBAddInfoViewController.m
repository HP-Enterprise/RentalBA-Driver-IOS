//
//  DBAddInfoViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/28.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBAddInfoViewController.h"


@interface DBAddInfoViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic)BOOL keyboardDidShow;
@property (nonatomic)BOOL  markViewIsEditing;
@end

@implementation DBAddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBaseUI];
    [self setNavigation];
}
-(void)setNavigation{
    self.title = @"路单信息";
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
-(void)setBaseUI{
    
    self.getonMileage.delegate = self;
    self.getoffMileage.delegate = self;
    self.addFuelCost.delegate = self;
    self.addFuelMileage.delegate = self;
    self.parkCost.delegate =self;
    self.accommodation.delegate = self;
    self.otherCost.delegate = self;
    self.markView.delegate = self;
    
    
    self.getonTimeBt.layer.borderWidth= 0.5 ;
    self.getonTimeBt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.getonTimeBt.layer.cornerRadius = 5 ;
    self.getonTimeBt.layer.masksToBounds = YES;
    
    self.getoffTimeBt.layer.borderWidth= 0.5 ;
    self.getoffTimeBt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.getoffTimeBt.layer.cornerRadius = 5 ;
    self.getoffTimeBt.layer.masksToBounds = YES;
    
    self.markView.layer.borderWidth= 0.5 ;
    self.markView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.markView.layer.cornerRadius = 5 ;
    self.markView.layer.masksToBounds = YES;
    
    
    self.getonMileage.inputAccessoryView = [self toolBt];
    self.getoffMileage.inputAccessoryView = [self toolBt];
    self.addFuelCost.inputAccessoryView = [self toolBt];
    self.addFuelMileage.inputAccessoryView = [self toolBt];
    self.parkCost.inputAccessoryView = [self toolBt];
    self.accommodation.inputAccessoryView = [self toolBt];
    self.otherCost.inputAccessoryView = [self toolBt];
    self.markView.inputAccessoryView = [self toolBt];
    
    
    self.saveBt.backgroundColor = BascColor;
    self.saveBt.layer.cornerRadius = 5;
    [self.saveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setDatePicker];


    if ([[NSString stringWithFormat:@"%@",self.roadOrder[@"status"]]isEqualToString:@"0"]) {
    }
    else if ([[NSString stringWithFormat:@"%@",self.roadOrder[@"status"]]isEqualToString:@"1"]) {
        [self justShowInfo];
    }
    
    if ([self.index isEqualToString:@"show"]) {
        [self justShowInfo];
    }
    
    if (self.roadOrder) {
        [self config];
    }
    
    self.orderNumber.text = [NSString stringWithFormat:@"%@",self.orderModel.orderCode];

}


-(void)justShowInfo{
    self.getonTimeBt.enabled = NO;
    self.getoffTimeBt.enabled = NO;
    self.getonMileage.enabled = NO;
    self.getoffMileage.enabled = NO;
    self.addFuelCost.enabled = NO;
    self.addFuelMileage.enabled = NO;
    self.parkCost.enabled = NO;
    self.accommodation.enabled = NO;
    self.otherCost.enabled = NO;
    self.markView.editable = NO;
    
    [self.saveBt setTitle:@"确定" forState: UIControlStateNormal];
}

-(void)config{
    
    NSString * startTime = [NSString stringWithFormat:@"%@",self.roadOrder[@"takeCarActualDate"]];
    NSString * endTime = [NSString stringWithFormat:@"%@",self.roadOrder[@"returnCarActualDate"]];
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    // 毫秒值转化为秒
    NSDate* startdate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/ 1000.0];
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/ 1000.0];
    
    NSString* startdateString = [formatter stringFromDate:startdate];
    NSString* enddateString = [formatter stringFromDate:endDate];
    
    
    /*
     contractCode = 1222221131;
     contractType = 0;
     driverId = 1;
     fuelCharge = 1;
     hotelExpenses = 3;
     id = 4;
     license = "\U6d59A3UF67";
     otherExpenses = 4;
     parkingTollFee = 2;
     realName = "\U6bdb\U5e86";
     refuelingMileage = 1;
     remark = 122222211;
     returnCarActualDate = 1503988292000;
     returnCarMileage = 0;
     status = 0;     0 未汇总 1.已汇总
     takeCarActualDate = 1503988292000;
     takeCarMileage = 123;
     vehicleId = 9886;
     */
    [self.getonTimeBt setTitle:startdateString forState:UIControlStateNormal];
    [self.getoffTimeBt setTitle:enddateString forState:UIControlStateNormal];
    self.getonMileage.text = [NSString stringWithFormat:@"%@ ",self.roadOrder[@"takeCarMileage"]];
;
    self.getoffMileage.text = [NSString stringWithFormat:@"%@ ",self.roadOrder[@"returnCarMileage"]];
    self.addFuelCost.text = [NSString stringWithFormat:@"%@ ",self.roadOrder[@"fuelCharge"]];
    self.addFuelMileage.text = [NSString stringWithFormat:@"%@ ",self.roadOrder[@"refuelingMileage"]];
    self.parkCost.text = [NSString stringWithFormat:@"%@",self.roadOrder[@"parkingTollFee"]];
    self.accommodation.text = [NSString stringWithFormat:@"%@",self.roadOrder[@"hotelExpenses"]];
    self.otherCost.text = [NSString stringWithFormat:@"%@",self.roadOrder[@"otherExpenses"]];
    self.markView.text = [NSString stringWithFormat:@"%@",self.roadOrder[@"remark"]];
}

- (IBAction)getonBtClick:(id)sender {
    [self showPickView:sender];
}
- (IBAction)getoffBtClick:(id)sender {
    [self showPickView:sender];
}
- (IBAction)saveBtClick:(id)sender {
    
    
     if ([[NSString stringWithFormat:@"%@",self.roadOrder[@"status"]]isEqualToString:@"1"]) {
         [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([self.index isEqualToString:@"show"]) {
        [self.navigationController popViewControllerAnimated:YES];

    }


    
//    NSString * startTime = [NSString stringWithFormat:@"%@",dic[@"takeCarActualDate"]];
//    NSString * endTime = [NSString stringWithFormat:@"%@",dic[@"returnCarActualDate"]];
//    
    NSString* startTimeStr = self.getonTimeBt.titleLabel.text;
    NSString * endTimeStr =  self.getoffTimeBt.titleLabel.text ;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; //
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* startdate = [formatter dateFromString:startTimeStr]; //------------将字符串按formatter转成nsdate
    NSDate * enddate = [formatter dateFromString:endTimeStr];

    NSString *starttimeSp = [NSString stringWithFormat:@"%ld", (long)[startdate timeIntervalSince1970]*1000];
    NSString *endtimeSp = [NSString stringWithFormat:@"%ld",(long)[enddate timeIntervalSince1970]*1000];
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    // 毫秒值转化为秒
//
//    NSDate* startdate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/ 1000.0];
//    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/ 1000.0];
//    
//    NSString* startdateString = [formatter stringFromDate:startdate];
//    NSString* enddateString = [formatter stringFromDate:endDate];
//    
//    
    NSLog(@"%@  %@",starttimeSp,endtimeSp);
    
    if (startdate > enddate) {
        [self tipShow:@"上车时间应小于下车时间"];
        return;
    }
    if ([self.getonTimeBt.titleLabel.text isEqualToString:@"请选择上车时间"]) {
        [self tipShow:@"请选择上车时间"];
        return;
    }
    if ([self.getoffTimeBt.titleLabel.text isEqualToString:@"请选择下车时间"]) {
        [self tipShow:@"请选择下车时间"];
        return;
    }
    if ([self.getonMileage.text integerValue] > [self.getoffMileage.text integerValue]) {
        [self tipShow:@"上车里程应小于下车里程"];
        return;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * userId = [user objectForKey:@"userId"];
    
    
    
    NSString * addFuelCoststr;
    NSString * addFuelMileagestr;
    NSString * parkCoststr;
    NSString * accommodationstr;
    
    NSString * otherCoststr;
    NSString * getonMileagestr;
    NSString * getoffMileagestr;
    NSString * markViewstr;
    
    
    
    
    if (!self.addFuelCost.text || self.addFuelCost.text.length == 0) {
        addFuelCoststr = @"0";
    }
    else{
        addFuelCoststr = self.addFuelCost.text ;
    }
    if (!self.addFuelMileage.text || self.addFuelMileage.text.length == 0) {
        addFuelMileagestr = @"0";
    }
    else{
        addFuelMileagestr = self.addFuelMileage.text ;
    }
    if (!self.parkCost.text || self.parkCost.text.length == 0) {
        parkCoststr = @"0";
    }
    else{
        parkCoststr = self.parkCost.text ;
    }
    if (!self.accommodation.text || self.accommodation.text.length == 0) {
        accommodationstr = @"0";
    }
    else{
        accommodationstr = self.accommodation.text;

    }
    if (!self.otherCost.text || self.otherCost.text.length == 0) {
        otherCoststr = @"0";
    }else{
        otherCoststr = self.otherCost.text ;
    }
    if (!self.getonMileage.text || self.getonMileage.text.length == 0) {
         getonMileagestr = @"0";
    }else{
        getonMileagestr = self.getonMileage.text;
    }
    if (!self.getoffMileage.text || self.getoffMileage.text.length == 0) {
         getoffMileagestr = @"0";
    }else{
        getoffMileagestr = self.getoffMileage.text;
        
    }
    if (!self.markView.text || self.markView.text.length == 0) {
         markViewstr = @"";
    }else{
        markViewstr = self.markView.text;
    }
    
    
    NSDictionary * dic = @{@"contractCode":self.orderModel.orderCode,
                           @"contractType":self.orderModel.orderType,
                           @"vehicleId":self.contrectInfo[@"vehicleId"],
                           @"driverId":self.contrectInfo[@"driverId"],
                           
                           @"fuelCharge":addFuelCoststr,
                           @"refuelingMileage":addFuelMileagestr,
                           @"parkingTollFee":parkCoststr,
                           @"hotelExpenses":accommodationstr,
                           @"otherExpenses":otherCoststr,
                           @"takeCarActualDate":starttimeSp,
                           @"returnCarActualDate":endtimeSp,
                           @"takeCarMileage":getonMileagestr,
                           @"returnCarMileage":getoffMileagestr,
                           @"remark":markViewstr};
    

    if ([self.index isEqualToString:@"add"]) {
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.saveBt.userInteractionEnabled = NO;
        [DBNewtWorkData addRoadOrderGet:nil parameters:dic success:^(id responseObject){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self tipShow:@"添加成功"];
            if ([responseObject[@"status"]isEqualToString:@"true"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    self.saveBt.userInteractionEnabled = YES;
                });
            }
            else{
                [self tipShow:@"添加失败"];
                self.saveBt.userInteractionEnabled = YES;
            }
        } failure:^(NSError *error) {
            [self tipShow:@"链接失败"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.saveBt.userInteractionEnabled = YES;

            
        }];
    }
    else if ([self.index isEqualToString:@"edit"]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        self.saveBt.userInteractionEnabled = NO;
        
        [DBNewtWorkData editRoadOrderPUT:nil parameters:dic with:self.roadOrder[@"id"] success:^(id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if ([responseObject[@"status"]isEqualToString:@"true"]) {
                [self tipShow:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    self.saveBt.userInteractionEnabled = YES;
                });
            }
            else{
                [self tipShow:@"修改失败"];
                self.saveBt.userInteractionEnabled = YES;

            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.saveBt.userInteractionEnabled = YES;

            [self tipShow:@"链接失败"];
        }];

    }
    
}


-(void)setDatePicker{
    _pickView = [[DBDatePickerView alloc]initWithFrame:CGRectMake( 0,  ScreenHeight, ScreenWidth, 230)];
    [self.view addSubview:_pickView];
    __weak typeof(self)weak_self = self;
    _pickView.cancelDateBlcok=^(){
        [weak_self removePickView] ;
    };
    
    
}
-(void)showPickView:(UIButton*)button{
    
    __weak typeof(self)weak_self = self;
    _pickView.chooseDateBlock= ^(NSDate * date){
        DBLog(@"%@",date);
        [weak_self removePickView] ;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
//        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
        // 毫秒值转化为秒
        NSString *  dateString = [formatter stringFromDate:date];
        if (button == weak_self.getonTimeBt) {
            [weak_self.getonTimeBt setTitle:dateString forState:UIControlStateNormal];
        }
        else if (button == weak_self.getoffTimeBt){
            [weak_self.getoffTimeBt setTitle:dateString forState:UIControlStateNormal];
        }
        //        [weak_self.startBt setTitle:dateString forState:UIControlStateNormal];
        //        weak_self.startDate = date ;
        //        
    };

    
    
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    

    return YES;
}


-(void)markViewMove:(CGFloat)height{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backViewTop.constant = -height;

    }];
}


//设置文本框只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (toBeString.length > 12) {
        return  NO ;
    }


    if (textField == self.addFuelCost ||  textField == self.otherCost || textField == self.parkCost|| textField == self.accommodation) {
        
        if (![self validateNumber:toBeString]) {
            return NO;
        }
        
        //如果输入的是“.”  判断之前已经有"."或者字符串为空
        if ([string isEqualToString:@"."] && ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""])) {
            return NO;
        }
        //拼出输入完成的str,判断str的长度大于等于“.”的位置＋4,则返回false,此次插入string失败 （"379132.424",长度10,"."的位置6, 10>=6+4）
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        [str insertString:string atIndex:range.location];
        if (str.length >= [str rangeOfString:@"."].location+4){
            return NO;
        }
    }
    else{
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        int i = 0;
        while (i < toBeString.length) {
            NSString * string = [toBeString substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0) {
                return  NO;
            }
            i++;
        }
        return YES;
 
    }
    
    
    
    return YES;
    

}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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


- (void)textViewDidBeginEditing:(UITextView *)textView{
    _markViewIsEditing = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    _markViewIsEditing = NO;
}

-(UIView*)toolBt{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"more-image"] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    
    return topView;

}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    self.scrollView_width.constant = self.view.frame.size.width ;
    self.scrollView_hejght.constant = self.view.frame.size.height ;
}

- (void)tipShow:(NSString *)str
{
    if (self.tipView) {
        [self.tipView removeFromSuperview];
    }
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    

}


- (void)keyBoardDidShow:(NSNotification *)notif {
    NSLog(@"===keyboar showed====");
    if (_keyboardDidShow) return;
    //    get keyboard size
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    //  reset scrollview frame
    if (_markViewIsEditing) {
         [self markViewMove:keyboardSize.height];
    }
    _keyboardDidShow = YES;
    
}

- (void)keyBoardDidHide:(NSNotification *)notif {
    NSLog(@"====keyboard hidden====");
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;

    if (!_markViewIsEditing) {
        [self markViewMove:0];
    }
    if (!_keyboardDidShow) {
        return;
    }
    _keyboardDidShow = NO;
}


-(void)dismissKeyBoard{
    [self.view endEditing:YES];
 
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
