//
//  DBGetCarView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^chooseClick)(NSDictionary * model);


@interface DBGetCarView : UIView <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView * waitWorkTable;
@property (nonatomic,strong)NSArray * infoDicArray ;

@property (nonatomic,strong)chooseClick chooseBlock ;

-(instancetype)initWithFrame:(CGRect)frame withDic:(NSArray*)dic ;

@end
