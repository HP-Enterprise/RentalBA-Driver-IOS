//
//  DBGetCarView.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/4/14.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBGetCarView.h"
#import "DBCarListCell.h"
@implementation DBGetCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withDic:(NSArray*)dic{
    self = [super initWithFrame:frame];
    if (self) {
        self.infoDicArray = dic ;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    [self addSubview:self.waitWorkTable];
}

-(void)reloadData:(NSArray*)array{
    self.infoDicArray = array ;
    [self.waitWorkTable reloadData];
    
}

-(UITableView*)waitWorkTable{
    if (!_waitWorkTable) {
        
        _waitWorkTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 )];
        _waitWorkTable.showsVerticalScrollIndicator = NO ;
        _waitWorkTable.showsHorizontalScrollIndicator = NO ;
        _waitWorkTable.delegate =self ;
        _waitWorkTable.dataSource = self ;
        _waitWorkTable.backgroundColor = [UIColor clearColor];
        _waitWorkTable.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
//        _waitWorkTable.separatorStyle = 0 ;
    }
    return _waitWorkTable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 2 ;
    return self.infoDicArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView == _finishWorkTable) {
//        return 136 ;
//    }
    return 100 ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DBCarListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"carListCell"];
    if (cell == nil) {
        cell = [[DBCarListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"carListCell"];
    }
    cell.selectionStyle  = 0 ;

    [cell config:self.infoDicArray[indexPath.row]];
    cell.chooseBt.tag = 100 + indexPath.row ;
    [cell.chooseBt addTarget:self action:@selector(acceptBtClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}


-(void)acceptBtClick:(UIButton*)button{
    
    self.chooseBlock(self.infoDicArray[button.tag - 100]);
    
}


@end
