//
//  UILabel+selfLebel.m
//  NewStyle
//
//  Created by 段博 on 16/9/28.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "UILabel+selfLebel.h"

@implementation UILabel (selfLebel)

-(void)setAttrubutwithText:(NSString*)text withFont:(NSInteger)font withBackColor:(UIColor*)color withTextColor:(UIColor*)textColor withTextAlignment:(NSInteger)textAlignment{
    
    UILabel * label = (UILabel*)self;
    
    if (text) {
        label.text = text ;
    }
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    if (color) {
        label.backgroundColor = color ;
    }
    if (textColor) {
        label.textColor = textColor ;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment ;
    }
 
}




@end
