//
//  DBNewtWorkData.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/10.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBWaitWorkModel.h"


#import "DBCarModel.h"

//接受订单
typedef void(^acceptOrderBlcok)(id message);

//拒绝订单
typedef void(^refuseOrderBlcok)(id message);

//回执单
typedef void (^startRecordBlcok)(id message);
//回执单
typedef void (^endRecordBlcok)(id message);



@interface DBNewtWorkData : NSObject

@property (nonatomic,strong)NSMutableArray * waitWorkData ;
@property (nonatomic,strong)NSMutableArray * workingData ;
@property (nonatomic,strong)NSMutableArray * finishWorkData ;

@property (nonatomic,strong)acceptOrderBlcok acceptOrderBlcok ;
@property (nonatomic,strong)refuseOrderBlcok refuseOrderBlcok ;

@property (nonatomic,strong)startRecordBlcok startRecordBlcok;
@property (nonatomic,strong)endRecordBlcok endRecordBlcok;
//md5加密
+(NSString *)getDictKeysValues:(NSDictionary *)dic;
+(NSString*)md5Digest:(NSString *)str;


//司机登录
+(void)signInPost:(NSString*)url parameters:(NSDictionary*)paramrters success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//修改密码
+(void)changePwPost:(NSString*)url parameters:(NSDictionary*)paramrters success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//查询订单
+ (void)Get:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure ;
//接受订单
-(void)acceptOrderPUT:(NSString *)url parameters:(NSDictionary *)parameters ;
//拒绝订单
-(void)refuseOrderPUT:(NSString *)url parameters:(NSDictionary *)parameters;
//发送司机坐标
+ (void)sendlocationWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//上车回执单
-(void)submitStartRecordPUT:(NSString *)url parameters:(NSDictionary *)parameters with:(DBWaitWorkModel *)parameters;
//下车回执单
-(void)submitEndRecordPUT:(NSString *)url parameters:(NSDictionary *)parameters with:(DBWaitWorkModel *)parameters;
//查询订单id
+ (void)orderIdGet:(NSString *)url parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//加载可分配车辆
+ (void)loadAllCarsWithparameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//加载全部车型
+ (void)loadAllVehicleWithparameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//加载可分配车辆
+ (void)loadCarsWithparameters:(DBCarModel *)parameter withModel:(DBWaitWorkModel*)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//分配车辆
+ (void)allocateCarUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//还车
+ (void)returnCarUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//查询司机是否有未还车辆
+ (void)loadDriverCarGetsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
#pragma mark -- 司机自行提还车
//还车
+ (void)driverReturnCarUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure ;
//模糊查询车牌号
+ (void)loadCarPlateGet:(NSString*)str success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//加载订单详情
+ (void)orderInfoGet:(NSString *)url parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//加载司机详情
+ (void)loadDriverInfoGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure ;
//获取版本号
+ (void)GetVersion:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//加载路单信息
+ (void)loadRoadOrderGet:(NSString *)url parameters:(DBWaitWorkModel *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//新增路单信息
+ (void)addRoadOrderGet:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//编辑路单
+(void)editRoadOrderPUT:(NSString *)url parameters:(NSDictionary *)parameters with:(NSString *)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//删除路单
+(void)deleteRoadOrder:(NSString*)url orderId:(NSString*)orderId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
