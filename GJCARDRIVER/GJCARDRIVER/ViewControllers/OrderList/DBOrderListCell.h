//
//  DBOrderListCell.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/9.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DBWaitWorkModel.h"


@interface DBOrderListCell : UITableViewCell
{
    UIView * headView ;
    UIView * carLine ;
}
@property (nonatomic,strong)UILabel * orderType ;
@property (nonatomic,strong)UILabel * userTime ;
@property (nonatomic,strong)UILabel * mileageLabel ;

@property (nonatomic,strong)UIControl * topControl ;

@property (nonatomic,strong)UILabel * orderNumber ;
@property (nonatomic,strong)UILabel * aifPortInfo ;



@property(nonatomic,strong)UILabel * startDate ;
@property(nonatomic,strong)UILabel * endDate ;
@property(nonatomic,strong)UILabel * startHour;
@property(nonatomic,strong)UILabel * endHour;
@property(nonatomic,strong)UILabel * startAddress;
@property(nonatomic,strong)UILabel * endAddress;

//车型
@property(nonatomic,strong)UILabel * carName ;

//按钮
@property(nonatomic,strong)UIButton * acceptBt;
@property(nonatomic,strong)UIButton * refuseBt;


@property (nonatomic,strong)DBWaitWorkModel * model ;


-(void)waitWorkConfig:(DBWaitWorkModel*)model;
-(void)workingConfig:(DBWaitWorkModel*)model;
-(void)finishWorkConfig:(DBWaitWorkModel*)model;
@end
