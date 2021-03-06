
//
//  DBUserInfoView.m
//  SelfRental
//
//  Created by 段博 on 2017/3/17.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBUserInfoView.h"
#import "DBSelfView.h"

@implementation DBUserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withDic:(NSDictionary*)dic withModel:(NSDictionary*)model
{
    if (self =  [super initWithFrame:frame]) {
        
        self.userInfoDic = dic ;
        
        
        
        [self createUserInfo];
        
    }
    return self;
}

-(NSDictionary*)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [NSDictionary dictionary];
    }
    return  _userInfoDic ;
}

#pragma mark --创建个人信息view
-(void)createUserInfo
{
    
    
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth , 300)];
    baseView.backgroundColor = [UIColor whiteColor] ;
    [self addSubview:baseView];
    
    //循环创建
    for (int i = 0 ; i < 8; i ++){
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 + i * 40 , ScreenWidth, 0.5)];
        lineView.backgroundColor  =  [UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1];
        [baseView addSubview:lineView];
    }
    //头像
    UILabel * imageLabel = [[UILabel alloc]initWithFrame:CGRectMake( 20, 0, ScreenWidth /2, 40)];
    imageLabel.text = @"头像";
    imageLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    imageLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:imageLabel];
    
    
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 60 , 5, 30, 30 )];
    imageV.image = [UIImage imageNamed:@"userImage"];
    imageV.layer.cornerRadius = 15 ;
    imageV.layer.masksToBounds = YES ;
    [baseView addSubview:imageV];
    
    
//    //昵称
//    UILabel * nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40 , ScreenWidth /2 , 40)];
//    nickNameLabel.text = @"昵称" ;
//    nickNameLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
//    nickNameLabel.font = [UIFont systemFontOfSize:14];
//    [baseView addSubview:nickNameLabel];
//    
//    //昵称
//    
//    UILabel * nickName = [[UILabel alloc]initWithFrame:CGRectMake( 0 , 40 , ScreenWidth  - 30  , 40)];
//    
//    nickName.text =[self.userInfoDic objectForKey:@"username"] ;
//    nickName.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
//    nickName.font = [UIFont systemFontOfSize:14];
//    nickName.textAlignment = 2 ;
//    [baseView addSubview:nickName];
//    nickName.tag = 450 ;
//    
    
//    UIImageView * editImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 16 ,nickNameLabel.frame.origin.y + 14 , 6  , 11 )];
//    //    classImage.backgroundColor = [UIColor redColor];
//    editImage.image =[UIImage imageNamed:@"next"];
//    [baseView addSubview:editImage];
//    
//    
//    //修改昵称
//    UIControl * changeNickName = [[UIControl alloc]initWithFrame:CGRectMake(20, nickNameLabel.frame.origin.y, ScreenWidth - 20, 30)];
//    
//    [changeNickName addTarget:self action:@selector(changeNickName) forControlEvents:UIControlEventTouchUpInside];
//    [baseView addSubview:changeNickName];
    
    
    //姓名
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40 , ScreenWidth /2 , 40)];
    nameLabel.text = @"姓名" ;
    nameLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:nameLabel];
    
    
    //名字
    
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake( 0 ,nameLabel.frame.origin.y , ScreenWidth  - 30  , 40)];
    
    if (![[self.userInfoDic objectForKey:@"name"]isKindOfClass:[NSNull class]]) {
        name.text =[self.userInfoDic objectForKey:@"name"] ;

    }
    name.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = 2 ;
    [baseView addSubview:name];
    name.tag = 451 ;
    /*
     
     
     balance = 0;
     createDate = "<null>";
     createUser = "<null>";
     deposit = 1000;
     driveLicenseFrontUrl = "<null>";
     driveLicenseReverseUrl = "<null>";
     id = 2;
     idCardFrontUrl = "<null>";
     idCardNo = "<null>";
     idCardReverseUrl = "<null>";
     isEnable = 1;
     latitude = "<null>";
     licenseNo = "<null>";
     longitude = "<null>";
     modifyDate = "<null>";
     modifyUser = "<null>";
     password = faa83f722f4165fe2a37da657fb52f5f;
     phone = 13666666667;
     realname = "\U6d4b\U8bd52";
     registerDate = "<null>";
     salt = DJng;
     state = authenticated;
     username = 13666666667;
     
     
     */
    
    
//    UIImageView * cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 16 ,name.frame.origin.y + 14 , 6  , 11 )];
//    //    classImage.backgroundColor = [UIColor redColor];
//    cardImage.image =[UIImage imageNamed:@"next"];
//    cardImage.tag = 461;
//    [baseView addSubview:cardImage];
//    
    
    //修改姓名
//    UIControl * cardKinde = [[UIControl alloc]initWithFrame:CGRectMake(20, name.frame.origin.y, ScreenWidth - 20, 30)];
//    
//    [cardKinde addTarget:self action:@selector(changeCardInfo) forControlEvents:UIControlEventTouchUpInside];
//    [baseView addSubview:cardKinde];
//    
//    
    //证件类型
    UILabel * cardNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(name.frame) , ScreenWidth /2 , 40)];
    cardNumberLabel.text =@"所属部门" ;
    cardNumberLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    cardNumberLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:cardNumberLabel];
//
    //证件号码
    
    UILabel * carNumber= [[UILabel alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(name.frame) , ScreenWidth  - 30  , 40)];
    
    if (![[self.userInfoDic objectForKey:@"storeName"]isKindOfClass:[NSNull class]]){

        carNumber.text =[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"storeName"]] ;

    }

    carNumber.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    carNumber.font = [UIFont systemFontOfSize:14];
    carNumber.textAlignment = 2 ;
    [baseView addSubview:carNumber];

    
    //
    UILabel * licenseKinkLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(carNumber.frame) , ScreenWidth /2 , 40)];
    licenseKinkLabel.text = @"驾驶证类型" ;
    licenseKinkLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    licenseKinkLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:licenseKinkLabel];
    
    //邮箱账号
    
    UILabel * emailNumber= [[UILabel alloc]initWithFrame:CGRectMake( 0 ,CGRectGetMaxY(carNumber.frame) , ScreenWidth  - 30  , 40)];
    
    
    if (![[self.userInfoDic objectForKey:@"drivingLicenseLevel"]isKindOfClass:[NSNull class]])
    {
        if ([[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseLevel"]]isEqualToString:@"0"]) {
            emailNumber.text = @"C2";
        }

        if ([[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseLevel"]]isEqualToString:@"1"]) {
            emailNumber.text = @"C1";
        }

        if ([[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseLevel"]]isEqualToString:@"2"]) {
            emailNumber.text = @"B2";
        }

        if ([[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseLevel"]]isEqualToString:@"3"]) {
            emailNumber.text = @"B1";
        }
        if ([[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseLevel"]]isEqualToString:@"4"]) {
            emailNumber.text = @"A1";
        }

    }
    
    
    emailNumber.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    emailNumber.font = [UIFont systemFontOfSize:14];
    emailNumber.textAlignment = 2 ;
    [baseView addSubview:emailNumber];
    emailNumber.tag = 455 ;
    
    
    
    
    //驾驶证
    UILabel * licenseNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(licenseKinkLabel.frame) , ScreenWidth /2 , 40)];
    licenseNoLabel.text =@"驾驶证" ;
    licenseNoLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    licenseNoLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:licenseNoLabel];
    //
    //证件号码
    
    UILabel * licenseNumber= [[UILabel alloc]initWithFrame:CGRectMake( 0 ,licenseNoLabel.frame.origin.y , ScreenWidth  - 30  , 40)];
    
    if (![[self.userInfoDic objectForKey:@"drivingLicenseNumber"]isKindOfClass:[NSNull class]]){
        
        licenseNumber.text =[NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"drivingLicenseNumber"]] ;
        
    }
    
    licenseNumber.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    licenseNumber.font = [UIFont systemFontOfSize:14];
    licenseNumber.textAlignment = 2 ;
    [baseView addSubview:licenseNumber];
    
    //手机
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(licenseNoLabel.frame) , ScreenWidth /2 , 40)];
    phoneLabel.text = @"手机号" ;
    phoneLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    phoneLabel.font = [UIFont systemFontOfSize:14];
    [baseView addSubview:phoneLabel];
    
    //手机号码
    
    UILabel * phoneNumber= [[UILabel alloc]initWithFrame:CGRectMake( 0 ,phoneLabel.frame.origin.y , ScreenWidth  - 30  , 40)];
    phoneNumber.text = [NSString stringWithFormat:@"%@",[self.userInfoDic objectForKey:@"phone"]] ;
    phoneNumber.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    phoneNumber.font = [UIFont systemFontOfSize:14];
    phoneNumber.textAlignment = 2 ;
    [baseView addSubview:phoneNumber];
    phoneNumber.tag = 454 ;
    
    

    //版本号


    UILabel * changePw = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(phoneLabel.frame), ScreenWidth - 20, 40)];
    changePw.text = @"当前版本" ;
    changePw.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    changePw.font = [UIFont systemFontOfSize:14];
    changePw.textAlignment = 0 ;
    [baseView addSubview:changePw];


    NSString* oldversion =[[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)@"CFBundleShortVersionString"];

    
    
    UILabel * versionLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, changePw.frame.origin.y, ScreenWidth - 30 , 40)];
    versionLabel.text = [NSString stringWithFormat:@"v%@",oldversion];
    versionLabel.textColor = [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1];
    versionLabel.font = [UIFont systemFontOfSize:14];
    versionLabel.textAlignment = 2 ;
    [baseView addSubview:versionLabel];
    
    
    

    //注销
    UIButton * alipayBt = [UIButton buttonWithType:UIButtonTypeCustom];
    alipayBt.frame = CGRectMake( 50 , CGRectGetMaxY(versionLabel.frame)+40 ,ScreenWidth - 100  , 30 );
    [alipayBt setTitle:@"退出" forState:UIControlStateNormal];
    [alipayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alipayBt.titleLabel.font = [UIFont systemFontOfSize:14 ];
    alipayBt.layer.cornerRadius = 5 ;
    alipayBt.backgroundColor = [UIColor colorWithRed:0.95 green:0.78 blue:0.11 alpha:1];
    [alipayBt addTarget:self action:@selector(deletBt) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:alipayBt];
//
    
}


-(void)deletBt{

    self.deletBtBlock();
}

@end
