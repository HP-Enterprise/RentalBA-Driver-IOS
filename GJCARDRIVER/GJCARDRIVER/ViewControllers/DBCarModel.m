//
//  DBCarModel.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/7/20.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBCarModel.h"

@implementation DBCarModel

-(NSDictionary*)carModel{
    if (!_carModel) {
        _carModel = [NSDictionary dictionary];
    }
    return _carModel ;
}

-(NSString*)state{
    if (!_state) {
        _state = [NSString string];
        _state = @"全部" ;
    }
    
    return _state ;
    
}

@end
