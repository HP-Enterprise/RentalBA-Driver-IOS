//
//  DBResetViewController.m
//  ShenHuaCar
//
//  Created by 段博 on 16/3/3.
//  Copyright © 2016年 DuanBo. All rights reserved.

#import "DBResetViewController.h"
#import "DBOrderController.h"

@interface DBResetViewController ()
{
    DBProgressAnimation * _progress;
}
@property (nonatomic,strong)UIView *tipView;

@end

@implementation DBResetViewController
#pragma mark 加载动画
-(void)addProgress
{
    _progress = [[DBProgressAnimation alloc]init];
    [_progress addProgressAnimationWithViewControl:self];
    
    
}

-(void)removeProgress
{
    if (_progress != nil)
    {
        [_progress removeProgressAnimation];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createUI];
}


-(void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"修改密码";
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

-(void)createUI
{
    
    //请输入框
    userName = [[DBTextField alloc]initWithFrame:CGRectMake(25, 120, ScreenWidth-50, 40*ScreenHeight/667) withImage:nil];
    userName.layer.cornerRadius = 5;
    userName.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    userName.field.placeholder = @"请输入账号";
    [userName.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [userName.field setValue:[UIFont systemFontOfSize:15 / 320.0 *ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    
    userName.field.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:userName];

    
    
    //请输入框
    newPwField = [[DBTextField alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(userName.frame)+15, ScreenWidth-50, 40*ScreenHeight/667) withImage:nil];
    newPwField.layer.cornerRadius = 5;
//    newPwField.layer.borderWidth = 1;
    newPwField.field.secureTextEntry = YES;
//    newPwField.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor;
    
    newPwField.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    newPwField.field.placeholder = @"请输入原密码";
    [newPwField.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [newPwField.field setValue:[UIFont systemFontOfSize:15 / 320.0 *ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    
    newPwField.field.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:newPwField];
    
    
    //请输入框
    newPwAgField = [[DBTextField alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(newPwField.frame)+15, ScreenWidth-50, 40*ScreenHeight/667) withImage:nil];
    newPwAgField.layer.cornerRadius = 5;
//    newPwAgField.layer.borderWidth = 1;
    newPwAgField.field.secureTextEntry = YES;
    
//    newPwAgField.layer.borderColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor;
   
    newPwAgField.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

    
    newPwAgField.field.placeholder = @"请输入新密码";
    [newPwAgField.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [newPwAgField.field setValue:[UIFont systemFontOfSize:15 / 320.0 *ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    
    newPwAgField.field.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:newPwAgField];

    
    //提交按钮
    //保存修改按钮
    UIButton * saveBt = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBt.frame = CGRectMake( 40 , CGRectGetMaxY(newPwAgField.frame)+20 , ScreenWidth - 80  , 30);
    [saveBt setTitle:@"保存" forState:UIControlStateNormal];
    
    
    saveBt.layer.cornerRadius = 3 ;
    
    
    [saveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    saveBt.titleLabel.font = [UIFont systemFontOfSize:14 ];
    
    saveBt.backgroundColor = [UIColor colorWithRed:0.95 green:0.78 blue:0.11 alpha:1];
    [saveBt addTarget:self action:@selector(submitBt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBt];
    
  
}


#pragma mark 提交密码修改
//提交
-(void)submitBt
{

    [self.view endEditing:YES];
    NSLog(@"提交点击");
    
    {

        NSDictionary * dic= @{@"phone":userName.field.text,@"newPassword":newPwAgField.field.text,@"password":newPwField.field.text};
        DBOrderController * order = [[DBOrderController alloc]init];
        
        __weak typeof(self)weak_self =self;

        [self addProgress];
        [DBNewtWorkData changePwPost:nil parameters:dic success:^(id responseObject) {
            [weak_self.tipView removeFromSuperview];
            [self removeProgress];

            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                
                [weak_self tipShow:@"修改成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weak_self.navigationController pushViewController:order animated:YES];
                });
            }
            else
            {
                [weak_self tipShow:[responseObject objectForKey:@"message"]];
 
            }
           
        } failure:^(NSError *error) {
            [self removeProgress];
            [weak_self tipShow:@"连接失败"];

            
        }];
    }
}


- (void)tipShow:(NSString *)str
{
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
    
}


//返回按钮点击
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNavigation];
    self.navigationController.navigationBarHidden = NO;
    
}
//空白处键盘消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
