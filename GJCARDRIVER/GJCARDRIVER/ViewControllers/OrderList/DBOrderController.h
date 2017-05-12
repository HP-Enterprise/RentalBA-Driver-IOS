//
//  DBOrderController.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBOrderListView.h"
#import "DBOrderScrollView.h"




@interface DBOrderController : UIViewController



@property (nonatomic,strong)DBOrderListView * headerView;
@property (nonatomic,strong)DBOrderScrollView * orderScrollView;
@property (nonatomic,strong)NSArray * dataArray ;

-(void)loadData ;
@end
