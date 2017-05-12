//
//  AppDelegate.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/11.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "AppDelegate.h"
#import "DBLogInController.h"
#import "DBOrderController.h"
#import "DBStartBackRecord.h"

//测试
#import "DBOrderInfoViewController.h"
#import "DBGetCarViewController.h"


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "DBJPUSHData.h"

//百度
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>




#import "BGTask.h"
#import "BGLogation.h"
@interface AppDelegate ()
@property (strong , nonatomic) BGTask *task;
@property (strong , nonatomic) NSTimer *bgTimer;
@property (strong , nonatomic) BGLogation *bgLocation;
@property (strong , nonatomic) CLLocationManager *location;

@property (strong , nonatomic)  DBJPUSHData * pushdata;
@end

@interface AppDelegate ()<BMKGeneralDelegate>

{
    NSDictionary *_launchDict;
    BMKMapManager* _mapManager;
    CLLocationManager * _locationManger;
}


@property (nonatomic,assign)NSInteger  badgeIndex;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
//    //注册首页
    DBLogInController * logIn = [[DBLogInController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:logIn];
    nav.navigationBarHidden = YES ;

    
    //订单详情
//    DBOrderInfoViewController * orderInfo = [[DBOrderInfoViewController alloc]init];
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:orderInfo];
//    nav.navigationBarHidden = YES ;

    
    
//    DBOrderController * order = [[DBOrderController alloc]init];
//    UINavigationController * ordernav = [[UINavigationController alloc]initWithRootViewController:order];
//    ordernav.navigationBarHidden = YES ;
//    
    
//    DBGetCarViewController * car =[[DBGetCarViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:car];
    
    
    
    self.window.rootViewController  = nav ;
    
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    
//    if ([[user objectForKey:@"signIn"]isEqualToString:@"1"]){
//        
//        self.window.rootViewController  = ordernav ;
//    }
//    else{
//        self.window.rootViewController  = nav ;
//    }
    
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"Qwh4ulsI442tWGEgIrNVXxBUCvVjgCHR" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    
    
    //定位设置
    [self setLocation];
    //推送设置
    [self setJPushOptions:launchOptions];
    
    _badgeIndex = 0 ;
    [application setApplicationIconBadgeNumber:_badgeIndex];
    [JPUSHService setBadge:_badgeIndex];
    return YES;
}

#pragma mark 设置网络监控
+ (void)netWorkStatus
{
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        DBNetManager * netManager =[DBNetManager sharedManager];
        
        netManager.netStatu = status ;
        
        if (status != 0 ) {
            
            [DBNewtWorkData GetVersion:nil parameters:nil success:^(id responseObject) {
                if ([responseObject isKindOfClass:[NSString class]]) {
                    if ([responseObject isEqualToString:@"true"]) {
                        
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"netChange" object:nil];

                    }
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        NSLog(@"*********************************************网络状态  %ld",status);
        
    }];
    
}

-(void)setJPushOptions:(NSDictionary *)launchOptions{
    
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//#endif
//    } else
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
  
    //6f93f92777938b23e5bcba49
    [JPUSHService setupWithOption:launchOptions appKey:@"4056475cb550c79f2f30d95b"
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    
    
    _pushdata = [DBJPUSHData shareDBJPUSHData];
}
#pragma mark ----定位相关设置
//设置定位
-(void)setLocation{
    
    _task = [BGTask shareBGTask];
    if ([UIApplication sharedApplication].backgroundRefreshStatus == UIBackgroundRefreshStatusRestricted)
    {
        DBLog(@"设备不可以定位");

    }
    else
    {
        self.bgLocation = [[BGLogation alloc]init];
        [self.bgLocation startLocation];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(log) userInfo:nil repeats:YES];
    }
    
    
    
}


-(void)log
{
    NSLog(@"测试后台执行");
}

-(void)startBgTask
{
    [_task beginNewBackgroundTask];
}

#pragma mark ----推送相关设置
- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);

    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}




// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
//    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    _pushdata = [DBJPUSHData shareDBJPUSHData];
    [_pushdata addNotification:aps];
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    
    
    
}



#pragma mark ----接收推送消息
- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // 取得 APNs 标准信息内容
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"];                 // 推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];    // badge数量
//    NSString *sound = [aps valueForKey:@"sound"];                   // 播放的声音
//    
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"];  // 服务端中Extras字段，key是自己定义的
//    NSLog(@"\nAppDelegate:\ncontent =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    [self getCurrentVC:userInfo];
    
    [JPUSHService handleRemoteNotification:userInfo];
    

    NSLog(@"iOS7及以上系统，收到通知");
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState==0) {
        
        NSLog(@"iOS7及以上系统，前台 %@",userInfo);
    }
    else{
        NSLog(@"iOS7及以上系统，后台 %@",userInfo);
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (UIViewController *)getCurrentVC:(NSDictionary*)dic
{
    NSString * message = [[dic objectForKey:@"aps"]objectForKey:@"alert"];
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
        NSLog(@"当前控制器%@",result);
    }
    else{
        result = window.rootViewController;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"收到新的推送" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadOrder" object:nil];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    [result presentViewController:alertController animated:YES completion:nil];
    
    NSLog(@"%@",result);
    return result;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    if([CLLocationManager significantLocationChangeMonitoringAvailable])
    {
        [self.location startMonitoringSignificantLocationChanges];
        [self.location stopUpdatingLocation];
    }
    else
    {
        DBLog(@"significant Location Change not Available");
    }
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [application cancelAllLocalNotifications];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadOrder" object:nil];
    if([CLLocationManager significantLocationChangeMonitoringAvailable])
    {
        
        [_location stopMonitoringSignificantLocationChanges];
        
    }
    else
    {
        DBLog(@"significant Location Change not Available");
    }
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    _badgeIndex = 0 ;
    [application setApplicationIconBadgeNumber:_badgeIndex];
    [JPUSHService setBadge:_badgeIndex];

    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
}

@end
