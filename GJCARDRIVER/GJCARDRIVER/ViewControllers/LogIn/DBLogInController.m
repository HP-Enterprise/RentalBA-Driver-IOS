//
//  DBLogInController.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBLogInController.h"


#import "DBResetViewController.h"
#import "DBOrderController.h"



#import "DBUserInfoManager.h"

@interface DBLogInController ()<UITextFieldDelegate>


@property (nonatomic,strong)UIView * tipView ;
@end

@implementation DBLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor =  [UIColor grayColor];
    [self basicSet];
    [self loadVersion];
}




//界面 数据 基础设置
-(void)basicSet{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];

    [self setUI];
    [self setSignInInfo];
    [self setFogetPw];
}


-(void)setUI{
    
    self.logInView.frame = self.view.frame ;
    
    
}


-(DBLogInView*)logInView{
    
    if (!_logInView) {
        
        _logInView = [[DBLogInView alloc]init];
        _logInView.userNameField.field.delegate = self ;
        _logInView.passWordField.field.delegate =self ;
        
        [self.view addSubview:_logInView];
    }
    
    return _logInView ;
}

-(void)setSignInInfo{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    DBOrderController * order = [[DBOrderController alloc]init];

    __weak typeof(self)weak_self =self;
    
    _logInView.signInBlock = ^(id dic)
    {

        [weak_self.tipView removeFromSuperview];
        if ([dic isKindOfClass:[NSError class]]) {
            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误消息" message:dic preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//
//            [alertController addAction:cancelAction];
//
//            [weak_self presentViewController:alertController animated:YES completion:nil];

            [weak_self tipShow:@"登录失败"];
        }
        else{
            
            if ([[dic objectForKey:@"status"]isEqualToString:@"true"]) {
                
                [weak_self tipShow:@"登录成功"];
                [user setObject:[[dic objectForKey:@"message"]objectForKey:@"id"] forKey:@"userId"];
                
                
                [[DBUserInfoManager sharedManager]signInWithPassword:[dic objectForKey:@"message"]];
                
                NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
                [JPUSHService setAlias:[user objectForKey:@"userName"] callbackSelector:nil object:nil];
                
                NSHTTPCookie *cookie;

                //            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                for (cookie in [cookieJar cookiesForURL:[NSURL URLWithString:HOST]])
                {

                    if ([[cookie name] isEqualToString:@"driver_token"]) { // 获取响应头数组对象里地名字为token的对象
                        
                        NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);
                        //获取响应头数组对象里地名字为token的对象的数据，这个数据是用来验证用户身份相当于“key”
                        
                        ////保存个人信息
                        //        //登录成功后保存账号密码
                        [user setObject:[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]] forKey:@"driver_token"];
                        NSLog(@"11111111111%@",[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);

                    }
                }
                
                
                NSLog(@"####################################\n---%@--%@",[cookieJar cookies],[user objectForKey:@"userId"]); // 获取响应头的数组
                
                [user setObject:@"1" forKey:@"signIn"];
                
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weak_self.navigationController pushViewController:order animated:YES];
                });
            }
            else{
                
                
                [weak_self tipShow:[dic objectForKey:@"message"]];
                
            }

        }
        
};
    
}
-(void)setFogetPw{
    
    __weak typeof(self)weak_self =self;
    _logInView.forGetPw = ^()
    {
        DBResetViewController * reset = [[DBResetViewController alloc]init];
        [weak_self.navigationController pushViewController:reset animated:YES];
    };
  
}
- (void)tipShow:(NSString *)str
{
    
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    return YES;
}

-(void)loadVersion
{
    __weak typeof(self)weak_self = self ;
    
    [DBNewtWorkData GetVersion:nil parameters:nil success:^(id responseObject){
         
         NSString * flag = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"forceUpdate"]];
         
         //                 UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
         //                 [weak_self.view addSubview:backView];
         //                 backView.backgroundColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.68 alpha:1];
         //                 backView.alpha = 0.3 ;
         //                 [weak_self.view bringSubviewToFront:backView];
         //
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本可供更新" message:nil preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         }];
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.pgyer.com/E2T6"]];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self loadVersion];
             });
             
         }];
         
         if ([flag isEqualToString:@"0"]){
             [alertController addAction:cancelAction];
         }
         
         [alertController addAction:okAction];
         
         [weak_self presentViewController:alertController animated:YES completion:nil];
         
     } failure:^(NSError *error) {
     }];
}


//收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES ;
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
