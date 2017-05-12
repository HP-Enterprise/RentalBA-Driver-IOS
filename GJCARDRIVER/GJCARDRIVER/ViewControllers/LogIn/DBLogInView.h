//
//  DBLogInView.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^signInBlock)(id dic);
typedef void(^forGetPw)(void);

@interface DBLogInView : UIView
{
    DBProgressAnimation * _progress;
}
@property (nonatomic,strong)UIImageView * logoImageV;
@property (nonatomic,strong)UIView * userInfoView ;
@property (nonatomic,strong)UIButton * submitBt ;

@property (nonatomic,strong)DBTextField * userNameField ;
@property (nonatomic,strong)DBTextField * passWordField ;

@property (nonatomic,strong)signInBlock signInBlock ;
@property (nonatomic,strong)forGetPw forGetPw ;
-(instancetype)init;
@end
