//
//  DBCarListCell.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBCarListCell : UITableViewCell

@property (nonatomic,strong)UILabel * carName ;
@property (nonatomic,strong)UILabel * carNumber ;
@property (nonatomic,strong)UILabel * carColor ;
@property (nonatomic,strong)UILabel * carMileage;


@property (nonatomic,strong)UILabel * carStatus ;
@property (nonatomic,strong)UILabel * orderType ;
@property (nonatomic,strong)UIButton * chooseBt ;

-(void)config:(NSDictionary*)dic ;
@end
