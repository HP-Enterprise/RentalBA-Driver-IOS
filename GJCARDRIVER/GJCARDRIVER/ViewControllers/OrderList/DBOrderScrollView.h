//
//  DBOrderScrollView.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/10.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBWaitWorkModel.h"

typedef void(^orderClick)(DBWaitWorkModel * model);


typedef void(^orderInfo)(DBWaitWorkModel * model);

@interface DBOrderScrollView : UIScrollView <UITableViewDelegate,UITableViewDataSource>

{
    NSDictionary * detailDic ;
    
    NSDictionary * transferPointShow ;

}

//datableView
@property (nonatomic,strong)UITableView * waitWorkTable;
@property (nonatomic,strong)UITableView * workingTable;
@property (nonatomic,strong)UITableView * finishWorkTable;

//data
@property (nonatomic,strong)NSMutableArray * waitWorkData ;
@property (nonatomic,strong)NSMutableArray * workingData ;
@property (nonatomic,strong)NSMutableArray * finishWorkData ;

@property (nonatomic,strong)orderClick orderClickBlock ;
@property (nonatomic,strong)orderInfo orderInfoBlock ;

-(instancetype)initWithFrame:(CGRect)frame withDelegate:(UIViewController*)controller ;
@end
