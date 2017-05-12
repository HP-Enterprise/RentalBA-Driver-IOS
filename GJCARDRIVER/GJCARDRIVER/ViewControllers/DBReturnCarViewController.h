//
//  DBReturnCarViewController.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/16.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnCarClick)(void);

@interface DBReturnCarViewController : UIViewController

@property (nonatomic,strong)DBWaitWorkModel * model ;

@property (nonatomic,strong)NSString * vehicleId ;
@property (nonatomic,strong)NSDictionary * infoddic;
@property (nonatomic,strong)returnCarClick returnCar ;

@property (nonatomic,copy)NSString *index ;

@end
