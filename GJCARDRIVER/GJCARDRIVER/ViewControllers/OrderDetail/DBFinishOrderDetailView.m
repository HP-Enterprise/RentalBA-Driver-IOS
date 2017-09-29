//
//  DBFinishOrderDetailView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/14.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBFinishOrderDetailView.h"

@implementation DBFinishOrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame withData:(NSDictionary*)dic withOder:(NSString*)orderId withModel:(DBWaitWorkModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.model = dic ;
        self.orderId =orderId ;
        self.dataModel = model ;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    UIView * headerView = [[ UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
    headerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1] ;
    [self addSubview:headerView];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
  
    //调度单编号
    _orderNumber = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headerView.frame), self.frame.size.width - 15, 30)];
    [_orderNumber setAttrubutwithText:[NSString stringWithFormat:@"订单编号  %@",self.orderId] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [self addSubview:self.orderNumber];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderNumber.frame), self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
;
    [self addSubview:line];
    
    //开始时间
    _startDate = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+15, self.frame.size.width/3, 10)];
   
  
    [self addSubview:_startDate];
    
    _startHour  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startDate.frame)+10, self.frame.size.width/3, 20)];

    [self addSubview:_startHour];
    
    //开始地点
    _startAddress = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_startHour.frame)+5, self.frame.size.width/2 -30, 30)];

        _startAddress.numberOfLines = 2;
    [self addSubview:_startAddress];

   
    
    //结束时间
    _endDate = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*2/3, CGRectGetMaxY(line.frame)+15, self.frame.size.width/3, 10)];

    [self addSubview:_endDate];
    
    _endHour  = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*2/3, CGRectGetMaxY(_startDate.frame)+10, self.frame.size.width/3, 20)];
       [self addSubview:_endHour];
    
    //结束地点
    _endAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+15, CGRectGetMaxY(_startHour.frame)+5, self.frame.size.width/2 -30, 30)];
   
    _endAddress.numberOfLines = 2;
    [self addSubview:_endAddress];
    
    
    
    
   
    
    
    
    
    
    //中间车型
    _carName = [[UILabel alloc]initWithFrame:CGRectMake(self.startHour.frame.size.width, self.startHour.frame.origin.y-10, self.startHour.frame.size.width , 28)];
    [_carName setAttrubutwithText:[[self.model objectForKey:@"vehicleModelShow"]objectForKey:@"model"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
    _carName.numberOfLines = 2;
    [self addSubview:_carName];
    
    UIView * carLine = [[UIView alloc]initWithFrame:CGRectMake(self.carName.frame.origin.x, CGRectGetMaxY(_carName.frame) , _carName.frame.size.width,0.5)];
    
    carLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [self addSubview:carLine];
    
    //底部横线
    UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_startAddress.frame) +5, self.frame.size.width,0.5)];
    
    bottomLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];

    [self addSubview:bottomLine];
    
    
    
//油量纪录
    UIView * oilView = [[ UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomLine.frame), self.frame.size.width, 10)];
    oilView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1] ;
    [self addSubview:oilView];
    
    
    UIView * oilBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oilView.frame), ScreenWidth, 120)];
    [self addSubview:oilBackView];
    
    
    UIView * oilTopLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width,0.5)];
    
    oilTopLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
;
    [oilBackView addSubview:oilTopLine];

    
    UIView * oilbottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 119.5, self.frame.size.width,0.5)];
    
    oilbottomLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
;
    [oilBackView addSubview:oilbottomLine];

    
    UIImageView * oilImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 52, 16, 16)];
    oilImage.image = [UIImage imageNamed:@"oil"];
    [oilBackView addSubview:oilImage];
    
    
    CGSize Foursize = [DBcommonUtils calculateStringLenth:@"油量纪录" withWidth:ScreenWidth withFontSize:12];
    
    UILabel * OilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oilImage.frame)+10, 0, Foursize.width, 120)];
    [OilLabel setAttrubutwithText:@"油量纪录" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:OilLabel];
    
    
    
    //提车油量
    UILabel * takeOil = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, 0, Foursize.width, 30)];
    [takeOil setAttrubutwithText:@"提车油量" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:takeOil];

    UIView * takeOilLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(takeOil.frame)+10, 8, 0.5, 14)];
    takeOilLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]; ;
    [oilBackView addSubview:takeOilLine];
    
    
    UILabel * takeOilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(takeOilLine.frame)+12, 0, ScreenWidth - CGRectGetMaxX(takeOilLine.frame), 30)];
    [oilBackView addSubview:takeOilLabel];
    
    
    
    UILabel * takeOilBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(takeOil.frame.origin.x- 5, 30, ScreenWidth - takeOil.frame.origin.x - 20, 0.5)];
    takeOilBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:takeOilBottomLine];
    
    
    
    
    UILabel * startOil = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, CGRectGetMaxY(takeOilBottomLine.frame), Foursize.width, 30)];
    [startOil setAttrubutwithText:@"上车油量" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:startOil];
    
    UIView * startLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10, + CGRectGetMaxY(takeOilBottomLine.frame)+ 8, 0.5, 14)];
    startLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]; ;
    [oilBackView addSubview:startLine];
    
    
    UILabel * oilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(takeOilBottomLine.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    [oilBackView addSubview:oilLabel];
    
    
    
    UILabel * oilBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startOil.frame.origin.x- 5,  2*30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    oilBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:oilBottomLine];
    
    
    
    //下车油量
    
    UILabel * endOil = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, CGRectGetMaxY(startOil.frame), Foursize.width, 30)];
    [endOil setAttrubutwithText:@"下车油量" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:endOil];
    
    UIView * endLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10,CGRectGetMaxY(startOil.frame)+ 8, 0.5, 14)];
    endLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:endLine];
    
    
    UILabel * endoilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(startOil.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    
    [oilBackView addSubview:endoilLabel];
    
    
    
    
    UILabel * endoilBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startOil.frame.origin.x- 5,  3*30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    endoilBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:endoilBottomLine];

    
    
    
    
    
    //下车油量
    
    UILabel * returnOil = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, CGRectGetMaxY(endoilBottomLine.frame), Foursize.width, 30)];
    [returnOil setAttrubutwithText:@"还车油量" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:returnOil];
    
    UIView * returnOilLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10,CGRectGetMaxY(endoilBottomLine.frame)+ 8, 0.5, 14)];
    returnOilLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:returnOilLine];
    
    
    UILabel * returnoilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(endoilBottomLine.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    
    [oilBackView addSubview:returnoilLabel];
    
    
    
    
    
    
    
    
    
//里程纪录
    UIView * mileageView = [[ UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oilBackView.frame), self.frame.size.width, 10)];
    mileageView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1] ;
    [self addSubview:mileageView];
    
    
    
    UIView * mileageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mileageView.frame), ScreenWidth, 120)];
    [self addSubview:mileageBackView];
    
    
    UIView * mileageTopLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width,0.5)];
    
    mileageTopLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
;
    [mileageBackView addSubview:mileageTopLine];
    
    
    UIView * mileagebottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 119.5, self.frame.size.width,0.5)];
    
    mileagebottomLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
;
    [mileageBackView addSubview:mileagebottomLine];
    
    
    UIImageView * mileageImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 52, 16, 16)];
    mileageImage.image = [UIImage imageNamed:@"mileage"];
    [mileageBackView addSubview:mileageImage];
    
    
    
    UILabel * mileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mileageImage.frame)+10, 0, Foursize.width, 120)];
    [mileageLabel setAttrubutwithText:@"里程纪录" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:mileageLabel];
    
    
    
    
    //取车
    UILabel *  takemileage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, 0, Foursize.width, 30)];
    [takemileage setAttrubutwithText:@"提车里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:takemileage];
    
    UIView * takemileageLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(takemileage.frame)+10, 8, 0.5, 14)];
    takemileageLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:takemileageLine];
    
    
    UILabel * takemileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(takemileageLine.frame)+12, 0, ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    [mileageBackView addSubview:takemileageLabel];
    
    
    
    UILabel * takemileageBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(takemileage.frame.origin.x- 5, 30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    takemileageBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:takemileageBottomLine];

    
    
    
    //上车里程
    
    UILabel * startmileage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20,  CGRectGetMaxY(takemileageBottomLine.frame), Foursize.width, 30)];
    [startmileage setAttrubutwithText:@"上车里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:startmileage];
    
    UIView * mileageLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startmileage.frame)+10,CGRectGetMaxY(takemileageBottomLine.frame)+ 8, 0.5, 14)];
    mileageLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:mileageLine];
    
    
    UILabel * startmileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(takemileageBottomLine.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
        [mileageBackView addSubview:startmileageLabel];
    
    
    
    UILabel * mileageBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startmileage.frame.origin.x- 5,2* 30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    mileageBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:mileageBottomLine];
    
    
    if([self.dataModel.orderType isEqualToString:@"4"]){
        
        mileageImage.frame = CGRectMake(20, 37, 16, 16) ;
        mileageLabel.frame = CGRectMake(CGRectGetMaxX(mileageImage.frame)+10, 0, Foursize.width, 90) ;
        mileagebottomLine.frame = CGRectMake(0, 89.5, self.frame.size.width,0.5);

        
        mileageBackView.frame = CGRectMake(0, CGRectGetMaxY(mileageView.frame), ScreenWidth, 90) ;
        takemileage.hidden = YES ;
        takemileageBottomLine.hidden = YES ;
        takemileageLabel.hidden = YES ;
        takemileageLine.hidden = YES ;
        
        startmileage.frame = CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, 0, Foursize.width, 30);
        mileageLine.frame = CGRectMake(CGRectGetMaxX(takemileage.frame)+10, 8, 0.5, 14) ;
        
        startmileageLabel.frame = CGRectMake(CGRectGetMaxX(takemileageLine.frame)+12, 0, ScreenWidth - CGRectGetMaxX(startLine.frame), 30) ;
        mileageBottomLine.frame = CGRectMake(takemileage.frame.origin.x- 5, 30, ScreenWidth - startOil.frame.origin.x - 20, 0.5) ;
        
        
    }
    
    //下车
    
    UILabel * endmileage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, CGRectGetMaxY(startmileage.frame), Foursize.width, 30)];
    [endmileage setAttrubutwithText:@"下车里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:endmileage];
    
    UIView * endmileageLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10,CGRectGetMaxY(startmileage.frame)+ 8, 0.5, 14)];
    endmileageLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];

    [mileageBackView addSubview:endmileageLine];
    
    
    UILabel * endmileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(startmileage.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
        [mileageBackView addSubview:endmileageLabel];
    
    
    UILabel * endmileageBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startmileage.frame.origin.x- 5,CGRectGetMaxY(endmileage.frame), ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    endmileageBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:endmileageBottomLine];

    
    
    
    
    UILabel * returnmileage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(OilLabel.frame)+20, CGRectGetMaxY(endmileage.frame), Foursize.width, 30)];
    [returnmileage setAttrubutwithText:@"还车里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:returnmileage];
    
    UIView * returnmileageLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10,CGRectGetMaxY(endmileageBottomLine.frame)+ 8, 0.5, 14)];
    returnmileageLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    
    [mileageBackView addSubview:returnmileageLine];
    
    
    UILabel * returnmileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, returnmileage.frame.origin.y, ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    [mileageBackView addSubview:returnmileageLabel];

    
    
    if([self.dataModel.orderType isEqualToString:@"4"]){
        [returnmileage setAttrubutwithText:@"行驶里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    }
    
    

    //送车回门店
    if ([self.dataModel.taskType isEqualToString:@"2"]) {
        
        NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:self.dataModel.realStartTime];
        NSString * endData = [DBcommonUtils timeWithTimeIntervalString:self.dataModel.realEndTime];
        DBLog(@"%@",startdate);
        DBLog(@"%@",endData);
        
        [_startDate setAttrubutwithText:[startdate substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_startHour setAttrubutwithText:[startdate substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endDate setAttrubutwithText:[endData substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endHour setAttrubutwithText:[endData  substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];

        
        
        [oilLabel setAttrubutwithText:[self.model objectForKey:@"clientReturnCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [endoilLabel setAttrubutwithText:[self.model objectForKey:@"returnCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [startmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientReturnCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [endmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"returnCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [_startAddress setAttrubutwithText:[self.model objectForKey:@"clientReturnCarAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [_endAddress setAttrubutwithText:[self.model objectForKey:@"returnCarAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
      
        
    }
    //取车给客户
    else if([self.dataModel.taskType isEqualToString:@"1"])
    {
        //取车
        NSDate * takeCarDate =  [NSDate dateWithTimeIntervalSince1970:[[self.model objectForKey:@"takeCarDate"]integerValue]/1000];
        NSString *  takeCarString = [formatter stringFromDate:takeCarDate];
        
        //上车
        NSDate * update =  [NSDate dateWithTimeIntervalSince1970:[[self.model objectForKey:@"clientTakeCarDate"]integerValue]/1000];
        NSString *  updateString = [formatter stringFromDate:update];

        [_startDate setAttrubutwithText:[takeCarString substringWithRange:NSMakeRange(0, 10)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
       
        [_startHour setAttrubutwithText:[takeCarString substringWithRange:NSMakeRange(11, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endDate setAttrubutwithText:[updateString substringWithRange:NSMakeRange(0, 10)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endHour setAttrubutwithText:[updateString substringWithRange:NSMakeRange(11, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];

        [oilLabel setAttrubutwithText:[self.model objectForKey:@"takeCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];

        [endoilLabel setAttrubutwithText:[self.model objectForKey:@"clientTakeCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [startmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"takeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
       
        [endmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientTakeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];

        [_startAddress setAttrubutwithText:[self.model objectForKey:@"takeCarAddress"]withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
//        [_endAddress setAttrubutwithText:[self.model objectForKey:@"returnCarAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];

    }
    
    //接送机
    else if([self.dataModel.taskType isEqualToString:@"3"] || [self.dataModel.taskType isEqualToString:@"4"]){

        NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:self.dataModel.realStartTime];
        NSString * endData = [DBcommonUtils timeWithTimeIntervalString:self.dataModel.realEndTime];
        DBLog(@"%@",startdate);
        DBLog(@"%@",endData);
        
        [_startDate setAttrubutwithText:[startdate substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_startHour setAttrubutwithText:[startdate substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endDate setAttrubutwithText:[endData substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endHour setAttrubutwithText:[endData  substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];

        [oilLabel setAttrubutwithText:[self.model objectForKey:@"clientUpFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [endoilLabel setAttrubutwithText:[self.model objectForKey:@"clientDownFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
       
        if ([self.dataModel.orderType isEqualToString:@"3"]) {
            
             [takeOilLabel setAttrubutwithText:[self.model objectForKey:@"driverTakeCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
//            [takemileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ km",[self.model objectForKey:@"driverTakeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
            [takemileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"takeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        }
        else{
            
            if (![[self.model objectForKey:@"takeCarFuel"]isKindOfClass:[NSNull class]]) {
                 [takeOilLabel setAttrubutwithText:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"takeCarFuel"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
            }
            
//            [takemileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[NSString stringWithFormat:@"%@",[self.model objectForKey:@"takeCarMileage"]]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        }
        
        if (![[self.model objectForKey:@"returnCarFuel"]isKindOfClass:[NSNull class]]) {
            [returnoilLabel setAttrubutwithText:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"returnCarFuel"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        }
        
        [startmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientUpMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [endmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientDownMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        
        
        NSInteger mileage = [[self.model objectForKey:@"clientDownMileage"]integerValue] - [[self.model objectForKey:@"clientUpMileage"]integerValue] ;
        
        
        if ([self.dataModel.orderType isEqualToString:@"4"]) {
            [returnmileageLabel  setAttrubutwithText:[NSString stringWithFormat:@"%ld 公里",mileage] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        }
        else{
            [returnmileageLabel  setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"returnCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        }
        

        
  //地址
        
        
        if ([[NSString stringWithFormat:@"%@",[self.model objectForKey:@"tripType"]]isEqualToString:@"1"]) {
            [_startAddress setAttrubutwithText:[[self.model objectForKey:@"transferPointShow"]objectForKey:@"pointName"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
            
            [_endAddress setAttrubutwithText:[self.model objectForKey:@"clientActualDebusAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
        }
        else if ([[NSString stringWithFormat:@"%@",[self.model objectForKey:@"tripType"]]isEqualToString:@"2"]){
            
            [_startAddress setAttrubutwithText:[self.model objectForKey:@"tripAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
//            [_endAddress setAttrubutwithText:[[self.model objectForKey:@"transferPointShow"]objectForKey:@"pointName"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
            [_endAddress setAttrubutwithText:[self.model objectForKey:@"clientActualDebusAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
        }

        if (![[self.model allKeys]containsObject:@"tripType"]) {
            [_startAddress setAttrubutwithText:[self.model objectForKey:@"takeCarAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
            
            [_endAddress setAttrubutwithText:[self.model objectForKey:@"returnCarAddress"] withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];

            if ([[NSString stringWithFormat:@"%@",[self.model objectForKey:@"orderState"]]isEqualToString:@"7"] || [[NSString stringWithFormat:@"%@",[self.model objectForKey:@"orderState"]]isEqualToString:@"6"]) {
                
                if ([[self.model allKeys]containsObject:@"clientActualDebusAddress"]) {
                    
                    if (![[self.model objectForKey:@"clientActualDebusAddress"]isKindOfClass:[NSNull class]]) {
                        _endAddress.text = [NSString stringWithFormat:@"%@",[self.model objectForKey:@"clientActualDebusAddress"] ];

                    }
                }
            }
        }
    }

}
@end
