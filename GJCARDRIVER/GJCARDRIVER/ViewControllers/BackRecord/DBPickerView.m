//
//  DBPickerView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBPickerView.h"

@implementation DBPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray*)data{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataArray = data ;
        [self setUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return  self;
}


-(void)setUI{
    
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
    
    
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height -0 - 30)];
    self.pickerView.delegate = self ;
    self.pickerView.dataSource =self ;
    [self addSubview:self.pickerView];
    
    
    self.chooseData = [self.dataArray firstObject];
    
    
}
-(void)cancelClick:(UIButton*)button{
    DBLog(@"取消");
    self.cancelBlcok();
}
-(void)submitClick:(UIButton*)button{
    DBLog(@"确认 %@",self.chooseData);

    self.chooseBlock(self.chooseData);
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        
        //        pickerLabel.adjustsFontSizeToFitWidth = YES;
        
        pickerLabel.textColor = [UIColor blackColor];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setTextAlignment:1];
        
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.font = [UIFont systemFontOfSize:16];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.chooseData = _dataArray[row];
    
}


-(void)btClick:(UIButton *)button
{
    

    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    
    return _dataArray.count;
    
    
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    return [_dataArray objectAtIndex:row];
    
    
}


@end
