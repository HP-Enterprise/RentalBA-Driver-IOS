
//
//  DBOrderScrollView.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/10.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBOrderScrollView.h"
#import "DBOrderListCell.h"

#import "MJRefresh.h"
@implementation DBOrderScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame withDelegate:(UIViewController*)controller{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentSize = CGSizeMake(3*ScreenWidth, frame.size.height);
        self.pagingEnabled = YES ;
    
        [self setUI];

    }
    return self;
}

-(void)setUI{
    
    [self addSubview:self.waitWorkTable];
    [self addSubview:self.workingTable];
    [self addSubview:self.finishWorkTable];
    
}




-(UITableView*)waitWorkTable{
    if (!_waitWorkTable) {
        
        _waitWorkTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height )];

        _waitWorkTable.showsVerticalScrollIndicator = NO ;
        _waitWorkTable.showsHorizontalScrollIndicator = NO ;
        _waitWorkTable.delegate =self ;
        _waitWorkTable.dataSource = self ;
        _waitWorkTable.backgroundColor = [UIColor clearColor];
        _waitWorkTable.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
        _waitWorkTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
        __weak typeof(self)weak_self =self ;
        

        _waitWorkTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadOrder" object:nil];
            [weak_self.waitWorkTable.mj_header endRefreshing];

        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _waitWorkTable.mj_header.automaticallyChangeAlpha = YES;
    }
    return _waitWorkTable;
}

-(UITableView*)workingTable{
    if (!_workingTable) {
        
        _workingTable = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.frame.size.height )];
        _workingTable.showsVerticalScrollIndicator = NO ;
        _workingTable.showsHorizontalScrollIndicator = NO ;
        _workingTable.delegate =self ;
        _workingTable.dataSource = self ;
        _workingTable.backgroundColor = [UIColor clearColor];
        _workingTable.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
        _workingTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
        __weak typeof(self)weak_self =self ;
        _workingTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadOrder" object:nil];
            [weak_self.workingTable.mj_header endRefreshing];
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _workingTable.mj_header.automaticallyChangeAlpha = YES;

        
    }
    return _workingTable;
}

-(UITableView*)finishWorkTable{
    if (!_finishWorkTable) {
        
        _finishWorkTable = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, self.frame.size.height )];
        _finishWorkTable.showsVerticalScrollIndicator = NO ;
        _finishWorkTable.showsHorizontalScrollIndicator = NO ;
        _finishWorkTable.delegate =self ;
        _finishWorkTable.dataSource = self ;
        _finishWorkTable.backgroundColor = [UIColor clearColor];
        _finishWorkTable.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
        _finishWorkTable.separatorStyle = UITableViewCellSeparatorStyleNone ;
        // 下拉刷新
        __weak typeof(self)weak_self =self ;
        _finishWorkTable.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadOrder" object:nil];

            [weak_self.finishWorkTable.mj_header endRefreshing];

        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        _finishWorkTable.mj_header.automaticallyChangeAlpha = YES;
        
    }
    return _finishWorkTable;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
    if (tableView == _waitWorkTable) {
        return self.waitWorkData.count;
    }
    else if (tableView == _workingTable){
        return self.workingData.count ;
    }
    return self.finishWorkData.count ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _finishWorkTable) {
        return 160 ;
    }
    return 160 ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _waitWorkTable) {
        
        
        DBOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"waitWorkCell"];
        if (cell == nil) {
            cell = [[DBOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waitWorkCell"];
        }
        cell.selectionStyle  = 0 ;
        if (self.waitWorkData.count > 0) {
        
            [cell waitWorkConfig:self.waitWorkData[indexPath.row]];
            cell.acceptBt.tag = 100 + indexPath.row;
            [cell.acceptBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.refuseBt.tag = 200 + indexPath.row;
            [cell.refuseBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle  = 0 ;
            
        }
        cell.topControl.tag = 1000 + indexPath.row;
        [cell.topControl addTarget:self action:@selector(waitClick:) forControlEvents:UIControlEventTouchUpInside];
        [self loadOrderWithCell:self.waitWorkData[indexPath.row] with:cell];
        
        return cell ;
    }
    if (tableView == _workingTable) {
        
        DBOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"workingCell"];
        if (cell == nil) {
            cell = [[DBOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"workingCell"];
        }
        if (self.workingData.count>0) {
            
            
            [cell workingConfig:self.workingData[indexPath.row]];
            DBWaitWorkModel * model = self.workingData[indexPath.row];

            cell.acceptBt.tag = 300 + indexPath.row;
            [cell.acceptBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.refuseBt.tag = 400 + indexPath.row;
            cell.refuseBt.backgroundColor = BascColor;
            [cell.refuseBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
 
            if ([model.dispatchStatus isEqualToString:@"35"]) {
                
//
              //  cell.refuseBt.hidden = YES;
                cell.refuseBt.hidden = NO;
                cell.acceptBt.hidden = NO ;
            }
            
            else if ([model.dispatchStatus isEqualToString:@"30"])
            {
                //cell.refuseBt.hidden = YES;
                cell.refuseBt.hidden = NO;
                cell.acceptBt.hidden = NO ;
//                cell.acceptBt.frame = cell.refuseBt.frame ;
            }
            //已完成
            else if ([model.dispatchStatus isEqualToString:@"50"])
            {
                cell.refuseBt.hidden = YES;
//                cell.refuseBt.hidden = NO;
                cell.acceptBt.hidden = NO ;
//                cell.acceptBt.frame = cell.refuseBt.frame ;
  
            }

            [self loadOrderWithCell:self.workingData[indexPath.row] with:cell];
            
            [self loadOrder:self.workingData[indexPath.row] with:cell.acceptBt] ;
          
            cell.topControl.tag =900 + indexPath.row;
            
            
            [cell.topControl addTarget:self action:@selector(wokingClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        cell.selectionStyle  = 0 ;
        return cell ;
    }
    
    DBOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"finishWorkCell"];
    if (cell == nil) {
        cell = [[DBOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"finishWorkCell"];
    }
    if (self.finishWorkData.count>0) {
        
        [cell finishWorkConfig:self.finishWorkData[indexPath.row]];
        
        [self loadOrder:self.finishWorkData[indexPath.row] with:cell.acceptBt] ;

        cell.refuseBt.tag = 500 + indexPath.row;
        cell.refuseBt.backgroundColor = BascColor;
        [cell.refuseBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.acceptBt.hidden = YES;
    }
    [self loadOrderWithCell:self.finishWorkData[indexPath.row] with:cell];

    cell.topControl.tag = 1000 + indexPath.row;
    [cell.topControl addTarget:self action:@selector(finishiClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle  = 0 ;
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _waitWorkTable) {
        self.orderInfoBlock(self.waitWorkData[indexPath.row]);
    }
    
    if (tableView == _workingTable) {
        self.orderInfoBlock(self.workingData[indexPath.row]);
    }
    if (tableView == _finishWorkTable) {
        self.orderClickBlock(self.finishWorkData[indexPath.row]);

    }
    
}

-(void)wokingClick:(UIControl*)button{
    
     self.orderInfoBlock(self.workingData[button.tag - 900]);
    
}

-(void)waitClick:(UIControl*)button{
    
    
    self.orderInfoBlock(self.waitWorkData[button.tag - 1000]);
    
}

-(void)finishiClick:(UIControl*)button{
    
    self.orderClickBlock(self.finishWorkData[button.tag - 1000]);
    
}

-(void)acceptBtClick:(UIButton*)button{
    NSDictionary * dic ;
    
    
    if ([button.titleLabel.text isEqualToString:@"确认"]) {
        dic = @{@"dic":self.waitWorkData[button.tag - 100],@"index":button.titleLabel.text};
        
    }
    else if ([button.titleLabel.text isEqualToString:@"拒绝"]){
        dic = @{@"dic":self.waitWorkData[button.tag - 200],@"index":button.titleLabel.text};
    }
    else if ([button.titleLabel.text isEqualToString:@"提车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};

    }
    else if ([button.titleLabel.text isEqualToString:@"上车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};
        
    }
    else if ([button.titleLabel.text isEqualToString:@"下车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};

    }
    else if ([button.titleLabel.text isEqualToString:@"交车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};
        
    }
    else if ([button.titleLabel.text isEqualToString:@"取车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};
        
    }
    else if ([button.titleLabel.text isEqualToString:@"还车"]){
        dic = @{@"dic":self.workingData[button.tag - 300],@"index":button.titleLabel.text};
        
    }
    else if ([button.titleLabel.text isEqualToString:@"路单"]){
        if (button.tag - 500 >= 0) {
            dic = @{@"dic":self.finishWorkData[button.tag - 500],@"index":button.titleLabel.text};
        }
        else{
            dic = @{@"dic":self.workingData[button.tag - 400],@"index":button.titleLabel.text};
        }
    }

    else if ([button.titleLabel.text isEqualToString:@"详情"]){
        dic = @{@"dic":self.finishWorkData[button.tag - 500],@"index":button.titleLabel.text};
        
    }
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orderCellClick" object:dic];
}


-(void)refuseBtClick:(UIButton*)button{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orderCellClick" object:@"refuse"];
}

-(NSMutableArray*)waitWorkData{
    if (!_waitWorkData) {
        _waitWorkData = [NSMutableArray array];
    }
    return _waitWorkData ;
}
-(NSMutableArray*)workingData{
    if (!_workingData) {
        _workingData = [NSMutableArray array];
    }
    return _workingData;
}
-(NSMutableArray*)finishWorkData{
    if (!_finishWorkData) {
        _finishWorkData = [NSMutableArray array];
    }
    return  _finishWorkData;
}


-(void)loadOrderWithCell:(DBWaitWorkModel *)parameters with:(DBOrderListCell * )cell{
  
    detailDic = [NSDictionary dictionary];
    transferPointShow = [NSDictionary dictionary];
    [self contracParameters:parameters with:nil success:^(id responseObject) {

        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            if (![[responseObject objectForKey:@"message"]isKindOfClass:[NSNull class]]) {
                detailDic = [responseObject objectForKey:@"message"] ;
                transferPointShow =  [detailDic objectForKey:@"transferPointShow"];
                [self configwithdic:parameters with:cell];

            }
            else{
                
                [self parameters:parameters with:nil success:^(id response) {
                    
                    if ([[response objectForKey:@"status"]isEqualToString:@"true"]) {
                        
                        detailDic = [response objectForKey:@"message"] ;
                        transferPointShow =  [detailDic objectForKey:@"transferPointShow"];
                        [self configwithdic:parameters with:cell];
                    }
                    
                } failure:^(NSError *error) {
                    
                }];
            }
        }
        else{
            [self parameters:parameters with:nil success:^(id response) {
                
                if ([[response objectForKey:@"status"]isEqualToString:@"true"]) {
                    
                    detailDic = [response objectForKey:@"message"] ;
                    transferPointShow =  [detailDic objectForKey:@"transferPointShow"];
                    [self configwithdic:parameters with:cell];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)configwithdic:(DBWaitWorkModel *)parameters with:(DBOrderListCell *)cell{
    //takeCarDate
    
    NSString * startdate = [DBcommonUtils timeWithTimeIntervalString: [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"takeCarDate"] ]];
    
    if ([parameters.orderType isEqualToString:@"2"]) {
        startdate = [DBcommonUtils timeWithTimeIntervalString: [NSString stringWithFormat:@"%@",parameters.expectStartTime]];
    }
    DBLog(@"%@",startdate);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setDay:1];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [formatter stringFromDate:newdate];
    
    if ([dateString isEqualToString:[startdate substringWithRange:NSMakeRange(0, 11)]]) {
        
        cell.userTime.text  =[NSString stringWithFormat:@"(明天)%@",startdate];
    }
    
    else
    {
        cell.userTime.text  = startdate ;
    }
    
    cell.orderNumber.text = [NSString stringWithFormat:@"订单编号: %@",parameters.orderCode];
    
    if (![[detailDic objectForKey:@"airlineCompany"]isKindOfClass:[NSNull class]] && ![[detailDic objectForKey:@"airlineCompany"]isEqualToString:@""]) {
        cell.aifPortInfo.text = [NSString stringWithFormat:@"航班信息: %@/%@",[detailDic objectForKey:@"airlineCompany"],[detailDic objectForKey:@"flightNumber"]];
    }
    else{
        cell.aifPortInfo.text = [NSString stringWithFormat:@"航班信息: %@",[detailDic objectForKey:@"flightNumber"]];
    }
    
    if (![[detailDic objectForKey:@"tripDistance"]isKindOfClass:[NSNull class]]) {
        cell.mileageLabel.text = [NSString stringWithFormat:@"预估里程: %@公里",[detailDic objectForKey:@"tripDistance"] ];
    }
    else{
        cell.mileageLabel.text = @"预估里程: 0公里";
    }
    
    if ([[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"tripType"]]isEqualToString:@"1"]) {
        cell.orderType.text = @"接机";
        cell.startAddress.text= [NSString stringWithFormat:@"%@",[transferPointShow objectForKey:@"pointName"] ];
        
        cell.endAddress.text = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"tripAddress"] ];

    }
    if ([[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"tripType"]]isEqualToString:@"2"]) {
        cell.orderType.text = @"送机";
        cell.startAddress.text= [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"tripAddress"] ];
        cell.endAddress.text = [NSString stringWithFormat:@"%@",[transferPointShow objectForKey:@"pointName"] ];
    }
    
    //短租代驾
    if ([parameters.orderType isEqualToString:@"3"]) {
        
        if (![[detailDic objectForKey:@"outsideDistance"]isKindOfClass:[NSNull class]]) {
            
            cell.mileageLabel.text = [NSString stringWithFormat:@"预估里程: %@公里",[detailDic objectForKey:@"outsideDistance"] ];
        }
        else{
            cell.mileageLabel.text = @"预估里程: 0公里" ;
        }
        
        cell.aifPortInfo.text = @"";
        
        cell.startAddress.text= [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"takeCarAddress"] ];
        cell.endAddress.text = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"returnCarAddress"] ];
        
 
    }
    
    //门到门
    else if ([parameters.orderType isEqualToString:@"2"]){

        if ([[detailDic allKeys]containsObject:@"outsideDistance"]){
            if (![[detailDic objectForKey:@"outsideDistance"]isKindOfClass:[NSNull class]]) {
                
                cell.mileageLabel.text = [NSString stringWithFormat:@"预估里程: %@公里",[detailDic objectForKey:@"outsideDistance"]];
            }
        }
        else{
            cell.mileageLabel.text = @"预估里程: 0公里" ;
        }
        
        if ([parameters.taskType isEqualToString:@"1"]) {
            
            cell.startAddress.text= [NSString stringWithFormat:@"%@",parameters.callOutStoreAddress];
            cell.endAddress.text = [NSString stringWithFormat:@"%@",parameters.customerAddress];
        }
        else if ([parameters.taskType isEqualToString:@"2"]){
            cell.startAddress.text= [NSString stringWithFormat:@"%@",parameters.customerAddress];
            cell.endAddress.text = [NSString stringWithFormat:@"%@",parameters.callInStoreAddress];
        }
        
        cell.aifPortInfo.text = @"";
        
        
    }


    
    NSString * string = [detailDic objectForKey:@"clientActualDebusAddress"];

    if ([[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"orderState"]]isEqualToString:@"7"] || [[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"orderState"]]isEqualToString:@"6"]) {
        
        if ([[detailDic allKeys]containsObject:@"clientActualDebusAddress"]) {
       
            
            if ([string isKindOfClass:[NSNull class]] ||  [string isEqual:[NSNull null]]) {
            }
            else{
                cell.endAddress.text = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"clientActualDebusAddress"] ];
                
            }
        }
    }
}

-(void)loadOrder:(DBWaitWorkModel *)parameters with:(UIButton*)butotn{
    [self contracParameters:parameters with:nil success:^(id responseObject) {
      
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            
            DBLog(@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"])
            
            
            if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"2"]) {
                [butotn setTitle:@"提车" forState:UIControlStateNormal];
            }
            else if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"3"]){
                
                [butotn setTitle:@"上车" forState:UIControlStateNormal];
                if ([parameters.orderType isEqualToString:@"2"]) {
                    [butotn setTitle:@"交车" forState:UIControlStateNormal];
                }
                
            }else if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"4"]) {
                [butotn setTitle:@"下车" forState:UIControlStateNormal];
                
                if ([parameters.orderType isEqualToString:@"2"]) {
                    [butotn setTitle:@"取车" forState:UIControlStateNormal];
                }
   
            }
            else if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"5"]){
                [butotn setTitle:@"还车" forState:UIControlStateNormal];
            }
            else if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"6"]){
                [butotn setTitle:@"详情" forState:UIControlStateNormal];
                
                if ([parameters.orderType isEqualToString:@"2"]) {
                    [butotn setTitle:@"取车" forState:UIControlStateNormal];
                }
                
            }else if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"] ]isEqualToString:@"7"]){
                [butotn setTitle:@"详情" forState:UIControlStateNormal];
                if ([parameters.orderType isEqualToString:@"2"]) {
                    [butotn setTitle:@"交车" forState:UIControlStateNormal];
                }
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


//加载合同详情
- (void)contracParameters:(DBWaitWorkModel *)parameters with:(UIButton*)button success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    //    http://182.61.22.80/api/driver/1022172/order
    NSString * url = [NSString stringWithFormat:@"%@/api/airportTrip/%@/contract",HOST,parameters.orderCode];
    if ([parameters.orderType isEqualToString:@"3"]) {
        url = [NSString stringWithFormat:@"%@/api/contract/%@/contractDetail",HOST,parameters.orderCode];
    }
        //门到门
    if ([parameters.orderType isEqualToString:@"2"]) {
        url = [NSString stringWithFormat:@"%@/api/door/%@/contract",HOST,parameters.orderCode];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//加载订单详情
- (void)parameters:(DBWaitWorkModel *)parameters with:(UIButton*)button success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{

//    http://182.61.22.80/api/driver/1022172/order
    
    NSString * url = [NSString stringWithFormat:@"%@/api/airportTrip/%@/order",HOST,parameters.orderCode];
    
    if ([parameters.orderType isEqualToString:@"3"]) {
        url = [NSString stringWithFormat:@"%@/api/driver/%@/order",HOST,parameters.orderCode];
    }
    else if ([parameters.orderType isEqualToString:@"2"]) {
        url = [NSString stringWithFormat:@"%@/api/door/%@/order",HOST,parameters.orderCode];
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
