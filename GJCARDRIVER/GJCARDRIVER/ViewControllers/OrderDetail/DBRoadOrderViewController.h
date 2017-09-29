//
//  DBRoadOrderViewController.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/29.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBWaitWorkModel.h"
@interface DBRoadOrderViewController : UIViewController

@property (nonatomic,strong)NSDictionary * contractInfo;
@property (nonatomic,strong)DBWaitWorkModel * orderModel;
@property (nonatomic,strong)NSMutableArray * orderArray;
@property (nonatomic,strong)UITableView * orderList;

@end
