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
    
    _carName  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth/2, 40)];
    [_carName setAttrubutwithText:@"测试车辆" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:0];
    [self.contentView addSubview:_carName];
    
    _chooseBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseBt.frame = CGRectMake(ScreenWidth - 60, 35, 50, 30);
    [_chooseBt setAttrubutwithTitle:@"选择" TitleColor:[UIColor blackColor] BackColor:BascColor Font:12 CornerRadius:3 BorderWidth:0 BorderColor:nil];
    [self.contentView addSubview:_chooseBt];
    
    
    _carNumber = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_carName.frame), ScreenWidth/2 - 20, 15)];
    [_carNumber setAttrubutwithText:@"车牌 ：沪123123" withFont:12 withBackColor:nil withTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1] withTextAlignment:0];
    [self.contentView addSubview:_carNumber];
    
    _carColor  = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-20, _carNumber.frame.origin.y, ScreenWidth/2 - 20, 15)];
    [_carColor setAttrubutwithText:@"颜色 ：银色" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:0  ];
    [self.contentView addSubview:_carColor];
    
    _carMileage = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_carNumber.frame)+5, ScreenWidth/2 - 20, 15)];
    [_carMileage setAttrubutwithText:@"当前里程 ：" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:0  ];
    [self.contentView addSubview:_carMileage];
    
    _carStatus = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-20, CGRectGetMaxY(_carNumber.frame)+5, ScreenWidth/2 - 20, 15)];
    [_carStatus setAttrubutwithText:@"车辆状态 ：银色" withFont:12 withBackColor:nil withTextColor:baseColor withTextAlignment:0  ];
    [self.contentView addSubview:_carStatus];

    
    
    
}



-(void)config:(NSDictionary*)dic{
    
    
    
    
    _carName.text = [[dic objectForKey:@"vehicleModelShow"] objectForKey:@"model"];
    _carNumber.text =[NSString stringWithFormat:  @"车牌 ：%@",[dic objectForKey:@"plate"]];
    _carColor.text = [NSString stringWithFormat:  @"车辆颜色 ：%@",[dic objectForKey:@"colour"]];
    _carMileage.text = [NSString stringWithFormat:@"当前里程 ：%@",[dic objectForKey:@"mileage"]];
    
    if ([[dic objectForKey:@"state"]isEqualToString:@"ready"]) {
        _carStatus.text = @"车辆状态 ：待租赁";
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
