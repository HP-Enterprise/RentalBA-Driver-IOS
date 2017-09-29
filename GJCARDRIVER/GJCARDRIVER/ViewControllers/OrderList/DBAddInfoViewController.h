//
//  DBAddInfoViewController.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/28.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBDatePickerView.h"
#import "DBWaitWorkModel.h"

@interface DBAddInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tipShow;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *startMonth;
@property (weak, nonatomic) IBOutlet UILabel *startHour;
@property (weak, nonatomic) IBOutlet UILabel *startAddress;
@property (weak, nonatomic) IBOutlet UILabel *carName;
@property (weak, nonatomic) IBOutlet UILabel *endMonth;
@property (weak, nonatomic) IBOutlet UILabel *endHour;
@property (weak, nonatomic) IBOutlet UILabel *endAddress;

@property (weak, nonatomic) IBOutlet UIButton *getonTimeBt;
@property (weak, nonatomic) IBOutlet UITextField *getonMileage;
@property (weak, nonatomic) IBOutlet UIButton *getoffTimeBt;

@property (weak, nonatomic) IBOutlet UITextField *getoffMileage;
@property (weak, nonatomic) IBOutlet UITextField *addFuelCost;
@property (weak, nonatomic) IBOutlet UITextField *addFuelMileage;
@property (weak, nonatomic) IBOutlet UITextField *parkCost;
@property (weak, nonatomic) IBOutlet UITextField *accommodation;
@property (weak, nonatomic) IBOutlet UITextField *otherCost;
@property (weak, nonatomic) IBOutlet UITextView *markView;
@property (weak, nonatomic) IBOutlet UIButton *saveBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollView_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollView_hejght;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *markViewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (nonatomic,strong)NSDictionary * roadOrder;
@property (nonatomic,strong)DBWaitWorkModel * orderModel;
@property (nonatomic,strong)NSDictionary * contrectInfo;
@property (nonatomic,strong)DBDatePickerView * pickView;
@property (nonatomic,strong)NSString * index;
@end
