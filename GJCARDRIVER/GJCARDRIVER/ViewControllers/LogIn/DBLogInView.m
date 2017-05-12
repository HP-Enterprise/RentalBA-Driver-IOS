//
//  DBLogInView.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBLogInView.h"

@implementation DBLogInView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self setUI];
        
        
        
        
    }
    return self;
}
#pragma mark 加载动画
-(void)addProgress
{
    _progress = [[DBProgressAnimation alloc]init];
    [_progress addProgressAnimationWithView:self];
    
    
}

-(void)removeProgress
{
    if (_progress != nil)
    {
        [_progress removeProgressAnimation];
    }
}

-(void)setUI{
    
    [self addSubview:self.logoImageV];

    
    //账号输入框
    _userNameField = [[DBTextField alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(self.logoImageV.frame)+60, ScreenWidth-50, 40) withImage:nil];
    _userNameField.layer.cornerRadius = 5;
    //    _userNameField.layer.borderWidth = 1;
    //    _userNameField.layer.borderColor =[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1].CGColor;
    _userNameField.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    _userNameField.field.placeholder = @"请输入手机号";
    
    [_userNameField.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_userNameField.field setValue:[UIFont systemFontOfSize:15 / 320.0 *ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    
    _userNameField.field.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_userNameField];
    
    
    
    //密码输入
    _passWordField =[[DBTextField alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_userNameField.frame)+10, ScreenWidth-50, 40) withImage:nil];
    //    _passWordField =[[DBTextField alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_userNameField.frame)+10, ScreenWidth-50, 40*ScreenHeight/667) withLeftImage:nil withButtonImage:nil withButtonHighImage:nil];
    
    _passWordField.layer.cornerRadius = 5;
    
    _passWordField.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
    //    _passWordField.button.frame = CGRectMake(_passWordField.frame.size.width- 40,_passWordField.frame.size.height/4,_passWordField.frame.size.height/2*11/8,_passWordField.frame.size.height/2);
    //
    
    _passWordField.field.placeholder = @"请输入密码";
    [_passWordField.field setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordField.field setValue:[UIFont systemFontOfSize:15 / 320.0 *ScreenWidth] forKeyPath:@"_placeholderLabel.font"];
    
    _passWordField.field.keyboardType = UIKeyboardTypeNamePhonePad;
    //    _passWordField.field.clearButtonMode = 0;
    
    _passWordField.field.secureTextEntry = YES;
//    [_passWordField.button addTarget:self action:@selector(passWordShow) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_passWordField];
    
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    

    if([user objectForKey:@"userName"]){
        _userNameField.field.text = [user objectForKey:@"userName"];
        if ([user objectForKey:@"passWord"]) {
            _passWordField.field.text = [user objectForKey:@"passWord"];
            
        }
    }
    


    
    //登录按钮
    UIButton * signInBt = [UIButton buttonWithType:UIButtonTypeCustom];
    signInBt.frame = CGRectMake(25, CGRectGetMaxY(_passWordField.frame)+20, ScreenWidth-50,35);
    signInBt.layer.cornerRadius = 5;
    signInBt.backgroundColor = [UIColor colorWithRed:0.91 green:0.76 blue:0.17 alpha:1];
    [signInBt setTitle:@"登录" forState:UIControlStateNormal];
    [signInBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signInBt.titleLabel.font = [UIFont systemFontOfSize:19 / 320.0 *ScreenWidth];
    [signInBt addTarget:self action:@selector(SignInBt:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signInBt];
    
    
    
    //忘记密码
    UIButton *forgetBt = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBt.frame = CGRectMake(ScreenWidth/2 - ScreenWidth*0.15, CGRectGetMaxY(signInBt.frame)+10, ScreenWidth*0.3, 20);
    forgetBt.titleLabel.textAlignment = 1;
    forgetBt.titleLabel.font = [UIFont systemFontOfSize:14 / 320.0 * ScreenWidth];
    [forgetBt addTarget:self action:@selector(forgetBt) forControlEvents:UIControlEventTouchUpInside];
    [forgetBt setTitle:@"修改密码?" forState:UIControlStateNormal];
    [forgetBt setTitleColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.77 alpha:1] forState:UIControlStateNormal];
    [self addSubview:forgetBt];
    
    
    
}


-(UIImageView*)logoImageV{
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - (117 * ScreenWidth / 320)/2, 80, 117 * ScreenWidth / 320 , 42 * ScreenWidth / 320)];
        self.logoImageV.image = [UIImage imageNamed:@"LOGO"];
    }
    return _logoImageV ;
}



-(void)SignInBt:(UIButton*)button{
    
    [self endEditing:YES];
    NSMutableDictionary *parDic = [[NSMutableDictionary alloc] init];
    
    NSString * PW = [DBNewtWorkData md5Digest:_passWordField.field.text];
    parDic[@"password"] = PW;
    NSLog(@"%@",_userNameField.field.text);
    NSLog(@"%@",PW);
    parDic[@"phone"] = _userNameField.field.text;

    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user setObject:_passWordField.field.text forKey:@"passWord"];
    [user setObject:_userNameField.field.text forKey:@"userName"];
    
    __weak typeof(self)weak_self = self ;
    
    
    [self addProgress];
    [DBNewtWorkData signInPost:nil parameters:parDic success:^(id responseObject) {
        DBLog(@"%@",responseObject);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [weak_self removeProgress];            
        });
        

        weak_self.signInBlock(responseObject);

    } failure:^(NSError *error) {
        [weak_self removeProgress];
        weak_self.signInBlock(error);
        DBLog(@"%@",error);
    }];
    
}

-(void)forgetBt{
    
    
    self.forGetPw();
}
@end
