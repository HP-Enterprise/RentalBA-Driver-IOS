//
//  DBCarListCell.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBCarListCell.h"

#define baseColor [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]

@implementation DBCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    CGFloat width = (ScreenWidth - 50 ) / 5 ;
    
    _carName  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth/2, 40)];
    [_carName setAttrubutwithText:@"测试车辆" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:0];
    [self.contentView addSubview:_carName];
    

    
    _carNumber = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_carName.frame), width, 15)];
    [_carNumber setAttrubutwithText:@"沪123123" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:1];
    _carNumber.adjustsFontSizeToFitWidth = YES ;
    [self.contentView addSubview:_carNumber];
    
    UILabel * carNumberText = [[UILabel alloc]initWithFrame:CGRectMake(_carNumber.frame.origin.x, CGRectGetMaxY(_carNumber.frame) + 5, _carNumber.frame.size.width, _carNumber.frame.size.height)];
    [carNumberText setAttrubutwithText:@"车牌" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:1];
    [self.contentView addSubview:carNumberText];
    
    
    _carMileage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_carNumber.frame), _carNumber.frame.origin.y , width, 15)];
    [_carMileage setAttrubutwithText:@"200" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:1  ];
    [self.contentView addSubview:_carMileage];
    
    
    UILabel * mileageText = [[UILabel alloc]initWithFrame:CGRectMake(_carMileage.frame.origin.x, CGRectGetMaxY(_carMileage.frame) + 5, _carMileage.frame.size.width, _carMileage.frame.size.height)];
    [mileageText setAttrubutwithText:@"公里" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:1];
    [self.contentView addSubview:mileageText];
    
    
    _carColor  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_carMileage.frame), _carNumber.frame.origin.y, width, 15)];
    [_carColor setAttrubutwithText:@"12/16" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:1  ];
    [self.contentView addSubview:_carColor];
    
    
    UILabel * fuelText = [[UILabel alloc]initWithFrame:CGRectMake(_carColor.frame.origin.x, CGRectGetMaxY(_carColor.frame) + 5, _carColor.frame.size.width, _carColor.frame.size.height)];
    [fuelText setAttrubutwithText:@"油量" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:1];
    [self.contentView addSubview:fuelText];

    
    _carStatus = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_carColor.frame),_carNumber.frame.origin.y, width, 15)];
    [_carStatus setAttrubutwithText:@"待租赁" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:1  ];
    [self.contentView addSubview:_carStatus];

    UILabel * stateText = [[UILabel alloc]initWithFrame:CGRectMake(_carStatus.frame.origin.x, CGRectGetMaxY(_carStatus.frame) + 5, _carColor.frame.size.width, _carColor.frame.size.height)];
    [stateText setAttrubutwithText:@"状态" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:1];
    [self.contentView addSubview:stateText];
    
    _chooseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseBt.frame = CGRectMake(ScreenWidth - 60, 35, 50, 30);
    [_chooseBt setAttrubutwithTitle:@"提车" TitleColor:[UIColor blackColor] BackColor:BascColor Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    [self.contentView addSubview:_chooseBt];
    
}



-(void)config:(NSDictionary*)dic{
    
    _carName.text = [[dic objectForKey:@"vehicleModelShow"] objectForKey:@"model"];
    _carNumber.text =[NSString stringWithFormat:  @"%@",[dic objectForKey:@"plate"]];
    _carColor.text = [NSString stringWithFormat:  @"%@",[dic objectForKey:@"colour"]];
    _carMileage.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mileage"]];
    
    if ([[dic objectForKey:@"state"]isEqualToString:@"ready"]) {
        _carStatus.text = @"待租赁";
    }
    else{
        _carStatus.text = @"租赁中";
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
