//
//  DBOrderInfoView.h
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBOrderInfoView : UIView <UIScrollViewDelegate>



@property (nonatomic,strong)DBWaitWorkModel * model ;

@property (nonatomic,strong)NSDictionary * orderDIc ;
@property (nonatomic,strong)UIScrollView * detailScrollView ;


-(instancetype)initWithFrame:(CGRect)frame withData:(NSDictionary*)dic withOder:(NSString*)orderId withModel:(DBWaitWorkModel *)model ;


@end
