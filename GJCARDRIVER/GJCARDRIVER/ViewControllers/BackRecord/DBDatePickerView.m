
//
//  DBDatePickerView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/18.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBDatePickerView.h"


@implementation DBDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDatePicker];
        [self setBt];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setBt{
    
    UIButton * cancelBt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBt.frame = CGRectMake(0, 0, ScreenWidth/2, 30);
    [cancelBt setAttrubutwithTitle:@"取消" withTitleColor:[UIColor blackColor] withFont:14];
    [cancelBt addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBt];
    cancelBt.backgroundColor  = BascColor ;
    
    UIButton * submitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBt.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 30);
    [submitBt setAttrubutwithTitle:@"确认" withTitleColor:[UIColor blackColor] withFont:14];
    [submitBt addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBt.backgroundColor = BascColor ;
    [self addSubview:submitBt];
    

}


-(void)setDatePicker{
    
    
    datePicker = [[DBDatePicker alloc] init];
    datePicker.frame = CGRectMake(0,  30 ,ScreenWidth , 200);
    
    [datePicker setTextColor];
//    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
}

-(void)chooseDate:(DBDatePicker*)piker
{
    NSDate *date = piker.date;
    NSLog(@"时间:%@",date);

}



-(void)cancelClick:(UIButton*)button{
    DBLog(@"取消");
    self.cancelDateBlcok();
}
-(void)submitClick:(UIButton*)button{
    DBLog(@"确认");
    
    NSDate * date = datePicker.date ;
    self.chooseDateBlock(date);
}

@end
