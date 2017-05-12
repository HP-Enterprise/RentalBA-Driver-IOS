//
//  UIButton+selfButton.m
//  NewStyle
//
//  Created by 段博 on 16/9/30.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "UIButton+selfButton.h"

@implementation UIButton (selfButton)


-(void)setAttrubutwithTitle:(NSString*)title withTitleColor:(UIColor*)color withFont:(NSInteger)font{
    UIButton * button = (UIButton*)self;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = [UIFont systemFontOfSize:font];
    }

}

-(void)setAttrubutwithTitle:(NSString*)title TitleColor:(UIColor*)titleColor BackColor:(UIColor*)color Font:(NSInteger)font CornerRadius:(NSInteger)cornerRadius BorderWidth:(NSInteger)width BorderColor:(UIColor*)borderColor{
    UIButton * button = (UIButton*)self;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (color) {
        [button setBackgroundColor:color];
    }
    if (font) {
        button.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    if (cornerRadius) {
         button.layer.cornerRadius =cornerRadius;
    }
    if (width) {
        button.layer.borderWidth = 1 ;
    }
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor ;

    }
    
    
}

-(void)setAttrubutwithTitle:(NSString*)title withBackColor:(UIColor*)color withBackImage:(UIImage*)backImage withSelectImage:(UIImage*)selectImage{
    UIButton * button = (UIButton*)self;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [button setBackgroundColor:color];
    }
    if (backImage) {
        [button setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [button setBackgroundImage:backImage forState:UIControlStateSelected];
    }
    

}


-(void)setAttrubutwithTitle:(NSString*)title withBackColor:(UIColor*)color withBackImage:(UIImage*)backImage withHighlightedImage:(UIImage*)HighlightedImage{
    UIButton * button = (UIButton*)self;
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [button setBackgroundColor:color];
    }
    if (backImage) {
        [button setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (HighlightedImage) {
        [button setBackgroundImage:backImage forState:UIControlStateHighlighted];
    }
 
}




@end
