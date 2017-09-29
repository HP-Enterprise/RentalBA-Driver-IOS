//
//  DBRoadTableViewCell.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/29.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBRoadTableViewCell.h"

@implementation DBRoadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBaseUI];
}

-(void)setBaseUI{
    self.deleteBt.layer.borderWidth = 0.5;
    self.deleteBt.layer.borderColor= [UIColor lightGrayColor].CGColor;
    self.deleteBt.layer.cornerRadius = 5;
    self.deleteBt.layer.masksToBounds = YES;
    [self.deleteBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
//    self.editBt.layer.borderWidth = 0.5;
//    self.editBt.layer.borderColor= [UIColor lightGrayColor].CGColor;
    self.editBt.backgroundColor = BascColor;
    self.editBt.layer.cornerRadius = 5;
    self.editBt.layer.masksToBounds = YES;
    [self.editBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
}

/*
 contractCode = 1222221131;
 contractType = 0;
 driverId = 1;
 fuelCharge = 1;
 hotelExpenses = 3;
 id = 4;
 license = "\U6d59A3UF67";
 otherExpenses = 4;
 parkingTollFee = 2;
 realName = "\U6bdb\U5e86";
 refuelingMileage = 1;
 remark = 122222211;
 returnCarActualDate = 1503988292000;
 returnCarMileage = 0;
 status = 0;     0 未汇总 1.已汇总
 takeCarActualDate = 1503988292000;
 takeCarMileage = 123;
 vehicleId = 9886;
 */

-(void)config:(NSDictionary*)dic{
    NSString * startTime = [NSString stringWithFormat:@"%@",dic[@"takeCarActualDate"]];
    NSString * endTime = [NSString stringWithFormat:@"%@",dic[@"returnCarActualDate"]];

    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];

    // 毫秒值转化为秒
    NSDate* startdate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/ 1000.0];
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/ 1000.0];

    NSString* startdateString = [formatter stringFromDate:startdate];
    NSString* enddateString = [formatter stringFromDate:endDate];

    
    
    
    self.orderNumber.text = [NSString stringWithFormat:@"%@",dic[@"contractCode"]];
    self.getonTime.text = startdateString;
    self.getonMieage.text = [NSString stringWithFormat:@"%@km",dic[@"takeCarMileage"]];
    self.getoffTime.text = enddateString;
    self.getoffMileage.text = [NSString stringWithFormat:@"%@km",dic[@"returnCarMileage"]];
    self.addfuelCost.text = [NSString stringWithFormat:@"%@元",dic[@"fuelCharge"]];
    self.addfuelMileageNumber.text = [NSString stringWithFormat:@"%@km",dic[@"refuelingMileage"]];
    self.roadParkCost.text = [NSString stringWithFormat:@"%@元",dic[@"parkingTollFee"]];
    self.hotelCost.text = [NSString stringWithFormat:@"%@元",dic[@"hotelExpenses"]];
    self.otherCost.text = [NSString stringWithFormat:@"%@元",dic[@"otherExpenses"]];

    
    
    
    NSLog(@"%@",dic);
}


- (IBAction)deleteBtClick:(id)sender {
}
- (IBAction)editBtClick:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
