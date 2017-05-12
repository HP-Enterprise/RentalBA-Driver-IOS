//
//  DBDatePickerView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/18.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBDatePicker.h"

typedef void(^chooseDateBlcok)(NSDate*date);
typedef void(^cancelDateBlcok)(void);

@interface DBDatePickerView : UIView
{
    DBDatePicker * datePicker ;
}

@property(nonatomic,strong)chooseDateBlcok chooseDateBlock;
@property(nonatomic,strong)cancelDateBlcok cancelDateBlcok;
-(instancetype)initWithFrame:(CGRect)frame ;

@end
