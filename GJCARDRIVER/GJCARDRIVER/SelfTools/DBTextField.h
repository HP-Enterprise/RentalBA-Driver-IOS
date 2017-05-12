//
//  DBTextField.h
//  GJCARDRIVER.COM
//
//  Created by 段博 on 2016/11/8.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTextField : UIView

@property (nonatomic)CGFloat floatH;
@property(nonatomic,strong)UITextField *field;

-(instancetype)initWithFrame:(CGRect)frame withImage:(UIImage*)image;
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)title;

@end
