//
//  DBRoadTableViewCell.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/29.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBRoadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *getonTime;
@property (weak, nonatomic) IBOutlet UILabel *getonMieage;
@property (weak, nonatomic) IBOutlet UILabel *getoffTime;
@property (weak, nonatomic) IBOutlet UILabel *getoffMileage;
@property (weak, nonatomic) IBOutlet UILabel *addfuel;
@property (weak, nonatomic) IBOutlet UILabel *addfuelCost;
@property (weak, nonatomic) IBOutlet UILabel *addfuelMileage;
@property (weak, nonatomic) IBOutlet UILabel *addfuelMileageNumber;
@property (weak, nonatomic) IBOutlet UILabel *roadPark;
@property (weak, nonatomic) IBOutlet UILabel *roadParkCost;
@property (weak, nonatomic) IBOutlet UILabel *hotelLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelCost;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherCost;
@property (weak, nonatomic) IBOutlet UIButton *deleteBt;
@property (weak, nonatomic) IBOutlet UIButton *editBt;

-(void)config:(NSDictionary*)dic;

@end
