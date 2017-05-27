//
//  DBOrderInfoView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBOrderInfoView.h"

@implementation DBOrderInfoView

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
        self.orderDIc = dic ;
        self.model = model ;
        [self setUI];
    }
    return self;
}


-(void)setScrollView{
    
    _detailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _detailScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + 150);
    _detailScrollView.backgroundColor  = [UIColor whiteColor];
    _detailScrollView.showsVerticalScrollIndicator = NO;
    _detailScrollView.showsHorizontalScrollIndicator = NO ;
    _detailScrollView.delegate =self ;
    
    [self addSubview:_detailScrollView ];
    
}

-(void)setUI{
    
    
    
    //订单信息
    [self setScrollView];
    
    UIView *backView  =[[UIView alloc]initWithFrame:CGRectMake(0 ,0, ScreenWidth, 10)];
    
    backView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1] ;
    [_detailScrollView addSubview:backView ];
    
  
    
    //可选服务 背景
    UIView * orderinfo = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backView.frame), ScreenWidth, 35)];
    orderinfo.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake( 0 , 34.5 , ScreenWidth , 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    [orderinfo addSubview:lineView];
    
    [_detailScrollView addSubview:orderinfo ];
    
    
    //可选服务 标题
    UILabel * orderinfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, ScreenWidth, 20)];
     orderinfoLabel.text = @"订单信息";
     orderinfoLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [orderinfo addSubview:orderinfoLabel];
    
    
    
    
    
    
    
    
    //横线
    UIView * toplineView = [[UIView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(orderinfo.frame) - 0.5 , ScreenWidth, 0.5)];
    toplineView.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    [_detailScrollView addSubview:toplineView];
    
    //订单编号
    UILabel * orderLabel = [[UILabel alloc]initWithFrame:CGRectMake( 20, CGRectGetMaxY(toplineView.frame), ScreenWidth / 2 , 25)];
    NSString * orderID = [NSString stringWithFormat:@"订单编号 : %@",[self.orderDIc objectForKey:@"orderId"]];
    
    orderLabel.text = orderID ;
    orderLabel.font = [UIFont systemFontOfSize:12];
    [_detailScrollView addSubview:orderLabel];
    
    
    
    /*
     1
     2 送机
     
     
     3接火车
     4送火车
     */
    
    //订单状态
    UILabel *  orderStatus = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth /2 , orderLabel.frame.origin.y,ScreenWidth /2 - 20 , 30)];

    orderStatus.textAlignment = 2 ;
    if ([[NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"tripType"]]isEqualToString:@"1"]) {
        orderStatus.text = @"订单类型 : 接机";
    }
    if ([[NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"tripType"]]isEqualToString:@"2"]) {
        orderStatus.text = @"订单类型 : 送机";
    }
    if ([[NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"tripType"]]isEqualToString:@"3"]) {
        orderStatus.text =@"订单类型 : 接火车";
    }
    if ([[NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"tripType"]]isEqualToString:@"4"]) {
        orderStatus.text = @"订单类型 : 送火车";
    }
    orderStatus.font = [UIFont systemFontOfSize:12];
    [_detailScrollView addSubview:orderStatus];
    
    
    
    //横线
    UIView * orderlineView = [[UIView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(orderLabel.frame)-0.5 , ScreenWidth, 0.5)];
    orderlineView.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    [_detailScrollView addSubview:orderlineView];
    
    
    
    NSDictionary * vehicleModelShow = [self.orderDIc objectForKey:@"vehicleModelShow"];
    
    
    //创建车辆图片
    UIImageView * imageV = [[UIImageView  alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(orderlineView.frame)+10, 80, 50)];
    
    NSString* encodedString ;
    if (![[vehicleModelShow objectForKey:@"picture"]isKindOfClass:[NSNull class]]) {
         encodedString = [[NSString stringWithFormat:@"%@%@",HOST,[[vehicleModelShow objectForKey:@"picture"]stringByReplacingOccurrencesOfString:@".." withString:@""]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    [imageV sd_setImageWithURL:[NSURL URLWithString: encodedString] placeholderImage:[UIImage imageNamed:@"车@2x"]];
    
    
    [_detailScrollView addSubview:imageV];
    
    
    
    //车辆名称
    UILabel * carName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame)+10, imageV.frame.origin.y + 10 , ScreenWidth - CGRectGetMaxX(imageV.frame) , 15)];
    
    
//    carName.text =  _model.model ;
    //    if (_indexControl == 0 )
    //    {
    //        carName.text = [[self.storeDic objectForKey:@"vehicleModelShow"]objectForKey:@"model"];
    //    }
    //    else if (_indexControl == 1)
    //    {
    //        carName.text = [[self.carInfoDic objectForKey:@"vehicleModelShow"]objectForKey:@"model"];
    //    }
    
    carName.text = [vehicleModelShow objectForKey:@"model"];

    carName.font = [UIFont systemFontOfSize:13];
    [_detailScrollView addSubview:carName];
    
    
    //车辆类型
    UILabel * carkind = [[UILabel alloc]initWithFrame:CGRectMake(carName.frame.origin.x, CGRectGetMaxY(carName.frame)+5, carName.frame.size.width, 11 )];
    
    

    
//    NSString * carGroup ;
//    if (_model.carGroupstr == nil)
//    {
//        carGroup = @"" ;
//    }
//    else
//    {
//        carGroup = _model.carGroupstr;
//    }
//    
//    
//    NSString * trunk ;
//    if (_model.carTrunkStr == nil)
//    {
//        trunk = @"" ;
//    }
//    else
//    {
//        trunk = _model.carTrunkStr ;
//    }
//    
//    NSString * seats ;
//    if (_model.seatsStr == nil)
//    {
//        seats = @"" ;
//    }
//    else
//    {
//        seats = _model.seatsStr ;
//    }
    
//    carkind.text =[NSString stringWithFormat:@"%@ | %@ | %@",carGroup,trunk,seats];
    
    
    
    //    if (_indexControl == 0 )
    //    {
    //        carkind.text =[NSString stringWithFormat:@"自动挡 | %@厢 | %@座 | %@",[[self.storeDic objectForKey:@"vehicleModelShow"]objectForKey:@"carTrunk"],[[self.storeDic objectForKey:@"vehicleModelShow"]objectForKey:@"seats"],[[self.storeDic objectForKey:@"vehicleModelShow"]objectForKey:@"displacement"]];
    //    }
    //    else if (_indexControl == 1)
    //    {
    //        carkind.text =[NSString stringWithFormat:@"自动挡 | %@厢 | %@座 | %@",[[self.carInfoDic objectForKey:@"vehicleModelShow"]objectForKey:@"carTrunk"],[[self.carInfoDic objectForKey:@"vehicleModelShow"]objectForKey:@"seats"],[[self.carInfoDic objectForKey:@"vehicleModelShow"]objectForKey:@"displacement"]];
    //
    //    }
    
    carkind.font = [UIFont systemFontOfSize:11];
    carkind.textColor = [DBcommonUtils getColor:@"9e9e9f"] ;
    [_detailScrollView addSubview:carkind];
    
    

    
    //可选服务 用车人信息
    UIView *  userInfo = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame)+10, ScreenWidth, 35)];
    userInfo.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
    UIView * userInfolineView = [[UIView alloc]initWithFrame:CGRectMake( 0 , 34.5 , ScreenWidth , 0.5)];
    userInfolineView.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    [userInfo addSubview:userInfolineView];
    
    [_detailScrollView addSubview:userInfo];
    
    
    //可选服务 标题
    UILabel * userInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, ScreenWidth, 20)];
    userInfoLabel.text = @"用车人信息";
    userInfoLabel.font = [UIFont boldSystemFontOfSize:14];
    [userInfo addSubview:userInfoLabel];
    
    
    
    //车辆费用
    UILabel * carCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(userInfo.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel.text = @"用车人姓名";
    carCostLabel.numberOfLines = 0 ;
    carCostLabel.font = [ UIFont systemFontOfSize:12];
    
    carCostLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostLabel];
    
    
    
    //
//    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(carCostLabel.frame)+10,CGRectGetMaxY(mustCost.frame) + 10 , 0.5 , 20)];
//    lineView1.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
//    
//    [_detailScrollView addSubview:lineView1];
//    

    
    
    //车辆总费用
    UILabel * carCostTotal = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel.frame.origin.y, ScreenWidth / 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal.textAlignment = 0;
    carCostTotal.text = [self.orderDIc objectForKey:@"passengerName"];
    carCostTotal.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];

    [_detailScrollView addSubview:carCostTotal];
    

    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel.frame) , ScreenWidth , 0.5)];
    lineView2.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView2];
    
    
    
    //费用合计
    UILabel * totleCostLabel = [[UILabel alloc]initWithFrame:CGRectMake(carCostLabel.frame.origin.x, CGRectGetMaxY(carCostLabel.frame), ScreenWidth / 3 - 40 , 35)];
    
    totleCostLabel.text = @"用车人电话";
    totleCostLabel.numberOfLines = 0 ;
    totleCostLabel.font = [ UIFont systemFontOfSize:12];
    
    totleCostLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:totleCostLabel];
    
    
    //
//    UIView * lineView7 = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(totleCostLabel.frame)+10,totleCostLabel.frame.origin.y + 10 , 0.5 , 20)];
//    lineView7.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
//    
//    [_detailScrollView addSubview:lineView7];
    
    
    //费用合计
    UILabel * totleCost = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 , totleCostLabel.frame.origin.y, ScreenWidth / 3 - 20,  carCostLabel.frame.size.height)];
    
    totleCost.text =[self.orderDIc objectForKey:@"passengerPhone"];
    totleCost.numberOfLines = 0 ;
    totleCost.font = [ UIFont systemFontOfSize:12];
    
    totleCost.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];

    [_detailScrollView addSubview:totleCost];
    
    //
    UIView * lineView8 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(totleCost.frame) , ScreenWidth , 0.5)];
    lineView8.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView8];
    

    
    
    
    //行程备注
    UILabel * carCostLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView8.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel1.text = @"行程备注";
    carCostLabel1.numberOfLines = 0 ;
    carCostLabel1.font = [ UIFont systemFontOfSize:12];
    
    carCostLabel1.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostLabel1];
    
    
    
    //
    //    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMaxX(carCostLabel.frame)+10,CGRectGetMaxY(mustCost.frame) + 10 , 0.5 , 20)];
    //    lineView1.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    //
    //    [_detailScrollView addSubview:lineView1];
    //
    
    
    
    //备注
    UILabel * carCostTotal1 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 , carCostLabel1.frame.origin.y, ScreenWidth * 2 / 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal1.textAlignment = 0;
    carCostTotal1.text = [self.orderDIc objectForKey:@"tripRemark"];
    carCostTotal1.font = [ UIFont systemFontOfSize:12];
    carCostTotal1.adjustsFontSizeToFitWidth = YES ;
    carCostTotal1.numberOfLines = 0 ;
    
    carCostTotal1.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal1];
    
    
    UIView * lineView21 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel1.frame) , ScreenWidth , 0.5)];
    lineView21.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView21];

    
    
    
    //可选服务 预定信息
    UIView *  userInfo1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView21.frame), ScreenWidth, 35)];
    userInfo1.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
    UIView * userInfolineView1 = [[UIView alloc]initWithFrame:CGRectMake( 0 , 34.5 , ScreenWidth , 0.5)];
    userInfolineView1.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    [userInfo1 addSubview:userInfolineView1];
    
    [_detailScrollView addSubview:userInfo1];
    
    
    //可选服务 预定信息
    UILabel * userInfoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 7, ScreenWidth, 20)];
    userInfoLabel1.text = @"预定信息";
    userInfoLabel1.font = [UIFont boldSystemFontOfSize:14];
    
    [userInfo1 addSubview:userInfoLabel1];
    
    
    //城市
    UILabel * carCostLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(userInfo1.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel2.text = @"用车城市";
    carCostLabel2.numberOfLines = 0 ;
    carCostLabel2.font = [ UIFont systemFontOfSize:12];
    
    carCostLabel2.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostLabel2];
    
    
    
    //车辆总费用
    UILabel * carCostTotal2 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth / 3 , carCostLabel2.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal2.textAlignment = 0;
    carCostTotal2.text = [self.orderDIc objectForKey:@"takeCarCity"];
    carCostTotal2.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal2.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal2];
    
    
    UIView * lineView22 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel2.frame) , ScreenWidth , 0.5)];
    lineView22.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView22];
    
    
    //机场
    UILabel * carCostLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView22.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel3.text = @"机场";
    carCostLabel3.numberOfLines = 0 ;
    carCostLabel3.font = [ UIFont systemFontOfSize:12];
    
    carCostLabel3.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostLabel3];
    NSDictionary * transferPointShow =  [self.orderDIc objectForKey:@"transferPointShow"];
    
    
    //车辆总费用
    UILabel * carCostTotal3 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel3.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    
    carCostTotal3.textAlignment = 0;
    carCostTotal3.text = [transferPointShow objectForKey:@"pointName"];
    carCostTotal3.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal3.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal3];
    UIView * lineView23 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel3.frame) , ScreenWidth , 0.5)];
    lineView23.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView23];

    //航空公司
    UILabel * carCostLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView23.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel4.text = @"航空公司";
    carCostLabel4.numberOfLines = 0 ;
    carCostLabel4.font = [ UIFont systemFontOfSize:12];
    carCostLabel4.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel4];
    

    //车辆总费用
    UILabel * carCostTotal4 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel4.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal4.textAlignment = 0;
    carCostTotal4.text = [self.orderDIc objectForKey:@"airlineCompany"];
    carCostTotal4.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal4.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal4];
    
    
    UIView * lineView24 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel4.frame) , ScreenWidth , 0.5)];
    lineView24.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView24];

    
    //航班号
    UILabel * carCostLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView24.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel5.text = @"航班号";
    carCostLabel5.numberOfLines = 0 ;
    carCostLabel5.font = [ UIFont systemFontOfSize:12];
    carCostLabel5.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel5];
    
    
    
    //车辆总费用
    UILabel * carCostTotal5 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel5.frame.origin.y,ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal5.textAlignment = 0;
    carCostTotal5.text = [self.orderDIc objectForKey:@"flightNumber"];
    carCostTotal5.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal5.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal5];
    
    
    UIView * lineView25 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel5.frame) , ScreenWidth , 0.5)];
    lineView25.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView25];
    
    
    //用车时间
    UILabel * carCostLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView25.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel6.text = @"用车时间";
    carCostLabel6.numberOfLines = 0 ;
    carCostLabel6.font = [ UIFont systemFontOfSize:12];
    carCostLabel6.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel6];
    
    
     NSString * startdate = [DBcommonUtils timeWithTimeIntervalString: [NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"takeCarDate"] ]];
    
    
    //车辆总费用
    UILabel * carCostTotal6 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel6.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal6.textAlignment = 0;
    carCostTotal6.text = [startdate substringWithRange:NSMakeRange(0,17 )];
    carCostTotal6.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal6.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal6];
    
    
    UIView * lineView26 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel6.frame) , ScreenWidth , 0.5)];
    lineView26.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView26];
    
    
    
    //下车地址
    UILabel * carCostLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView26.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel7.text = @"下车地址";
    carCostLabel7.numberOfLines = 0 ;
    carCostLabel7.font = [ UIFont systemFontOfSize:12];
    carCostLabel7.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel7];
    
    if ([[NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"tripType"]]isEqualToString:@"2"]) {
        carCostLabel7.text = @"上车地址";

    }
    
    
    
    
    //车辆总费用
    UILabel * carCostTotal7 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel7.frame.origin.y, ScreenWidth  * 2/ 3 - 20, 35)];
    
    carCostTotal7.textAlignment = 0;
    carCostTotal7.text = [self.orderDIc objectForKey:@"tripAddress"];
    carCostTotal7.font = [ UIFont systemFontOfSize:12];
    carCostTotal7.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    carCostTotal7.numberOfLines = 2 ;
    carCostTotal7.adjustsFontSizeToFitWidth = YES ;
    [_detailScrollView addSubview:carCostTotal7];
    
    
    UIView * lineView27 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel7.frame) , ScreenWidth , 0.5)];
    lineView27.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView27];
    
    //预估里程
    UILabel * carCostLabel8 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView27.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel8.text = @"预估里程";
    carCostLabel8.numberOfLines = 0 ;
    carCostLabel8.font = [ UIFont systemFontOfSize:12];
    carCostLabel8.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel8];
    
    
    
    //车辆总费用
    UILabel * carCostTotal8= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel8.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal8.textAlignment = 0;
    
    if ([[self.orderDIc allKeys]containsObject:@"tripDistance"]) {
        
        if ([[self.orderDIc objectForKey:@"tripDistance"]isKindOfClass:[NSNull class]]) {
            
            carCostTotal8.text = @"";
            
        }
        else{
            carCostTotal8.text = [NSString stringWithFormat:@"%@公里",[self.orderDIc objectForKey:@"tripDistance"]];
            
        }

    }
    
    carCostTotal8.font = [ UIFont systemFontOfSize:12];
    
    carCostTotal8.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal8];
    
    
    UIView * lineView28 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel8.frame) , ScreenWidth , 0.5)];
    lineView28.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView28];
    
    
    
    
    //订单描述
    UILabel * carCostLabel9 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView28.frame), ScreenWidth / 3 - 40 , 35)];
    carCostLabel9.text = @"订单描述";
    carCostLabel9.numberOfLines = 0 ;
    carCostLabel9.font = [ UIFont systemFontOfSize:12];
    carCostLabel9.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    [_detailScrollView addSubview:carCostLabel9];
    
    
    
    //车辆总费用
    UILabel * carCostTotal9 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth  / 3 , carCostLabel9.frame.origin.y, ScreenWidth  * 2/ 3 - 20, carCostLabel.frame.size.height)];
    
    carCostTotal9.textAlignment = 0;
    carCostTotal9.text = [self.orderDIc objectForKey:@"airDescribe"];
    carCostTotal9.font = [ UIFont systemFontOfSize:12];
    carCostTotal9.adjustsFontSizeToFitWidth = YES ;
    carCostTotal9.numberOfLines = 0 ;
    
    carCostTotal9.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    
    [_detailScrollView addSubview:carCostTotal9];
    
    
    UIView * lineView29 = [[UIView alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carCostLabel9.frame) , ScreenWidth , 0.5)];
    lineView29.backgroundColor = [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
    
    [_detailScrollView addSubview:lineView29];
    

    
    //显示更多车辆按钮
    UIButton * showCarBt = [UIButton buttonWithType:UIButtonTypeCustom];
    showCarBt.frame = CGRectMake(50, CGRectGetMaxY(lineView29.frame)+20 , ScreenWidth - 100  , 30 );
    
    [showCarBt setTitle:@"确定" forState:UIControlStateNormal];
    [showCarBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    showCarBt.titleLabel.font = [UIFont systemFontOfSize:12 ];
    showCarBt.layer.cornerRadius = 5 ;
    showCarBt.backgroundColor =[UIColor colorWithRed:0.95 green:0.78 blue:0.11 alpha:1];
    [showCarBt addTarget:self action:@selector(cancelBt:) forControlEvents:UIControlEventTouchUpInside];
    [_detailScrollView addSubview:showCarBt];
    
    if ([self.model.orderType isEqualToString:@"3"]) {
        
        carCostLabel3.text = @"用车时间";
        carCostTotal3.text = [startdate substringWithRange:NSMakeRange(0,17 )];
        
        
        carCostLabel4.text = @"上车地址";
        carCostTotal4.text = [NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"takeCarAddress"]];
        
        
        carCostLabel5.text = @"下车地址";
        carCostTotal5.text = [NSString stringWithFormat:@"%@",[self.orderDIc objectForKey:@"returnCarAddress"]];

        
        carCostLabel6.text = @"预估里程";
        if ([[self.orderDIc allKeys]containsObject:@"outsideDistance"]) {
            
            if ([[self.orderDIc objectForKey:@"outsideDistance"]isKindOfClass:[NSNull class]]) {
                
                carCostTotal6.text = @"";
            }
            else{
                carCostTotal6.text = [NSString stringWithFormat:@"%@公里",[self.orderDIc objectForKey:@"outsideDistance"]];
            }
            
        }
        else{
            carCostTotal6.text = @"0公里";
        }
        
        carCostLabel7.hidden = YES ;
        carCostTotal7.hidden = YES ;
        lineView27.hidden = YES ;
        
        carCostLabel8.hidden = YES ;
        carCostTotal8.hidden = YES ;
        lineView28.hidden = YES ;
        
        carCostLabel9.hidden = YES ;
        carCostTotal9.hidden = YES ;
        lineView29.hidden = YES ;

        showCarBt.frame = CGRectMake(50, CGRectGetMaxY(lineView26.frame)+20 , ScreenWidth - 100  , 30 );

    }
    
    
    
    
    
    
    
    
    
  
}

-(void)cancelBt:(UIButton*)button{
    
    [DBcommonUtils pushControllerFrome:nil toController:nil];
    
}


@end
