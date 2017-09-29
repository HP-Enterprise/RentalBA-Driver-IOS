//
//  ViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/29.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "ViewController.h"
#import "DBRoadTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}


-(void)setUI{
    
}


-(void)loadData{
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBRoadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellList"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DBRoadTableViewCell.h" owner:self options:nil]firstObject];
    }
    return cell;
}



-(UITableView*)orderList{
    if (!_orderList) {
        _orderList = [[UITableView alloc]init];
        _orderList.delegate = self;
        _orderList.dataSource= self;
        _orderList.showsVerticalScrollIndicator = YES;
        _orderList.showsHorizontalScrollIndicator = YES;
        _orderList.separatorStyle = 0 ;
        _orderList.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
    }
    return _orderList;
}
-(NSArray*)orderArray{
    if (!_orderArray) {
        _orderArray = [NSArray array];
    }
    return _orderArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
