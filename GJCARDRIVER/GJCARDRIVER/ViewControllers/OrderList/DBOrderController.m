//
//  DBOrderController.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//





#import "DBOrderController.h"



#import "BGTask.h"
#import "BGLogation.h"


#import "DBOrderListCell.h"

#import "DBWaitWorkModel.h"

#import "DBStartBackRecord.h"
#import "DBEndBackRecord.h"
#import "DBUserCentreController.h"
//还车
#import "DBReturnCarViewController.h"

#import "DBFinishOrderDetailController.h"
#import "DBOrderInfoViewController.h"
#import "DBGetCarViewController.h"
#import "DBRefuseView.h"
@interface DBOrderController ()<UIScrollViewDelegate,UITextViewDelegate>

{
    DBProgressAnimation * _progress;
    
    BOOL keyboardDidShow  ;
    //记录移动的距离
    CGFloat moveLenth ;
}


@property (strong , nonatomic) BGTask *task;
@property (strong , nonatomic) NSTimer *bgTimer;
@property (strong , nonatomic) BGLogation *bgLocation;
@property (strong , nonatomic) CLLocationManager *location;



@property (nonatomic,strong)NSArray * waitWorkData ;
@property (nonatomic,strong)NSMutableArray * workingData ;
@property (nonatomic,strong)NSMutableArray * finishWorkData ;
@property (nonatomic,strong)UIView * tipView ;
@property (nonatomic,strong)DBRefuseView * refuseView;
@end

@implementation DBOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self basicSet];

//    //定位设置
//    [self setLocation];
    
    
}



#pragma mark 加载动画
-(void)addProgress
{
    _progress = [[DBProgressAnimation alloc]init];
    [_progress addProgressAnimationWithViewControl:self];
}

-(void)removeProgress
{
    if (_progress != nil)
    {
        [_progress removeProgressAnimation];
    }
}

//界面 数据 基础设置
-(void)basicSet{
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.orderScrollView];
    
    
    //导航栏个人信息按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self leftBarButtonItem]];

}

//创建个人信息按钮
-(UIButton*)leftBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(20, 12, 20, 20);
    [userButton setImage:[UIImage imageNamed:@"UserUmage"] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(userInfoClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}

    
-(void)userInfoClick{
    
    DBUserCentreController * user = [[DBUserCentreController alloc]init];
    [self.navigationController pushViewController:user animated:YES];
    
}

-(void)loadData{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString * userId = [user objectForKey:@"userId"] ;
    __weak typeof(self)weak_self = self ;
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    waitDic[@"dispatchStatus"]= @"20" ;
//    waitDic[@"taskType"]= @"3" ;
    waitDic[@"driverId"]= userId ;
    waitDic[@"orderBy"] = @"2" ;
    [weak_self addProgress];
    
    [DBNewtWorkData Get:nil parameters:waitDic success:^(id responseObject) {
        [weak_self removeProgress];
        
        weak_self.waitWorkData = [NSArray arrayWithArray:responseObject];
        [weak_self performSelectorOnMainThread:@selector(waitWorkReload:) withObject:weak_self.waitWorkData waitUntilDone:YES];
    } failure:^(NSError *error) {
        [weak_self removeProgress];
        DBLog(@"%@",error);
        
    }];
    
    NSMutableDictionary * workingDic = [NSMutableDictionary dictionary];
    workingDic[@"dispatchStatus"]= @"30" ;
    workingDic[@"driverId"]= userId ;
    workingDic[@"orderBy"] = @"2" ;
//    workingDic[@"taskType"]= @"3" ;
    
    [DBNewtWorkData Get:nil parameters:workingDic success:^(id responseObject) {
        weak_self.workingData = [NSMutableArray arrayWithArray:responseObject];
     
        NSMutableDictionary * workedDic = [NSMutableDictionary dictionary];
        workedDic[@"dispatchStatus"]= @"35" ;
        workedDic[@"driverId"]= userId ;
        workedDic[@"orderBy"] = @"4" ;
        //    workingDic[@"taskType"]= @"3" ;
        
        [DBNewtWorkData Get:nil parameters:workedDic success:^(id responseObject) {
            
            for (NSDictionary * dic in [NSArray arrayWithArray:responseObject]) {
                
                [weak_self.workingData addObject:dic ];
            }
            
            [weak_self performSelectorOnMainThread:@selector(workingReload:) withObject:weak_self.workingData waitUntilDone:YES];
        } failure:^(NSError *error) {
          

            DBLog(@"%@",error);
        }];
        
        
    } failure:^(NSError *error) {

        DBLog(@"%@",error);
    }];

    NSMutableDictionary * finishDic = [NSMutableDictionary dictionary];
    finishDic[@"dispatchStatus"]= @"50" ;
    finishDic[@"driverId"]= userId ;
    finishDic[@"orderBy"] = @"1" ;
//    finishDic[@"taskType"]= @"3" ;
    
    [DBNewtWorkData Get:nil parameters:finishDic success:^(id responseObject) {
        

        weak_self.finishWorkData = [NSMutableArray arrayWithArray:responseObject];
        
        NSArray * array = [NSMutableArray arrayWithArray:responseObject];
        
        
        for ( int i = 0  ; i < weak_self.finishWorkData.count; i ++) {
            
            DBWaitWorkModel * dic = _finishWorkData[i];


            [ self parameters:dic success:^(id responseObject) {
                
                if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                    
                    if ([[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"message"]objectForKey:@"orderState"]]isEqualToString:@"5"]) {
                        
                        [weak_self.workingData addObject:dic];
                        [weak_self.finishWorkData removeObjectAtIndex:i];
                        
                        [weak_self performSelectorOnMainThread:@selector(finishWorkReload:) withObject:weak_self.finishWorkData waitUntilDone:YES];
                        [weak_self performSelectorOnMainThread:@selector(workingReload:) withObject:weak_self.workingData waitUntilDone:YES];
  
                    }
                    
                }

            } failure:^(NSError *error) {
                
            }];

        }
        

        [weak_self performSelectorOnMainThread:@selector(finishWorkReload:) withObject:weak_self.finishWorkData waitUntilDone:YES];
    } failure:^(NSError *error) {
        DBLog(@"%@",error);
    }];
    
}


//加载订单详情
- (void)parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    NSString * url = [NSString stringWithFormat:@"%@/api/airportTrip/%@/order",HOST,parameters.orderCode];
    
    if ([parameters.orderType isEqualToString:@"3"]) {
        
        url = [NSString stringWithFormat:@"%@/api/contract/%@/contractDetail",HOST,parameters.orderCode];

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





//数据加载完成刷新tableView
-(void)waitWorkReload:(NSArray*)array{
    self.orderScrollView.waitWorkData = array ;
    [self.orderScrollView.waitWorkTable reloadData];
}

-(void)workingReload:(NSArray*)array{
    self.orderScrollView.workingData = array ;
    [self.orderScrollView.workingTable reloadData];
}

-(void)finishWorkReload:(NSArray*)array{
    self.orderScrollView.finishWorkData = array ;
    [self.orderScrollView.finishWorkTable reloadData];
}


-(void)setNavigation{
    self.title = @"订单任务";
    self.navigationController.navigationBar.barTintColor = BascColor ;
}

-(DBOrderListView*)headerView{
    
    if (!_headerView) {
        __weak typeof(self)weak_self = self ;
        _headerView = [[DBOrderListView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
        _headerView.orderNameBlcok=^(NSString*orderName){
          
             DBLog(@"%@",orderName);
        };        
        _headerView.scrollViewMove=^(NSInteger moveFloat){

            [UIView animateWithDuration:0.3 animations:^{
                
                CGPoint newPoint = weak_self.orderScrollView.contentOffset ;
                switch (moveFloat) {
                    case 0:
                        newPoint.x = 0;
                        break;
                    case 1:
                        newPoint.x = ScreenWidth;
                        break;
                    case 2:
                        newPoint.x = ScreenWidth*2;
                        break;
                    default:
                        break;
                }
                weak_self.orderScrollView.contentOffset = newPoint;
            }];
        };
    }
    return _headerView;
}

-(DBOrderScrollView*)orderScrollView{
    if (!_orderScrollView) {
        _orderScrollView = [[DBOrderScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(_headerView.frame)) withDelegate:self];
        _orderScrollView.delegate =self ;
        
        [self showFinishOrderDetail];
    }
    return _orderScrollView ;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sc_X = scrollView.contentOffset.x ;
    CGFloat index_X = sc_X *3/8 + _headerView.workingBt.frame.size.width/4 ;
    UIView * view = _headerView.indexView ;
  
    DBLog(@"%f",index_X);
    if ( 0 < sc_X < ScreenWidth * 2) {
        CGRect newFrame = view.frame ;
        newFrame.origin.x =  index_X ;
        view.frame  =newFrame ;
    }
}

-(void)changeToSecend{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint newPoint = self.orderScrollView.contentOffset ;
        
        if (newPoint.x == 0) {
             newPoint.x = ScreenWidth;
        }
         self.orderScrollView.contentOffset = newPoint;
        
    }];
    [self scrollViewMove];
}

-(void)changeToThred{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint newPoint = self.orderScrollView.contentOffset ;
        
        if (newPoint.x == ScreenWidth) {
            newPoint.x = ScreenWidth * 2;
        }
        self.orderScrollView.contentOffset = newPoint;
        
    }];
    
    [self scrollViewMove];
}

-(void)scrollViewMove{
    
    if ( self.orderScrollView.contentOffset.x == 0) {
        [_headerView.waitWorkBt setTitleColor:BascColor  forState:UIControlStateNormal];
        [_headerView.workingBt  setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] forState:UIControlStateNormal];
        [_headerView.finishWorkBt setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] forState:UIControlStateNormal];
        _headerView.lastBt = _headerView.waitWorkBt ;
    }
    else if ( self.orderScrollView.contentOffset.x == ScreenWidth){
        [_headerView.waitWorkBt setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1]  forState:UIControlStateNormal];
        [_headerView.workingBt  setTitleColor:BascColor forState:UIControlStateNormal];
        [_headerView.finishWorkBt setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] forState:UIControlStateNormal];
        _headerView.lastBt = _headerView.workingBt ;
    }
    else if (  self.orderScrollView.contentOffset.x == ScreenWidth * 2){
        [_headerView.waitWorkBt setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1]  forState:UIControlStateNormal];
        [_headerView.workingBt  setTitleColor:[UIColor colorWithRed:0.62 green:0.62 blue:0.63 alpha:1] forState:UIControlStateNormal];
        [_headerView.finishWorkBt setTitleColor:BascColor forState:UIControlStateNormal];
        _headerView.lastBt = _headerView.finishWorkBt ;
    }

}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewMove];
}

//处理接收 拒绝订单按钮
-(void)orderClick:(NSNotification*)notification{

    NSString * object = [notification.object objectForKey:@"index"] ;
    
    

    if ([object isEqualToString:@"确认"]) {

        [self acceptOrder:[notification.object objectForKey:@"dic"]];
    }
    else if ([object isEqualToString:@"拒绝"]){
        [self refuseOrder:[notification.object objectForKey:@"dic"]];
        
    }
    else if ([object isEqualToString:@"提车"]){
        [self getId:notification];

          }
    else if ([object isEqualToString:@"上车"]){
        [self getId:notification];
        
    }
    else if ([object isEqualToString:@"下车"]){
        DBEndBackRecord * end = [[DBEndBackRecord alloc]init];
        end.model = [notification.object objectForKey:@"dic"] ;
        [self.navigationController pushViewController:end animated:YES];
    }
    else if ([object isEqualToString:@"还车"]){
        [self returnCar:notification];
        
    }
    else if ([object isEqualToString:@"详情"]){
        
        DBFinishOrderDetailController * detail = [[DBFinishOrderDetailController alloc]init];
        
        detail.model = [notification.object objectForKey:@"dic"] ;

        [self.navigationController pushViewController:detail animated:YES];
    }
    

    DBLog(@"%@",notification);
}

//执行订单
-(void)getId:(NSNotification*)notification{

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    
    
    __weak typeof(self)weak_self = self ;
    [DBNewtWorkData orderIdGet:nil parameters:[notification.object objectForKey:@"dic"] success:^(id responseObject) {
        
        [weak_self.tipView removeFromSuperview];
        
        
        
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {

//            //测试
//            DBGetCarViewController * getCar = [[DBGetCarViewController alloc]init];
//            
//            [weak_self.navigationController pushViewController:getCar animated:YES];
//            
//            
            if ( ![[responseObject objectForKey:@"message"]isKindOfClass:[NSNull class]] ) {

                
                NSString * object = [notification.object objectForKey:@"index"] ;
                
                if ([object isEqualToString:@"提车"]) {
                    DBGetCarViewController * getCar = [[DBGetCarViewController alloc]init];
                    getCar.model = [notification.object objectForKey:@"dic"] ;
                    [weak_self.navigationController pushViewController:getCar animated:YES];
                }
                else if ([object isEqualToString:@"上车"]){
                    DBStartBackRecord * start = [[DBStartBackRecord alloc]init];
                    start.model = [notification.object objectForKey:@"dic"] ;
                    start.vehicleId = [[responseObject objectForKey:@"message"]objectForKey:@"vehicleId"] ;
                    [weak_self.navigationController pushViewController:start animated:YES];
                }
            }
            else{
                [weak_self tipShow:@"请先生成合同"];
            }
        }
        else{
            [weak_self tipShow:@"请先生成合同"];
        }
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//还车
-(void)returnCar:(NSNotification*)notification{
    
    
    DBReturnCarViewController * returncar = [[DBReturnCarViewController alloc]init];
    returncar.model = [notification.object objectForKey:@"dic"] ;
    
    returncar.returnCar =^{
      
        [self changeToThred];
        
        
        
    };
    
    [self.navigationController pushViewController:returncar animated:YES];
    
}

//接受订单点击
-(void)acceptOrder:(DBWaitWorkModel*)dic{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    DBNewtWorkData* dataNet =[[DBNewtWorkData alloc]init];
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    
//    DBWaitWorkModel * model = dic;
    NSString * taskId = dic.id ;
    waitDic[@"taskId"]= taskId ;
    waitDic[@"operatorId"]= [user objectForKey:@"userId"] ;

    NSLog(@"%@", [user objectForKey:@"userId"] );

    [self.tipView removeFromSuperview];
    [dataNet acceptOrderPUT:nil parameters:waitDic];
    __weak typeof(self)weak_self = self;
    dataNet.acceptOrderBlcok = ^(id  message){
        if (![message isKindOfClass:[NSError class]]) {
            if ([[message objectForKey:@"status"]isEqualToString:@"true"]) {
                [self changeToSecend];
                [weak_self loadData];
            }
            [weak_self tipShow:[message objectForKey:@"message"]];
        }
        DBLog(@"%@",message);
    };
    
}
//拒绝订单点击
-(void)refuseOrder:(DBWaitWorkModel*)dic{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    _refuseView = [[DBRefuseView alloc]initWithFrame:self.view.frame];
    _refuseView.reasonTextView.delegate = self ;
    [self.view addSubview:_refuseView];
    
   
    __weak typeof(self)weak_self = self;
    _refuseView.refuseBlcok = ^(NSString * reasom)
    {
        
        [weak_self.tipView removeFromSuperview];
        NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
        

        NSString * taskId = dic.id ;
        
        waitDic[@"taskId"]= taskId;
        waitDic[@"operatorId"]= [user objectForKey:@"userId"] ;
        if (!weak_self.refuseView.reasonTextView.text || [weak_self.refuseView.reasonTextView.text isEqualToString:@""]) {
            [weak_self tipShow:@"请填写拒绝原因"];
            
        }
        else{
            waitDic[@"operateDesc"]= weak_self.refuseView.reasonTextView.text ;
           
            [weak_self refuseSubmit:[NSDictionary dictionaryWithDictionary:waitDic]];
        }
    };
    _refuseView.cancelBlock = ^()
    {
        [weak_self refuseRemove];
    };
    
}

-(void)refuseSubmit:(NSDictionary*)dic{
    
    DBNewtWorkData* dataNet =[[DBNewtWorkData alloc]init];
    
    [dataNet refuseOrderPUT:nil parameters:dic];
    
    __weak typeof(self)weak_self = self;

    dataNet.refuseOrderBlcok = ^(id  message)
    {
        
        if (![message isKindOfClass:[NSError class]]) {
            
            if ([[message objectForKey:@"status"]isEqualToString:@"true"]) {
                
                
                [weak_self loadData];
            }
            [weak_self performSelectorOnMainThread:@selector(refuseRemove) withObject:nil waitUntilDone:YES];
            
            [weak_self tipShow:[message objectForKey:@"message"]];
        }
        DBLog(@"%@",message);
    };

}

-(void)refuseRemove{
    
    [UIView animateWithDuration:0.5 animations:^{
        _refuseView.alpha =0;
    } completion:^(BOOL finished) {
         [_refuseView removeFromSuperview];
    }];
   
    
}


//展示订单详情
-(void)showFinishOrderDetail{
    
    __weak typeof(self)weak_self = self ;

    _orderScrollView.orderInfoBlock = ^(DBWaitWorkModel * model){
        
        DBOrderInfoViewController * orderInfo =[[DBOrderInfoViewController alloc]init];
        orderInfo.model = model ;
        [weak_self.navigationController pushViewController:orderInfo animated:YES];
    };
    
    _orderScrollView.orderClickBlock = ^(DBWaitWorkModel * model){
        
        DBFinishOrderDetailController * detail = [[DBFinishOrderDetailController alloc]init];
        detail.model = model ;
        [weak_self.navigationController pushViewController:detail animated:YES];

    };

    
    
    
}
-(NSArray*)waitWorkData{
    if (!_waitWorkData) {
        _waitWorkData = [NSArray array];
    }
    return _waitWorkData ;
}

-(NSArray*)workingData{
    if (!_workingData) {
        _workingData = [NSMutableArray array];
    }
    return _workingData;
}

-(NSArray*)finishWorkData{
    if (!_finishWorkData) {
        _finishWorkData = [NSArray array];
    }
    return  _finishWorkData;
}


- (void)tipShow:(NSString *)str
{
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setNavigation];
    
    //版本检测
//    [self loadVersion];
    
    self.navigationController.navigationBarHidden = NO;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderClick:) name:@"orderCellClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:@"reloadOrder" object:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"orderCellClick" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadOrder" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

//键盘位置监控
- (void)keyBoardDidShow:(NSNotification *)notif {
    NSLog(@"===keyboar showed====");
    if (keyboardDidShow) return;
    //    get keyboard size
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //    CGSize keyboardSize = [aValue CGRectValue].size;
    CGPoint keyboardPoint = [aValue CGRectValue].origin;
    
    CGRect viewFrame = self.refuseView.reasonView.frame;
    
    
    if (CGRectGetMaxY(viewFrame) > keyboardPoint.y)
    {
        
        moveLenth = CGRectGetMaxY(viewFrame) - keyboardPoint.y ;
        
        viewFrame.origin.y -= moveLenth ;
        
        
        self.refuseView.reasonView.frame = viewFrame;
        
        keyboardDidShow = YES;
        
    }
    
}

- (void)keyBoardDidHide:(NSNotification *)notif {
    NSLog(@"====keyboard hidden====");
    
    CGRect viewFrame = self.refuseView.reasonView.frame;
    viewFrame.origin.y += moveLenth ;
    
    self.refuseView.reasonView.frame = viewFrame;
    if (!keyboardDidShow) {
        return;
    }
    keyboardDidShow = NO;
}




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
  
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.view endEditing:YES];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}


//收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    
       DBLog(@"%@ release",self);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
