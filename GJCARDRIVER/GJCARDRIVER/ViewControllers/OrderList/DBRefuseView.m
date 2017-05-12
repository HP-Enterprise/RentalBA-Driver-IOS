//
//  DBRefuseView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/15.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBRefuseView.h"

@implementation DBRefuseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    UIView * backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.65 alpha:1] ;
    backView.alpha = 0.3 ;
    [self addSubview:backView];
    
    
    _reasonView = [[UIView alloc]initWithFrame:CGRectMake(15, ScreenHeight * 0.2, ScreenWidth - 30 , ScreenHeight * 0.4 )];
    _reasonView.backgroundColor = [UIColor whiteColor];
    _reasonView.layer.cornerRadius = 5 ;
    _reasonView.layer.masksToBounds = YES ;
    [self addSubview:_reasonView];
    
    
    
    UILabel * reasonLabel  = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width - 20 , 40)];
    reasonLabel.text = @"拒绝理由:"  ;
    reasonLabel.font = [UIFont systemFontOfSize:12];
    [_reasonView addSubview:reasonLabel];
    
    
    
    _reasonTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(reasonLabel.frame), _reasonView.frame.size.width - 30, _reasonView.frame.size.height -  100)];
    _reasonTextView.layer.borderWidth = 0.5 ;
    _reasonTextView.layer.borderColor =  [UIColor colorWithRed:0.64 green:0.64 blue:0.65 alpha:1].CGColor ;
    [_reasonView addSubview:_reasonTextView];
    
    
    
    
    UIButton * cancelBt =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBt.frame = CGRectMake(0, ScreenHeight * 0.4 - 30, _reasonView.frame.size.width /2, 30);
    [cancelBt setTitle:@"取消" forState:UIControlStateNormal];
    cancelBt.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBt.backgroundColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.65 alpha:1] ;
    

//    cancelBt.layer.cornerRadius = 5 ;
    [cancelBt addTarget:self action:@selector(submitCancel:) forControlEvents:UIControlEventTouchUpInside];
    [_reasonView addSubview:cancelBt];

    

    UIButton * refuseBt =[UIButton buttonWithType:UIButtonTypeCustom];
    refuseBt.frame = CGRectMake(_reasonView.frame.size.width /2, ScreenHeight * 0.4 - 30, _reasonView.frame.size.width /2, 30);
    [refuseBt setTitle:@"提交" forState:UIControlStateNormal];
    refuseBt.titleLabel.font = [UIFont systemFontOfSize:14];
    refuseBt.backgroundColor = BascColor ;
//    refuseBt.layer.cornerRadius = 5 ;
    [refuseBt addTarget:self action:@selector(submitRefuse:) forControlEvents:UIControlEventTouchUpInside];
    [_reasonView addSubview:refuseBt];
    
    
}

-(void)submitRefuse:(UIButton*)button{
    
    self.refuseBlcok(_reasonTextView.text);
}
-(void)submitCancel:(UIButton*)button{
    
    self.cancelBlock();
}




@end
