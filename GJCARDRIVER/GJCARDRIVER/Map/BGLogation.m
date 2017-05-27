//
//  BGLogation.m
//  locationdemo
//
//  Created by yebaojia on 16/2/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import "BGLogation.h"
#import "BGTask.h"



// 百度地图类库
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Base/BMKTypes.h>

@interface BGLogation()<BMKMapViewDelegate,BMKRouteSearchDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>

{
    BOOL isCollect;
    CLGeocoder *_coder;
    BMKReverseGeoCodeOption * _reverseGeoCodeOption ;
    BMKRouteSearch* _routesearch;
    BMKUserLocation *_userLocation;
}
@property (strong , nonatomic) BGTask *bgTask; //后台任务
@property (strong , nonatomic) NSTimer *restarTimer; //重新开启后台任务定时器
@property (strong , nonatomic) NSTimer *closeCollectLocationTimer; //关闭定位定时器 （减少耗电）

//反向编码
@property (nonatomic,strong)BMKGeoCodeSearch * searcher;


@end


@implementation BGLogation
//初始化
-(instancetype)init
{
    if(self == [super init])
    {
        //
        _bgTask = [BGTask shareBGTask];
        isCollect = NO;
        //监听进入后台通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}
+(CLLocationManager *)shareBGLocation
{
    static CLLocationManager *_locationManager;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        if ([[UIDevice currentDevice].systemVersion floatValue]>= 9.0)
        {
        
            _locationManager.allowsBackgroundLocationUpdates = YES;
           
        }
        else
        {
            _locationManager.pausesLocationUpdatesAutomatically = NO;
        }
        
    });
    return _locationManager;
}
//后台监听方法
-(void)applicationEnterBackground
{
    NSLog(@"come in background");
    CLLocationManager *locationManager = [BGLogation shareBGLocation];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // 不移动也可以后台刷新回调
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 8.0) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    [_bgTask beginNewBackgroundTask];
}
//重启定位服务
-(void)restartLocation
{
    NSLog(@"重新启动定位");
    CLLocationManager *locationManager = [BGLogation shareBGLocation];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // 不移动也可以后台刷新回调
    if ([[UIDevice currentDevice].systemVersion floatValue]>= 8.0) {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    [self.bgTask beginNewBackgroundTask];
}
//开启服务
- (void)startLocation {
    NSLog(@"开启定位");
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"locationServicesEnabled false");
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    } else {
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            NSLog(@"authorizationStatus failed");
        } else {
            NSLog(@"authorizationStatus authorized");
            CLLocationManager *locationManager = [BGLogation shareBGLocation];
            locationManager.delegate = self ;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            
            if([[UIDevice currentDevice].systemVersion floatValue]>= 8.0) {
                [locationManager requestAlwaysAuthorization];
            }
            [locationManager startUpdatingLocation];
        }
    }
}

//停止后台定位
-(void)stopLocation
{
    NSLog(@"停止定位");
    isCollect = NO;
    CLLocationManager *locationManager = [BGLogation shareBGLocation];
    [locationManager stopUpdatingLocation];
}
#pragma mark --delegate
//定位回调里执行重启定位和关闭定位
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    if (locations.count > 0) {
       
    }
    else{
         DBLog(@"定位数据失败");
        return ;
    }
    
    
    NSLog(@"定位收集 %@",locations);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];

    //如果正在10秒定时收集的时间，不需要执行延时开启和关闭定位
    if (isCollect) {
        return;
    }
    [self performSelector:@selector(stopLocation) withObject:nil afterDelay:5];

    [self performSelector:@selector(restartLocation) withObject:nil afterDelay:20];
    

DBLog(@"17定位了  ");
    CLLocation  * cllocation = [locations firstObject];
DBLog(@"18定位了  ");
//     计算距离
//    CLLocationDistance meters=[cllocation distanceFromLocation:beforeCllocation];


    CLLocationCoordinate2D test = cllocation.coordinate ;
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_COMMON);
  
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    

    NSData *xdata=[[NSData alloc] initWithBase64EncodedString:[testdic objectForKey:@"x"] options:0];
    
    NSData *ydata=[[NSData alloc] initWithBase64EncodedString:[testdic objectForKey:@"y"] options:0];
    
    NSString *xlat=[[NSString alloc] initWithData:ydata encoding:NSUTF8StringEncoding];
    
    NSString *ylng=[[NSString alloc] initWithData:xdata encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * waitDic = [NSMutableDictionary dictionary];
    waitDic[@"lat"] = xlat;
    waitDic[@"lng"] = ylng;

    
    DBLog(@"19定位了  %@ %@",xlat,ylng);
    [DBNewtWorkData sendlocationWithUrl:nil parameters:waitDic success:^(id responseObject) {
        
        DBLog(@"坐标发送成功 %f %f",cllocation.coordinate.latitude,cllocation.coordinate.longitude);
        
    } failure:^(NSError *error) {
        
    }];
    
    
    DBLog(@"20定位了  %@ %@",xlat,ylng);

    [self searchCity:cllocation];
    
    isCollect = YES;//标记正在定位
}


-(void)searchCity:(CLLocation*)location{
    
    if (!_coder) {
        _coder = [[CLGeocoder alloc]init];
    }
    
    [_coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
      
        NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];

        CLPlacemark *pmark=[placemarks firstObject];
        
        if (pmark) {
            
            DBLog(@"崩之前");
            NSString *state = pmark.addressDictionary[@"State"];
            NSString *city = pmark.addressDictionary[@"City"];
            NSString *Name = pmark.addressDictionary[@"Name"];
            NSString *Street = pmark.addressDictionary[@"Street"];
            NSString *subLocality = pmark.addressDictionary[@"SubLocality"];
            NSString *FormattedAddressLines = [pmark.addressDictionary[@"FormattedAddressLines"]firstObject];
            
            NSDictionary * dic ;
//            = [NSDictionary dictionaryWithObjects:@[city,[NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,Street]] forKeys:@[@"city",@"address"]];
            
            
            if ([FormattedAddressLines hasPrefix:@"中国"]) {
                NSString * newadress = [FormattedAddressLines stringByReplacingOccurrencesOfString:@"中国" withString:@""];
                dic = [NSDictionary dictionaryWithObjects:@[city,newadress] forKeys:@[@"city",@"address"]];
            }
            NSString * subThoroughfare = pmark.subThoroughfare ;
            [user setObject:dic forKey:@"userAddr"];

            DBLog(@"崩之后 %@",pmark.subThoroughfare);
            
        }
    
    }];

    
//    if (_searcher == nil){
//        _searcher =[[BMKGeoCodeSearch alloc]init];
//        _searcher.delegate = self;
////        _reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc]init];
//    }
//    
    //发起反向地理编码检索
//    CLLocationCoordinate2D pt = CLLocationCoordinate2DMake([[ NSString stringWithFormat:@"%.5f",[[location objectForKey:@"lat"]doubleValue]]doubleValue], [[ NSString stringWithFormat:@"%.5f",[[location objectForKey:@"lng"]doubleValue]]doubleValue]);
//    
//    
//    
//    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
}

-(void)searchCity{
    if (_searcher == nil){
        _searcher =[[BMKGeoCodeSearch alloc]init];
        _searcher.delegate = self;
        _reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc]init];
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * location = [user objectForKey:@"location"];

    //发起反向地理编码检索
    CLLocationCoordinate2D pt = CLLocationCoordinate2DMake( [[NSString stringWithFormat:@"%@",[location objectForKey:@"lat"]]doubleValue],  [[NSString stringWithFormat:@"%@",[location objectForKey:@"lng"]]doubleValue]);

    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                        BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"反向编码结果%@",[NSString stringWithFormat:@"%@",result.address]);
        NSDictionary * location = [NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%f",result.location.latitude],[NSString stringWithFormat:@"%f",result.location.longitude]] forKeys:@[@"latitude",@"longitude"]];
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjects:@[result.addressDetail.city,result.addressDetail.streetName,result.address,location] forKeys:@[@"city",@"streetName",@"address",@"location"]];
        
        NSUserDefaults * user = [ NSUserDefaults standardUserDefaults];
        [user setObject:dic forKey:@"userAddr"];
        
    }
    
    else {
        
        NSLog(@"未找到结果");
    }
    
    
}
- (void)locationManager: (CLLocationManager *)manager didFailWithError: (NSError *)error{
        // NSLog(@"locationManager error:%@",error);
        
        switch([error code])
        {
            case kCLErrorNetwork: // general, network-related error
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
            case kCLErrorDenied:{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请开启后台服务" message:@"应用不可以定位，需要在在设置/通用/后台应用刷新开启" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
            default:
            {
                
            }
                break;
        }
}

@end
