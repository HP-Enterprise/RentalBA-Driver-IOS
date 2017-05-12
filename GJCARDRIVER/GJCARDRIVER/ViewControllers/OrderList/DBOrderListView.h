
//  DBOrderListView.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^OrderName)(NSString*orderName);
typedef void(^ScrollViewMove)(NSInteger moveFloat);

@interface DBOrderListView : UIView 

@property (nonatomic,strong)UIButton * waitWorkBt;
@property (nonatomic,strong)UIButton  *workingBt ;
@property (nonatomic,strong)UIButton * finishWorkBt;


//记录上一次点击按钮
@property (nonatomic,strong)UIButton * lastBt;
@property (nonatomic,strong)UIView * indexView;

@property (nonatomic,strong)OrderName orderNameBlcok;
@property (nonatomic,strong)ScrollViewMove scrollViewMove;

@end
