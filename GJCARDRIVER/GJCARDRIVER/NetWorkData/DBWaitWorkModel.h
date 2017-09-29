//
//  DBWaitWorkModel.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DBWaitWorkModel : JSONModel


@property (nonatomic,strong)NSString <Optional> * airLineCompany ;
@property (nonatomic,strong)NSString <Optional> * airport ;
@property (nonatomic,strong)NSString <Optional> * tripAddress ;
@property (nonatomic,strong)NSString <Optional> * callInStoreAddress ;
@property (nonatomic,strong)NSString <Optional> * callInStoreId ;
@property (nonatomic,strong)NSString <Optional> * callInStoreName ;
@property (nonatomic,strong)NSString <Optional> * callInStorePhone ;
@property (nonatomic,strong)NSString <Optional> * callOutStoreAddress ;
@property (nonatomic,strong)NSString <Optional> * callOutStoreId ;
@property (nonatomic,strong)NSString <Optional> * callOutStoreName ;
@property (nonatomic,strong)NSString <Optional> * callOutStorePhone ;
@property (nonatomic,strong)NSString <Optional> * cityId ;
@property (nonatomic,strong)NSString <Optional> * cityName ;
@property (nonatomic,strong)NSString <Optional> * createdTime ;
@property (nonatomic,strong)NSString <Optional> * customerAddress ;
@property (nonatomic,strong)NSString <Optional> * customerId ;
@property (nonatomic,strong)NSString <Optional> * customerPhone ;
@property (nonatomic,strong)NSString <Optional> * customerRealName ;
@property (nonatomic,strong)NSString <Optional> * dispatchOrigin ;
@property (nonatomic,strong)NSString <Optional> * dispatchOriginName ;
@property (nonatomic,strong)NSString <Optional> * dispatchStatus ;
@property (nonatomic,strong)NSString <Optional> * dispatchStatusName ;
@property (nonatomic,strong)NSString <Optional> * dispatchType ;
@property (nonatomic,strong)NSString <Optional> * dispatchTypeName ;
@property (nonatomic,strong)NSString <Optional> * driverId ;
@property (nonatomic,strong)NSString <Optional> * driverName ;
@property (nonatomic,strong)NSString <Optional> * driverPhone ;
@property (nonatomic,strong)NSString <Optional> * expectEndTime ;
@property (nonatomic,strong)NSString <Optional> * expectGetOffAddress ;
@property (nonatomic,strong)NSString <Optional> * expectGetOnAddress ;
@property (nonatomic,strong)NSString <Optional> * expectStartTime ;
@property (nonatomic,strong)NSString <Optional> * id ;
@property (nonatomic,strong)NSString <Optional> * modelId ;
@property (nonatomic,strong)NSString <Optional> * modelName ;
@property (nonatomic,strong)NSString <Optional> * orderCode ;
@property (nonatomic,strong)NSString <Optional> * orderId ;
@property (nonatomic,strong)NSString <Optional> * orderShow ;
@property (nonatomic,strong)NSString <Optional> * orderType ;    //1=短租自驾；2=门到门服务；3=短租代驾; 4=接送机
@property (nonatomic,strong)NSString <Optional> * orderTypeName ;
@property (nonatomic,strong)NSString <Optional> * plate ;
@property (nonatomic,strong)NSString <Optional> * realEndTime ;
@property (nonatomic,strong)NSString <Optional> * realStartTime ;        
@property (nonatomic,strong)NSString <Optional> * recipientName ;
@property (nonatomic,strong)NSString <Optional> * recipientPhone ;
@property (nonatomic,strong)NSString <Optional> * taskTraceShows ;
@property (nonatomic,strong)NSString <Optional> * taskType ;
@property (nonatomic,strong)NSString <Optional> * taskTypeName ;
@property (nonatomic,strong)NSString <Optional> * vehicleId ;
@property (nonatomic,strong)NSString <Optional> * clientActualDebusAddress ;


@end
