//
//  UIButton+selfButton.h
//  NewStyle
//
//  Created by 段博 on 16/9/30.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (selfButton)


-(void)setAttrubutwithTitle:(NSString*)title withTitleColor:(UIColor*)color withFont:(NSInteger)font;

-(void)setAttrubutwithTitle:(NSString*)title TitleColor:(UIColor*)titleColor BackColor:(UIColor*)color Font:(NSInteger)font CornerRadius:(NSInteger)cornerRadius BorderWidth:(NSInteger)width BorderColor:(UIColor*)borderColor;

-(void)setAttrubutwithTitle:(NSString*)title withBackColor:(UIColor*)color withBackImage:(UIImage*)backImage withSelectImage:(UIImage*)selectImage;

-(void)setAttrubutwithTitle:(NSString*)title withBackColor:(UIColor*)color withBackImage:(UIImage*)backImage withHighlightedImage:(UIImage*)HighlightedImage;

@end
