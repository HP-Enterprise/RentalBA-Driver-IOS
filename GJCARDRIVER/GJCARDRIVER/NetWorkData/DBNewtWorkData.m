//
//  DBNewtWorkData.m
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/10.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBNewtWorkData.h"




// /api/dispatch/task-list
#import <CommonCrypto/CommonDigest.h>
@implementation DBNewtWorkData

#pragma mark md5加密

//加密
+(NSString *)getDictKeysValues:(NSDictionary *)dic{
    NSMutableString *pmv=[[NSMutableString alloc] init];
    for (int i=0; i<[[dic allKeys] count]; i++) {
        NSString *key1=[[dic allKeys] objectAtIndex:i];
        [pmv appendFormat:@"%@",[dic valueForKey:key1]];
    }
    NSString *ipmv = [NSString stringWithString:pmv];
    NSLog(@"ipmv=%@",ipmv);
    ipmv=[self md5Digest:ipmv];
    return ipmv;
}


+(NSString*)md5Digest:(NSString *)str{
    
    //32位MD5小写
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
}


//司机登录
+(void)signInPost:(NSString*)url parameters:(NSDictionary*)paramrters success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure{
    

    url  = [NSString stringWithFormat:@"%@/api/dispatch/city-driver/login",HOST];
    //    NSMutableDictionary * parDic = [NSMutableDictionary dictionary];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    
    [manager POST:url parameters:paramrters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {

            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
            NSHTTPCookie *cookie;
            NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
            for (cookie in [cookieJar cookiesForURL:[NSURL URLWithString:HOST]])
            {
                
                
                
                
                if ([[cookie name] isEqualToString:@"driver_token"]) { // 获取响应头数组对象里地名字为token的对象
                    
                    //            NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);
                    //获取响应头数组对象里地名字为token的对象的数据，这个数据是用来验证用户身份相当于“key”
                    
                    ////保存个人信息
                    //        //登录成功后保存账号密码
                    [user setObject:[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]] forKey:@"driver_token"];
                    
                    DBLog(@"保存了 token  %@",[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);
                    
                }
            }

            
            success(responseObject);

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {

            
            failure(error);
        }
    }];

    
    
  
    
    
//    NSString * url1 = [NSString stringWithFormat:@"%@/api/staff/login/F1C610668AAB7D564262C285D5CCFBA3",HOST];
//    [manager GET:url1 parameters:nil progress:nil
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//             
//             NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage]; // 获得响应头
//             NSHTTPCookie *cookie;
//             NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
//             
//             for (cookie in [cookieJar cookiesForURL:[NSURL URLWithString:HOST]])
//             {
//                 if ([[cookie name] isEqualToString:@"token"]) { // 获取响应头数组对象里地名字为token的对象
//                     
//                     //            NSLog(@"############%@", [NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);
//                     //获取响应头数组对象里地名字为token的对象的数据，这个数据是用来验证用户身份相当于“key”
//                     
//                     ////保存个人信息
//                     //        //登录成功后保存账号密码
//                     [user setObject:[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]] forKey:@"token"];
//
//                     DBLog(@"保存了 token  %@",[NSString stringWithFormat:@"%@=%@",[cookie name],[cookie value]]);
//                     
//                 }
//             }
//
//             
//             
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DBLog(@"%@",error);
//        
//        
//    }];
//    
//    [manager POST:url parameters:paramrters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if(success) {
//            
//            
//            success(responseObject);
//            
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if(failure) {
//            
//            
//            failure(error);
//        }
//    }];
    
}

//修改密码
+(void)changePwPost:(NSString*)url parameters:(NSDictionary*)paramrters success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure{
    
    
    url  = [NSString stringWithFormat:@"%@/api/dispatch/city-driver/password",HOST];
    //    NSMutableDictionary * parDic = [NSMutableDictionary dictionary];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    
    [manager POST:url parameters:paramrters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        if(success) {
                        
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            
            failure(error);
        }
    }];
    
}



// get 方法调用
+ (void)Get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {

    url  = [NSString stringWithFormat:@"%@/api/dispatch/task-list?currentPage=1&pageSize=100",HOST];
//    NSMutableDictionary * parDic = [NSMutableDictionary dictionary];

//    parDic[@"dispatchType"] = @"1";
//    parDic[@"dispatchStatus"] = @"20";
//    parDic[@"dispatchOrigin"] = @"2";
//    parDic[@"taskType"] = @"1";
//    parDic[@"phone"] = @"15827653951";
//    parDic[@"driverId"] = @"2";
//    parDic[@"currentPage"] = @"1";
//    parDic[@"pageSize"] = @"100";
    
//    Integer dispatchType 调度类型 1=自动调度任务；2=手工调度任务
//    Integer dispatchStatus 调度状态 10=待分配，20=已分配，30=已确认，40=已拒绝，50=已完成，60=已取消
//    Integer dispatchOrigin 调度来源 1=门到门订单，2=门店调拨 3=接送机订单
//    Integer taskType 任务类型 1=送车，2=取车 3=接送机
//    String phone 用户手机号
//    Integer driverId 司机id
//    Integer currentPage 当前页面
//    Integer pageSize 页数
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
 
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
   
             NSMutableArray * dataArray = [NSMutableArray array];
            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                
                if (![[responseObject objectForKey:@"message"]isKindOfClass:[NSNull class]] && [responseObject objectForKey:@"message"] != nil) {
                    if ([NSArray arrayWithArray:[responseObject objectForKey:@"message"]].count>0) {

                        for (NSDictionary * dic in [NSArray arrayWithArray:[responseObject objectForKey:@"message"]]) {
                            
                            DBWaitWorkModel * model = [[DBWaitWorkModel alloc]initWithDictionary:dic error:nil ]  ;
                            [dataArray addObject:model];
                        }
                        DBLog(@"%@",responseObject);

                    }
                    else{
                        DBLog(@"没有数据");
                    }
                }
                 success(dataArray);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
    }];
}

//接收订单

-(void)acceptOrderPUT:(NSString *)url parameters:(NSDictionary *)parameters
{
    
      url  = [NSString stringWithFormat:@"%@/api/dispatch/task-confirm",HOST];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);

        self.acceptOrderBlcok(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.acceptOrderBlcok(error);
        NSLog(@"%@",error);
        
    }];
}


//拒绝订单

-(void)refuseOrderPUT:(NSString *)url parameters:(NSDictionary *)parameters
{

    url  = [NSString stringWithFormat:@"%@/api/dispatch/task-reject",HOST];
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
//    __weak typeof(self)weak_self = self ;
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);

        
        self.refuseOrderBlcok(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        self.refuseOrderBlcok(error);

        NSLog(@"%@",error);
        
    }];
}


//发送坐标

// get 方法调用
+ (void)sendlocationWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    
    NSUserDefaults * user =  [NSUserDefaults standardUserDefaults];

//    url  = [NSString stringWithFormat:@"http://gjwap.ngrok.cc/api/dispatch/city-driver/%@/location",[user objectForKey:@"userId"]];

    url  = [NSString stringWithFormat:@"%@/api/dispatch/city-driver/%@/location",HOST,[user objectForKey:@"userId"]];
    //    NSMutableDictionary * parDic = [NSMutableDictionary dictionary];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success) {
            

            
            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
                
                
                
                NSLog(@"%@  %@",[responseObject objectForKey:@"message"],parameters);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            

            failure(error);
        }
    }];
}




//提交上车回执单

-(void)submitStartRecordPUT:(NSString *)url parameters:(NSDictionary *)parameters with:(DBWaitWorkModel *)model
{
//    Integer id; 调度任务id
//    Integer driverId; 调度司机id
//    Integer vehicleId; 调度车辆id
//    Date realStartTime;
//    请求参数：
//    Integer getOnMileage //上车里程
//    String getOnFuel//上车油量
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    url  = [NSString stringWithFormat:@"%@/api/dispatch/task-doing?getOnMileage=%@&getOnFuel=%@&",HOST,[parameters objectForKey:@"getOnMileage"],[parameters objectForKey:@"getOnFuel"]];
    
    
    if ([[parameters allKeys]containsObject:@"onAddress"]) {
        

        url  = [NSString stringWithFormat:@"%@/api/dispatch/task-doing?getOnMileage=%@&getOnFuel=%@&onAddress=%@",HOST,[parameters objectForKey:@"getOnMileage"],[parameters objectForKey:@"getOnFuel"],[parameters objectForKey:@"onAddress"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
//        url  = [NSString stringWithFormat:@"%@/api/dispatch/task-doing?getOnMileage=%@&getOnFuel=%@&onAddress=%@",HOST,[parameters objectForKey:@"getOnMileage"],[parameters objectForKey:@"getOnFuel"],@"12345678"];

    }
    
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    waitDic[@"id"]= [parameters objectForKey:@"id"] ;
    waitDic[@"driverId"]= [user objectForKey:@"userId"] ;
    waitDic[@"vehicleId"]= [parameters objectForKey:@"vehicleId"] ;
    waitDic[@"realStartTime"]= [parameters objectForKey:@"realStartTime"];

    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager PUT:url parameters:waitDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);

        self.startRecordBlcok(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.startRecordBlcok(@"加载失败");
        NSLog(@"%@",error);
    }];
    
    
}


//提交下车回执单

-(void)submitEndRecordPUT:(NSString *)url parameters:(NSDictionary *)parameters with:(DBWaitWorkModel *)model
{
//    6 任务完成 /api/dispatch/task-finish
//    请求方式：HTTP PUT
//    请求对象：DispatchTaskShow
//    Integer id; //任务id
//    Integer driverId; //司机id
//    Integer recipientName; //接收人姓名
//    Date realEndTime;
//    请求参数：
//    Integer getOffMileage //下车里程
//    String getOffFuel//下车油量

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];

    url  = [NSString stringWithFormat:@"%@/api/dispatch/task-finish?getOffMileage=%@&getOffFuel=%@",HOST,[parameters objectForKey:@"getOffMileage"],[parameters objectForKey:@"getOffFuel"]];
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    waitDic[@"id"]= [parameters objectForKey:@"id"] ;
    waitDic[@"driverId"]= [user objectForKey:@"userId"] ;
    waitDic[@"vehicleId"]= [parameters objectForKey:@"vehicleId"] ;
    waitDic[@"realEndTime"]= [parameters objectForKey:@"realEndTime"];
    waitDic[@"recipientName"] = [parameters objectForKey:@"recipientName"];
    waitDic[@"clientActualDebusAddress"] = [parameters objectForKey:@"clientActualDebusAddress"];


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager PUT:url parameters:waitDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
    
        self.endRecordBlcok(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        self.endRecordBlcok(@"加载失败");
        NSLog(@"%@",error);
        
    }];
}


//加载合同id
+ (void)orderIdGet:(NSString *)url parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    if ([parameters.orderType isEqualToString:@"4"]) {
        url = [NSString stringWithFormat:@"%@/api/airportTrip/%@/contract",HOST,parameters.orderCode];
    }
    else if ([parameters.orderType isEqualToString:@"3"]){
        url = [NSString stringWithFormat:@"%@/api/contract/%@/contractDetail",HOST,parameters.orderCode];
    }
    else if ([parameters.orderType isEqualToString:@"2"]){
        url = [NSString stringWithFormat:@"%@/api/door/%@/contract",HOST,parameters.orderCode];
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


//加载可分配车辆
+ (void)loadAllCarsWithparameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{

    NSString *  url = [NSString stringWithFormat:@"%@/api/vendor/1/pool/1/vehicle?business=3&currentPage=1&modelId=%@&pageSize=10&states=ready,rented&storeType=2",HOST,parameters.modelId];
    
    if ([parameters.orderType isEqualToString:@"3"]) {
        
        url = [NSString stringWithFormat:@"%@/api/vendor/1/pool/1/vehicle?business=2&currentPage=1&modelId=%@&pageSize=10&states=ready,rented&storeType=2",HOST,parameters.modelId];
    }
    
//    NSString *  url = [NSString stringWithFormat:@"%@/api/vehicle/brand/series/model?brand=&currentPage=1&fuzzy=1&model=&pageSize=5&series=",HOST];
//    http://182.61.22.80/api/vendor/1/pool/1/vehicle?business=3&currentPage=1&modelId=121&pageSize=10&state=ready&storeType=2
//    http://182.61.22.80/api/airportTrip/1017262/order
    
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
+ (void)orderInfoGet:(NSString *)url parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
     url = [NSString stringWithFormat:@"%@/api/airportTrip/%@/order",HOST,parameters.orderCode];
    
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

//加载司机详情
+ (void)loadDriverInfoGet:(NSString *)url parameters:(NSDictionary*)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    url = [NSString stringWithFormat:@"%@/api/dispatch/driver-list?cityName=&currentPage=1&name=&pageSize=10&phone=%@&storeName=",HOST,[NSString stringWithFormat:@"%@",[parameters objectForKey:@"phone"]]];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}





//分配车辆
+ (void)allocateCarUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
//http://182.61.22.80/api/take/1017260/airContract?modelId=121&takeCarActualDate=1492238100000&takeCarFuel=2%2F16&takeCarMileage=1000&vehicleId=461410


    url  = [NSString stringWithFormat:@"%@/api/take/%@/%@?takeCarMileage=%@&takeCarFuel=%@&modelId=%@&vehicleId=%@&takeCarActualDate=%@",HOST,[parameters objectForKey:@"orderCode"],url,[parameters objectForKey:@"getOnMileage"],[parameters objectForKey:@"getOnFuel"],[parameters objectForKey:@"modelId"],[parameters objectForKey:@"vehicleId"],[parameters objectForKey:@"realStartTime"]];
    

    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    
    waitDic[@"takeCarActualDate"]= [parameters objectForKey:@"realStartTime"];
    waitDic[@"modelId"]= [parameters objectForKey:@"modelId"];
    waitDic[@"vehicleId"]= [parameters objectForKey:@"vehicleId"];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSUserDefaults * user =[NSUserDefaults standardUserDefaults];
    [manager.requestSerializer setValue:[user objectForKey:@"driver_token"] forHTTPHeaderField:@"cookie"];
    //@"token_staff=40BA37A4CFFBBDBF7A9E4AB4FD5509B2"
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    
    
    [manager PUT:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DBLog(@"%@",[responseObject objectForKey:@"message"]);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//还车
+ (void)returnCarUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    
    
    url  = [NSString stringWithFormat:@"%@/api/return/%@/%@?returnCarMileage=%@&returnCarFuel=%@&returnCarActualDate=%@",HOST,[parameters objectForKey:@"orderCode"],url,[parameters objectForKey:@"getOnMileage"],[parameters objectForKey:@"getOnFuel"],[parameters objectForKey:@"realStartTime"]];


//    http://182.61.22.80/api/return/1022172/driverContract?returnCarMileage=2500&returnCarFuel=1/16&returnCarActualDate=1493189946058
//    http://182.61.22.80/api/return/1022172/driverContract?returnCarActualDate=1493189100000&returnCarFuel=3%2F16&returnCarMileage=2500
////    http://182.61.22.80/api/return/1017260/airContract?returnCarActualDate=1492332900000&returnCarFuel=2%2F16&returnCarMileage=20001
////
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
 
    waitDic[@"realStartTime"]= [parameters objectForKey:@"realStartTime"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [manager.requestSerializer setValue:[user objectForKey:@"driver_token"] forHTTPHeaderField:@"cookie"];
 
    
    //token_staff=1C9C461FDFB0C1578765BF6C923FFF9E

    [manager PUT:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DBLog(@"%@",[responseObject objectForKey:@"message"]);

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




+ (void)GetVersion:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{

    url =[NSString stringWithFormat:@"%@/api/appManage/latest?appType=3",HOST];
    
//     NSString * newpath = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* oldversion =[[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)@"CFBundleShortVersionString"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/json",nil];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]){
                 if ([[responseObject objectForKey:@"message"] isKindOfClass:[NSNull class]] || [responseObject objectForKey:@"message"] ==nil){
                 }
                 else if ([[[responseObject objectForKey:@"message"]objectForKey:@"appVersion"]isEqualToString:@"0000"]){
                 }
                 else if(![[[responseObject objectForKey:@"message"]objectForKey:@"appVersion"]isEqualToString:oldversion]){
                     NSString * version = [[responseObject objectForKey:@"message"]objectForKey:@"appVersion"] ;
                     NSString * newVersion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
                     NSString * oldVersion = [oldversion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
                     if ([newVersion integerValue] > [oldVersion integerValue]) {
                         success(responseObject);
                     }
                     else{
//                         success(@"false"); 
                     }
                 }
             }
            else{
//                 success(@"false");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

//    
//    [DBNetworkTool Get:url parameters:nil success:^(id responseObject)
//     {
//         if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"])
//         {
//             
//             if ([[responseObject objectForKey:@"message"] isKindOfClass:[NSNull class]] || [responseObject objectForKey:@"message"] ==nil)
//             {
//                 
//             }
//             else if ([[[responseObject objectForKey:@"message"]objectForKey:@"appVersion"]isEqualToString:@"0000"])
//             {
//                 [self addBugView];
//             }
//             else if(![[[responseObject objectForKey:@"message"]objectForKey:@"appVersion"]isEqualToString:oldversion])
//             {
//                 
//                 NSString * version = [[responseObject objectForKey:@"message"]objectForKey:@"appVersion"] ;
//                 NSString * newVersion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
//                 NSString * oldVersion = [oldversion stringByReplacingOccurrencesOfString:@"." withString:@""];
//                 
//                 
//                 if ([newVersion integerValue] > [oldVersion integerValue]) {
//                     
//                     
//                     UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight )];
//                     [self.view addSubview:backView];
//                     backView.backgroundColor = [UIColor colorWithRed:0.69 green:0.69 blue:0.68 alpha:1];
//                     backView.alpha = 0.3 ;
//                     [self.view bringSubviewToFront:backView];
//                     
//                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"有新版本可供更新" message:nil preferredStyle:UIAlertControllerStyleAlert];
//                     
//                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                         
//                         
//                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1151833888"]];
//                         
//                     }];
//                     [alertController addAction:okAction];
//                     [self presentViewController:alertController animated:YES completion:nil];
//                     
//                 }
//             }
//             
//         }
//         
//     } failure:^(NSError *error) {
//         
//     }];
    
}

@end
