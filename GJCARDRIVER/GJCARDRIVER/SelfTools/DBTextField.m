//
//  DBTextField.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBTextField.h"

@implementation DBTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */
-(instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)image
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.floatH = frame.size.height ;
        //背景设置
        UIView *baseView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:baseView];
        //中间TextFiled
        CGFloat fieldW = frame.size.width ;
        CGFloat fieldH = frame.size.height ;
        
        _field = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, fieldW-20,fieldH - 10 )];
        [self addSubview:_field];
        _field.font = [UIFont systemFontOfSize:16];
        _field.clearButtonMode =UITextFieldViewModeWhileEditing;
        
    }
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 25);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"more-image"] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    
    [_field setInputAccessoryView:topView];
    
    NSLog(@"%f",topView.frame.origin.y);
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.floatH = frame.size.height ;
        //背景设置
//        UIView *baseView = [[UIView alloc]initWithFrame:frame];
//        [self addSubview:baseView];
        //中间TextFiled
        CGFloat fieldW = frame.size.width ;
        CGFloat fieldH = frame.size.height ;
        
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, frame.size.width/3, frame.size.height)];
        [self addSubview:titleLabel];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor blackColor];
        
        
        _field = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, fieldW-CGRectGetMaxX(titleLabel.frame),fieldH  )];
        [self addSubview:_field];
        _field.font = [UIFont systemFontOfSize:12];
        _field.clearButtonMode =UITextFieldViewModeWhileEditing;
        
        
        UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        topLine.backgroundColor =[UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1];
        [self addSubview:topLine];
        
        
        
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        bottomLine.backgroundColor =[UIColor colorWithRed:0.8 green:0.8 blue:0.81 alpha:1];
        [self addSubview:bottomLine];
        
        
        
    }
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(2, 5, 50, 30);
    [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"more-image"] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
    [topView setItems:buttonsArray];
    
    [_field setInputAccessoryView:topView];
    
    NSLog(@"%f",topView.frame.origin.y);
    return self;
}





-(void)dismissKeyBoard
{
    [_field resignFirstResponder];
}

@end
