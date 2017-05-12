//
//  DBOrderListView.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBOrderListView.h"

@implementation DBOrderListView 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [ super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView * basicView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    basicView.backgroundColor =[UIColor whiteColor];
    [self addSubview:basicView];
    [basicView addSubview:self.waitWorkBt];
    [basicView addSubview:self.workingBt];
    [basicView addSubview:self.finishWorkBt];
    [basicView addSubview:self.indexView];
}

-(UIButton*)waitWorkBt{
    if (!_waitWorkBt) {
        _waitWorkBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/4, 38)];
        [_waitWorkBt setAttrubutwithTitle:@"待接单" withTitleColor:BascColor withFont:14];
        [_waitWorkBt addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        _lastBt = _waitWorkBt ;
    }
    return _waitWorkBt;
}

-(UIButton*)workingBt{
    if (!_workingBt) {
        _workingBt = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*3/8, 0, ScreenWidth/4, 38)];
        [_workingBt setAttrubutwithTitle:@"已接单" withTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] withFont:14];
        [_workingBt addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workingBt;
}

-(UIButton*)finishWorkBt{
    if (!_finishWorkBt) {
        _finishWorkBt = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*3/4, 0, ScreenWidth/4, 38)];
        [_finishWorkBt setAttrubutwithTitle:@"已完成" withTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] withFont:14];
        [_finishWorkBt addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishWorkBt;
}

-(UIView*)indexView{
    if (!_indexView) {
        _indexView = [[UIView alloc]initWithFrame:CGRectMake(self.workingBt.frame.size.width/4, 38, self.workingBt.frame.size.width/2, 2)];
        _indexView.backgroundColor = BascColor ;
    }
    return  _indexView;
}



#pragma mark -----点击事件
-(void)changeView:(UIButton*)button{
    
    if ([button isEqual:_waitWorkBt]) {
        self.orderNameBlcok(@"待确认");
    }
    else if ([button isEqual:_workingBt]){
        self.orderNameBlcok(@"待完成");
    }
    else if ([button isEqual:_finishWorkBt]){
        self.orderNameBlcok(@"已确认");
    }
    
    if (_lastBt != button) {
        [button setTitleColor:BascColor forState:UIControlStateNormal];
        [_lastBt setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1]  forState:UIControlStateNormal];
        [self moveIndexView:button];
        _lastBt = button ;
    }
}

-(void)moveIndexView:(UIButton*)button{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect newFrame = _indexView.frame ;
        newFrame.origin.x = button.frame.origin.x + button.frame.size.width/4 ;
        _indexView.frame  =newFrame ;
    }];
    
    if ([button isEqual:_waitWorkBt]) {
        
        self.scrollViewMove(0);
    }
    else if ([button isEqual:_workingBt]){
        
        self.scrollViewMove(1);
    }
    else if ([button isEqual:_finishWorkBt]){
        
        self.scrollViewMove(2);
    }
    DBLog(@"%f",_indexView.frame.origin.x);
}


@end
