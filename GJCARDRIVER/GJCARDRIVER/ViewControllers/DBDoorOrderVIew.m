//
//  DBDoorOrderVIew.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/6/15.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBDoorOrderVIew.h"

@implementation DBDoorOrderVIew

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
    
    
    
    
    
    UIView * oilBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oilView.frame), ScreenWidth, 60)];
    [self addSubview:oilBackView];
    
    
    UIView * oilTopLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width,0.5)];
    
    oilTopLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    ;
    [oilBackView addSubview:oilTopLine];
    
    
    UIView * oilbottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, self.frame.size.width,0.5)];
    
    oilbottomLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    ;
    [oilBackView addSubview:oilbottomLine];
    
    
    UIImageView * oilImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 22, 16, 16)];
    oilImage.image = [UIImage imageNamed:@"oil"];
    [oilBackView addSubview:oilImage];
    
    
    CGSize Foursize = [DBcommonUtils calculateStringLenth:@"油量纪录" withWidth:ScreenWidth withFontSize:12];
    
    UILabel * OilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oilImage.frame)+10, 0, Foursize.width, 60)];
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
    [startOil setAttrubutwithText:@"还车油量" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [oilBackView addSubview:startOil];
    
    UIView * startLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startOil.frame)+10, + CGRectGetMaxY(takeOilBottomLine.frame)+ 8, 0.5, 14)];
    startLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]; ;
    [oilBackView addSubview:startLine];
    
    
    UILabel * oilLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(takeOilBottomLine.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    [oilBackView addSubview:oilLabel];
    
    
    
    UILabel * oilBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startOil.frame.origin.x- 5,  2*30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    oilBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [oilBackView addSubview:oilBottomLine];
    
    

    
    //里程纪录
    UIView * mileageView = [[ UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oilBackView.frame), self.frame.size.width, 10)];
    mileageView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1] ;
    [self addSubview:mileageView];
    
    
    
    UIView * mileageBackView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mileageView.frame), ScreenWidth, 60)];
    [self addSubview:mileageBackView];
    
    
    UIView * mileageTopLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width,0.5)];
    
    mileageTopLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    ;
    [mileageBackView addSubview:mileageTopLine];
    
    
    UIView * mileagebottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, self.frame.size.width,0.5)];
    
    mileagebottomLine.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    ;
    [mileageBackView addSubview:mileagebottomLine];
    
    
    UIImageView * mileageImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 22, 16, 16)];
    mileageImage.image = [UIImage imageNamed:@"mileage"];
    [mileageBackView addSubview:mileageImage];
    
    
    
    UILabel * mileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mileageImage.frame)+10, 0, Foursize.width, 60)];
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
    [startmileage setAttrubutwithText:@"还车里程" withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
    [mileageBackView addSubview:startmileage];
    
    UIView * mileageLine =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startmileage.frame)+10,CGRectGetMaxY(takemileageBottomLine.frame)+ 8, 0.5, 14)];
    mileageLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:mileageLine];
    
    
    UILabel * startmileageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(startLine.frame)+12, CGRectGetMaxY(takemileageBottomLine.frame), ScreenWidth - CGRectGetMaxX(startLine.frame), 30)];
    [mileageBackView addSubview:startmileageLabel];
    
    
    
    UILabel * mileageBottomLine = [[UILabel alloc]initWithFrame:CGRectMake(startmileage.frame.origin.x- 5,2* 30, ScreenWidth - startOil.frame.origin.x - 20, 0.5)];
    mileageBottomLine.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
    [mileageBackView addSubview:mileageBottomLine];
    
    
    
    //送车给客户
    if ([self.dataModel.taskType isEqualToString:@"1"]) {
        
        NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"takeCarDate"]]];
        NSString * endData = [DBcommonUtils timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"clientTakeCarDate"]]];

        DBLog(@"%@",startdate);
        DBLog(@"%@",endData);
        
        [_startDate setAttrubutwithText:[startdate substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_startHour setAttrubutwithText:[startdate substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endDate setAttrubutwithText:[endData substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endHour setAttrubutwithText:[endData  substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        
        [takeOilLabel setAttrubutwithText:[self.model objectForKey:@"takeCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [oilLabel setAttrubutwithText:[self.model objectForKey:@"clientTakeCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        

        [takemileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"takeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];

        [startmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientTakeCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];

        
        [_startAddress setAttrubutwithText:self.dataModel.callOutStoreAddress withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [_endAddress setAttrubutwithText:self.dataModel.customerAddress withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
        
        
    }
    //还车门店
    else if([self.dataModel.taskType isEqualToString:@"2"])
    {
        NSString * startdate = [DBcommonUtils timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"takeCarDate"]]];
        NSString * endData = [DBcommonUtils timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",[self.model objectForKey:@"clientTakeCarDate"]]];
        
        DBLog(@"%@",startdate);
        DBLog(@"%@",endData);
        
        [_startDate setAttrubutwithText:[startdate substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_startHour setAttrubutwithText:[startdate substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endDate setAttrubutwithText:[endData substringWithRange:NSMakeRange(0, 11)] withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        [_endHour setAttrubutwithText:[endData  substringWithRange:NSMakeRange(12, 5)] withFont:16 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:1];
        
        
        [takeOilLabel setAttrubutwithText:[self.model objectForKey:@"clientReturnCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [oilLabel setAttrubutwithText:[self.model objectForKey:@"returnCarFuel"] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        
        
        [takemileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"clientReturnCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [startmileageLabel setAttrubutwithText:[NSString stringWithFormat:@"%@ 公里",[self.model objectForKey:@"returnCarMileage"]] withFont:11 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [_startAddress setAttrubutwithText:self.dataModel.customerAddress withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:0];
        
        [_endAddress setAttrubutwithText:self.dataModel.callInStoreAddress withFont:10 withBackColor:nil withTextColor:[UIColor colorWithRed:0.34 green:0.34 blue:0.35 alpha:1] withTextAlignment:2];
        
    }

    DBLog(@"%f",CGRectGetMaxY(mileageBackView.frame));
    
}

@end
