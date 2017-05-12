//
//  DBUserInfoView.h
//  SelfRental
//
//  Created by 段博 on 2017/3/17.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^deletBtBlock)(void);
@interface DBUserInfoView : UIView





@property (nonatomic,strong)NSDictionary * userInfoDic ;

@property (nonatomic,strong)deletBtBlock deletBtBlock ;

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary*)dic withModel:(NSDictionary*)model
;
@end
