 

//
//  DBUserInfoManager.m
//  SelfRental
//
//  Created by 段博 on 2017/3/3.
//  Copyright © 2017年 DuanBo. All rights reserved.
//


#import "DBUserInfoManager.h"



@implementation DBUserInfoManager

+ (DBUserInfoManager *)sharedManager{
    static DBUserInfoManager * infoManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        infoManager = [[self alloc] init];
    });
    return infoManager;
}

-(void)signInWithPassword:(NSDictionary*)dic{

    [DBUserInfoManager sharedManager].infoDic= [NSDictionary dictionary];
    [DBUserInfoManager sharedManager].userId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] ;
    [DBNewtWorkData loadDriverInfoGet:nil parameters:dic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {
            [DBUserInfoManager sharedManager].infoDic =[[NSArray arrayWithArray:[responseObject objectForKey:@"message"]]firstObject] ;
        }
    } failure:^(NSError *error) {
        
    }];
    
}


@end
