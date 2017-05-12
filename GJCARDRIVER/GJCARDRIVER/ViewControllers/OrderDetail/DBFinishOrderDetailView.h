//
//  DBFinishOrderDetailView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/14.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBWaitWorkModel.h"


@interface DBFinishOrderDetailView : UIView


@property (nonatomic,strong)DBWaitWorkModel * dataModel ;
@property (nonatomic,strong)UILabel * orderNumber ;
@property(nonatomic,strong)UILabel * startDate ;
@property(nonatomic,strong)UILabel * endDate ;
@property(nonatomic,strong)UILabel * startHour;
@property(nonatomic,strong)UILabel * endHour;
@property(nonatomic,strong)UILabel * startAddress;
@property(nonatomic,strong)UILabel * endAddress;

//车型
@property(nonatomic,strong)UILabel * carName ;

@property(nonatomic,strong)NSDictionary * model ;
@property (nonatomic,strong)NSString * orderId ;


-(instancetype)initWithFrame:(CGRect)frame withData:(NSDictionary*)dic withOder:(NSString*)orderId withModel:(DBWaitWorkModel*)model;

@end
