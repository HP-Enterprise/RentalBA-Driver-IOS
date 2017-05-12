//
//  DBNetManager.h
//  GJCAR.COM
//
//  Created by 段博 on 16/5/27.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBNetManager : NSObject


@property (nonatomic)int netStatu ;
@property (nonatomic)int judge ;

+ (DBNetManager *)sharedManager;


@end
