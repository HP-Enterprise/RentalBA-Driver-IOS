//
//  DBPickerView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/23.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^chooseBlcok)(NSString*chooseOil);
typedef void(^cancelBlcok)(void);




@interface DBPickerView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView * pickerView ;
@property (nonatomic,strong)UIButton * submitBt ;
@property (nonatomic,strong)UIButton * cancelBt ;
@property (nonatomic,strong)NSArray * dataArray ;
@property (nonatomic,strong)NSString * chooseData;

@property(nonatomic,strong)chooseBlcok chooseBlock;
@property(nonatomic,strong)cancelBlcok cancelBlcok;


-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray*)data;

@end
