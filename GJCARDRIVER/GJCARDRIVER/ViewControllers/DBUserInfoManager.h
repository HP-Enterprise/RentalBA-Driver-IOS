//
//  DBUserInfoManager.h
//  SelfRental
//
//  Created by 段博 on 2017/3/3.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>


@protocol infoChangeDelegate <NSObject>

-(void)changeMainViewInfo:(NSDictionary*)dic ;

@end




@interface DBUserInfoManager : NSObject

@property (nonatomic,strong)NSDictionary * infoDic ;


@property (nonatomic,strong)CLLocation * parkCoor;

@property (nonatomic,strong)NSString  * userId ;

@property (nonatomic,assign)id <infoChangeDelegate>delegate ;


+ (DBUserInfoManager *)sharedManager ;

-(void)signInWithPassword:(NSDictionary*)dic ;



@end
