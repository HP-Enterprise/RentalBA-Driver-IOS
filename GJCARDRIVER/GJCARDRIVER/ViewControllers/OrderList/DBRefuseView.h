//
//  DBRefuseView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/15.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^refuseBlock)(NSString*reason);

typedef void(^cancelBlock)(void);

@interface DBRefuseView : UIView



@property (nonatomic,strong)UITextView * reasonTextView ;
@property (nonatomic,strong)refuseBlock refuseBlcok ;
@property (nonatomic,strong)cancelBlock cancelBlock ;
@property (nonatomic,strong)UIView * reasonView ;
-(instancetype)initWithFrame:(CGRect)frame;

@end
