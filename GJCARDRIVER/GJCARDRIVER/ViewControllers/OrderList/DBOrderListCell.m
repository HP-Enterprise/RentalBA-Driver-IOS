//
//  DBOrderListCell.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/9.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBOrderListCell.h"


@implementation DBOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    
        if ([reuseIdentifier isEqualToString:@"waitWorkCell"] ) {
            [self setWaitWorkBottomBt];
            [self setShowMoreBt];
        }
        else if ([reuseIdentifier isEqualToString:@"workingCell"]){
            [self setWorkingBottomBt];
        }
        else if ([reuseIdentifier isEqualToString:@"finishWorkCell"]){
            [self setFinishBottomBt];
        }
    }
    return self;
}

-(void)setUI{

    
    UIView * headerView = [[ UIView alloc]initWithFrame:CGRectMake(0, 0,    ScreenWidth, 10)];
    headerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1] ;
    [self addSubview:headerView];
    
    
    UIView * headline = [[UIView alloc]initWithFrame:CGRectMake(0, 9.5,ScreenWidth, 0.5)];
    headline.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    
    [headerView addSubview:headline];

    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), ScreenWidth, 40)];
    headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.66 blue:0.24 alpha:1];
    [self addSubview:headView];
    headView.userInteractionEnabled = YES ;

    
    
    _topControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 10, self.contentView.frame.size.width, 40)];
    [self addSubview:_topControl];
    
    
    _orderType = [[UILabel alloc]initWithFrame:CGRectMake(15,0, ScreenWidth/3, 40)];
    [_orderType setAttrubutwithText:@"接机/送机 " withFont:12 withBackColor:nil withTextColor:[UIColor whiteColor] withTextAlignment:0];
    [headView addSubview:_orderType];
    
    _userTime = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3,0, ScreenWidth*2/3-15, 40)];
    [_userTime setAttrubutwithText:@"2017年04月20日 15:00 " withFont:12 withBackColor:nil withTextColor:[UIColor whiteColor] withTextAlignment:2];
    [headView addSubview:_userTime];
    
    
    _orderType.userInteractionEnabled = YES ;
    
    _userTime.userInteractionEnabled = YES ;
    
    
//调度单编号
    _orderNumber = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame), ScreenWidth /2, 30)];
    [_orderNumber setAttrubutwithText:@"订单编号: " withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [self addSubview:self.orderNumber];
    

    
    _mileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth /2 - 30, CGRectGetMaxY(headView.frame), ScreenWidth/2 - 50, 30)];
    [_mileageLabel  setAttrubutwithText:@"预估里程: 公里 " withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
    [self addSubview:_mileageLabel];

    

//航班信息
    _aifPortInfo = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_orderNumber.frame), ScreenWidth - 30, 30)];
    [_aifPortInfo setAttrubutwithText:@"航班信息: 航空公司" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [self addSubview:_aifPortInfo];
    
    

    CGFloat  width  = (ScreenWidth - 80)/ 3;


    
//开始地点
    _startAddress = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_aifPortInfo.frame)+5, width , 40)];
    [_startAddress setAttrubutwithText:@"" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    _startAddress.numberOfLines = 2;
    _startAddress.adjustsFontSizeToFitWidth = YES ;
    [self addSubview:_startAddress];
    
    
    
//中间车型
    _carName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_startAddress.frame) , _startAddress.frame.origin.y - 5, width -20  , 25)];
    [_carName setAttrubutwithText:@"中华H330" withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
    _carName.numberOfLines = 2;
//    _carName.adjustsFontSizeToFitWidth = YES ;
    [self addSubview:_carName];
    
    
    carLine = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(_startAddress.frame), _startAddress.frame.origin.y + 20, width - 20, 0.5)];
    carLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [self addSubview:carLine];

    
    //结束地点
    _endAddress = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carLine.frame)+5, _startAddress.frame.origin.y, width+10, 40)];
    [_endAddress setAttrubutwithText:@"" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    _endAddress.numberOfLines = 2;
    _endAddress.adjustsFontSizeToFitWidth = YES ;
    [self addSubview:_endAddress];


    //底部横线
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startAddress.frame) +5, ScreenWidth,0.5)];
    
    bottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];

    [self addSubview:bottomLine];
    
    DBLog(@"%f",bottomLine.frame.origin.y);

}
-(void)setWaitWorkBottomBt{
    // 底部接受/拒绝按钮
    _acceptBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _acceptBt.frame = CGRectMake(ScreenWidth - 60, _orderNumber.frame.origin.y + 17 , 45, 30);
    
    [_acceptBt setAttrubutwithTitle:@"确认" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.45 green:0.78 blue:0.11 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
      [self addSubview:_acceptBt];
    
    
    
    _refuseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _refuseBt.frame = CGRectMake(ScreenWidth - 60, CGRectGetMaxY(_acceptBt.frame)+ 17, 45, 30);
    [_refuseBt setAttrubutwithTitle:@"拒绝" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:1 green:0.36 blue:0.23 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
      [self addSubview:_refuseBt];
    
    //164
    DBLog(@"%f",CGRectGetMaxY(_endAddress.frame));

    //底部横线
    UIView * lastLine = [[UIView alloc]initWithFrame:CGRectMake(0,170.5, ScreenWidth,0.5)];
    
    lastLine.backgroundColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1];
//    [self addSubview:lastLine];

}

-(void)setWorkingBottomBt{
    // 底部接受/拒绝按钮
    _acceptBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _acceptBt.frame = CGRectMake(ScreenWidth - 60, _orderNumber.frame.origin.y + 17 , 45, 30);
    
    [_acceptBt setAttrubutwithTitle:@"提车" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.45 green:0.78 blue:0.11 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
       [self addSubview:_acceptBt];
    
    
    _refuseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _refuseBt.frame = CGRectMake(ScreenWidth - 60, CGRectGetMaxY(_acceptBt.frame)+ 17, 45, 30);
    [_refuseBt setAttrubutwithTitle:@"路单" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.45 green:0.78 blue:0.11 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
       [self addSubview:_refuseBt];
    
    //164
    DBLog(@"%f",CGRectGetMaxY(_endAddress.frame));
    
    //底部横线
    UIView * lastLine = [[UIView alloc]initWithFrame:CGRectMake(0,170.5, ScreenWidth,0.5)];
    
    lastLine.backgroundColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1];
//    [self addSubview:lastLine];
}

-(void)setFinishBottomBt{
    // 底部接受/拒绝按钮
//    _acceptBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    _acceptBt.frame = CGRectMake(ScreenWidth - 60, _orderNumber.frame.origin.y + 17 , 45, 30);
//    
//    [_acceptBt setAttrubutwithTitle:@"提车" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.45 green:0.78 blue:0.11 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
//    [self addSubview:_acceptBt];
//    
//    
    _refuseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _refuseBt.frame = CGRectMake(ScreenWidth - 60, _orderNumber.frame.origin.y + 35, 45, 30);
    [_refuseBt setAttrubutwithTitle:@"路单" TitleColor:[UIColor whiteColor] BackColor:BascColor Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    [self addSubview:_refuseBt];
    
    //164
    DBLog(@"%f",CGRectGetMaxY(_endAddress.frame));
    
    //底部横线
    UIView * lastLine = [[UIView alloc]initWithFrame:CGRectMake(0,170.5, ScreenWidth,0.5)];
    
    lastLine.backgroundColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1];
    //    [self addSubview:lastLine];
}





-(void)setShowMoreBt{
    
    UIImageView * showMore = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 30, 20, 6, 11)];
    showMore.image= [UIImage imageNamed:@"right-image"];
//    [self addSubview:showMore];
}


-(void)waitWorkConfig:(DBWaitWorkModel*)model{
    
    
    //orderType  订单类型，1=短租自驾；2=门到门服务；3=短租代驾; 4=接送机
    
    
    NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:model.expectStartTime];
    NSString * endData = [DBcommonUtils timeWithTimeIntervalString:model.expectEndTime];
    DBLog(@"%@",startdate);
    DBLog(@"%@",endData);
    _startDate.text = [startdate substringWithRange:NSMakeRange(0, 10)];
    _startHour.text = [startdate substringWithRange:NSMakeRange(11, 5)];
    
    _endDate.text= [endData substringWithRange:NSMakeRange(0, 10)];
    _endHour.text = [endData substringWithRange:NSMakeRange(11, 5)];
    _orderNumber.text = [NSString stringWithFormat:@"订单编号: %@",model.orderCode];

    _orderType.text = model.orderTypeName;
    
    
    if ([model.orderType isEqualToString:@"4"])
    {
//        headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.66 blue:0.24 alpha:1];
    }
    else if ([model.orderType isEqualToString:@"3"]){
//        headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.74 blue:0.25 alpha:1];

    }
    else if ([model.orderType isEqualToString:@"2"]){
        _orderType.text = [NSString stringWithFormat:@"门到门-%@",model.taskTypeName];
    }
//
    
    
    if ([model.taskType isEqualToString:@"1"])
    {
        _startAddress.text = model.callOutStoreAddress ;
        _endAddress.text = model.customerAddress ;
    }
    
    else if ([model.taskType isEqualToString:@"2"]){
        _startAddress.text = model.callInStoreAddress ;
        _endAddress.text = model.customerAddress ;
    }
    
    else if ([model.taskType isEqualToString:@"3"]){
        _startAddress.text= model.airport;
        _endAddress.text = model.tripAddress ;
    }
    _carName.text = model.modelName ;

}

-(void)workingConfig:(DBWaitWorkModel*)model{
    
    NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:model.expectStartTime];
    NSString * endData = [DBcommonUtils timeWithTimeIntervalString:model.expectEndTime];
    DBLog(@"%@",startdate);
    DBLog(@"%@",endData);
    _startDate.text = [startdate substringWithRange:NSMakeRange(0, 10)];
    _startHour.text = [startdate substringWithRange:NSMakeRange(11, 5)];
    
    _endDate.text= [endData substringWithRange:NSMakeRange(0, 10)];
    _endHour.text = [endData substringWithRange:NSMakeRange(11, 5)];
    
    _orderType.text = model.orderTypeName;
    _orderNumber.text = [NSString stringWithFormat:@"订单编号: %@",model.orderCode];
//    if ([model.orderType isEqualToString:@"4"])
//    {
//        headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.66 blue:0.24 alpha:1];
//    }
//    else if ([model.orderType isEqualToString:@"3"]){
//        headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.74 blue:0.25 alpha:1];
//        
//    }

    if ([model.orderType isEqualToString:@"2"]){
        _orderType.text = [NSString stringWithFormat:@"门到门-%@",model.taskTypeName];
    }
    
    if ([model.taskType isEqualToString:@"3"]){
        _startAddress.text= model.airport;
        _endAddress.text = model.tripAddress ;

    }
    
    _carName.text = model.modelName ;

}

-(void)finishWorkConfig:(DBWaitWorkModel*)model{
    
    
    NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:model.realStartTime];
    NSString * endData = [DBcommonUtils timeWithTimeIntervalString:model.realEndTime];
    DBLog(@"%@",startdate);
    DBLog(@"%@",endData);
    _startDate.text = [startdate substringWithRange:NSMakeRange(0, 10)];
    _startHour.text = [startdate substringWithRange:NSMakeRange(11, 5)];
    
    _endDate.text= [endData substringWithRange:NSMakeRange(0, 10)];
    _endHour.text = [endData substringWithRange:NSMakeRange(11, 5)];
    _orderNumber.text = [NSString stringWithFormat:@"订单编号: %@",model.orderCode];
//    if ([model.orderType isEqualToString:@"4"])
//    {
//        headView.backgroundColor =[UIColor colorWithRed:0.99 green:0.66 blue:0.24 alpha:1];
//    }
//    else if ([model.orderType isEqualToString:@"3"]){
//        headView.backgroundColor =[UIColor colorWithRed:0.90 green:0.79 blue:0.25 alpha:1];
//        
//    }
    if ([model.taskType isEqualToString:@"1"])
    {
        _startAddress.text = model.taskTypeName  ;
        _endAddress.text = model.callOutStoreAddress ;
    }
    else if ([model.taskType isEqualToString:@"2"]){
        
        _startAddress.text = model.callInStoreAddress ;
        _endAddress.text = model.customerAddress ;

    }
    
    else if ([model.taskType isEqualToString:@"3"]){
        _startAddress.text= model.airport;
        _endAddress.text = model.tripAddress ;

    }
    
    
    _orderType.text = model.orderTypeName;
    _carName.text = model.modelName ;

    if ([model.orderType isEqualToString:@"2"]){
        _orderType.text = [NSString stringWithFormat:@"门到门-%@",model.taskTypeName];
    }
    
    
    self.model = model ;
    
    
    /*
     
    _mileageLabel.frame = CGRectMake(ScreenWidth /2 , CGRectGetMaxY(headView.frame), ScreenWidth/2 - 15, 30);
    
    CGFloat  width  = ScreenWidth/ 3;
    _startAddress.frame = CGRectMake(15, CGRectGetMaxY(_aifPortInfo.frame)+5, width , 40);
     carLine.frame = CGRectMake( CGRectGetMaxX(_startAddress.frame), _startAddress.frame.origin.y + 20, width - 30, 0.5);
    _endAddress.frame =CGRectMake(CGRectGetMaxX(carLine.frame)+5, _startAddress.frame.origin.y, width , 40);
    _carName.frame = CGRectMake(CGRectGetMaxX(_startAddress.frame) , _startAddress.frame.origin.y - 5, width - 30  , 25);
  
  

    _acceptBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _acceptBt.frame = CGRectMake(ScreenWidth -60 , _orderNumber.frame.origin.y + 17, 45, 30);

    [_acceptBt setAttrubutwithTitle:@"" TitleColor:[UIColor whiteColor] BackColor:[UIColor colorWithRed:0.45 green:0.78 blue:0.11 alpha:1] Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    [self addSubview:_acceptBt];
     
        */

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
