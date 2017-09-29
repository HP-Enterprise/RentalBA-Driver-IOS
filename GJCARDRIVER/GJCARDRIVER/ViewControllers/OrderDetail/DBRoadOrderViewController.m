//
//  DBRoadOrderViewController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2017/8/29.
//  Copyright © 2017年 DuanBo. All rights reserved.
//

#import "DBRoadOrderViewController.h"
#import "DBRoadTableViewCell.h"

#import "DBAddInfoViewController.h"
#import "MJRefresh.h"

@interface DBRoadOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView * tipView;
@end

@implementation DBRoadOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
}


-(void)setUI{
    [self.view addSubview:self.orderList];
    [self setNavigation];
    
}
-(void)setNavigation{
    self.title = @"路单信息";
    self.navigationController.navigationBar.barTintColor = BascColor ;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self leftBarButtonItem]];
   
    if ([[NSString stringWithFormat:@"%@",self.orderModel.dispatchStatus] isEqualToString:@"50"]) {

    }
    else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self rightBarButtonItem]];

    }
    
}

//返回按钮
-(UIButton*)leftBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(20, 8, 30, 28);
    [userButton setAttrubutwithTitle:@"返回" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(BackBtClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}

//添加按钮
-(UIButton*)rightBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(ScreenWidth - 50, 8, 30, 28);
    [userButton setAttrubutwithTitle:@"添加" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(addBtClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}

-(void)addBtClick{
    
    DBAddInfoViewController * add = [[DBAddInfoViewController alloc]initWithNibName:@"DBAddInfoViewController" bundle:nil];
    add.orderModel = self.orderModel;
    add.contrectInfo = self.contractInfo;
    add.index = @"add";
    [self.navigationController pushViewController:add animated:YES];

}


-(void)BackBtClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 message =     (
 {
 contractCode = 1222221131;
 contractType = 0;
 driverId = 1;
 fuelCharge = 1;
 hotelExpenses = 3;
 id = 4;
 license = "\U6d59A3UF67";
 otherExpenses = 4;
 parkingTollFee = 2;
 realName = "\U6bdb\U5e86";
 refuelingMileage = 1;
 remark = 122222211;
 returnCarActualDate = 1503988292000;
 returnCarMileage = 0;
 status = 0;
 takeCarActualDate = 1503988292000;
 takeCarMileage = 123;
 vehicleId = 9886;
 }
 );
 status = true;
 */
-(void)loadData{
    [DBNewtWorkData loadRoadOrderGet:nil parameters:self.orderModel success:^(id responseObject) {
        if ([responseObject[@"status"]isEqualToString:@"true"]) {
            if (![responseObject[@"message"]isKindOfClass:[NSNull class]]) {
                 self.orderArray = [NSMutableArray arrayWithArray:responseObject[@"message"]];
                if (self.orderArray.count > 0) {
                    
                }
                else{
                    [self tipShow:@"没有相关信息"];
                    [self.orderList.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [self.orderList performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        }
        else{
            [self tipShow:@"加载失败"];
        }
        
    } failure:^(NSError *error) {
        [self tipShow:@"连接失败"];
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBRoadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellList"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DBRoadTableViewCell" owner:nil options:nil]firstObject];
    }
    cell.editBt.tag = indexPath.row + 400;
    cell.deleteBt.tag = indexPath.row + 500;
    [cell.editBt addTarget:self action:@selector(editForm:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBt addTarget:self action:@selector(deleteForm:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = 0;
    if ([[NSString stringWithFormat:@"%@",self.orderModel.dispatchStatus] isEqualToString:@"50"]) {
        cell.deleteBt.hidden = YES;
        [cell.editBt setTitle:@"详情" forState:UIControlStateNormal];
    }
    
    [cell config:self.orderArray[indexPath.row]];
    return cell;
}

-(void)editForm:(UIButton*)button{
    
    DBAddInfoViewController * add = [[DBAddInfoViewController alloc]initWithNibName:@"DBAddInfoViewController" bundle:nil];
    add.roadOrder = self.orderArray[button.tag - 400];
    add.orderModel = self.orderModel;
    add.contrectInfo = self.contractInfo;
    add.index = @"edit";
    if ([[NSString stringWithFormat:@"%@",self.orderModel.dispatchStatus] isEqualToString:@"50"]) {
        add.index = @"show";
    }
    [self.navigationController pushViewController:add animated:YES];
}

-(void)deleteForm:(UIButton*)button{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除路单" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteOrder:button];
       
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [ self presentViewController:alertController animated:YES completion:nil];
   
}

-(void)deleteOrder:(UIButton*)button{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DBNewtWorkData deleteRoadOrder:nil orderId:self.orderArray[button.tag - 500][@"id"] success:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"]isEqualToString:@"true"]) {
            [self deleteViewMove:button];
            [self tipShow:@"删除成功"];
        }
        else{
            [self tipShow:@"删除失败"];
        }
    } failure:^(NSError *error) {
        [self tipShow:@"连接失败"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

-(void)deleteViewMove:(UIButton*)button{
    [self.orderArray removeObjectAtIndex:button.tag - 500];  //删除数组里的数据
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:button.tag - 500 inSection:0] ;
    [self.orderList  deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];  //删除对应数据的cell
    [self.orderList performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}



-(UITableView*)orderList{
    if (!_orderList) {
        _orderList = [[UITableView alloc]init];
        _orderList.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _orderList.delegate = self;
        _orderList.dataSource= self;
        _orderList.showsVerticalScrollIndicator = NO;
        _orderList.showsHorizontalScrollIndicator = NO;
        _orderList.separatorStyle = 0 ;
        _orderList.tableFooterView = [[UITableView alloc]initWithFrame:CGRectZero];
        _orderList.backgroundColor =[UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
        _orderList.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_orderList.mj_header endRefreshing];
            [self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:YES];
        }];

    }
    return _orderList;
}
-(NSMutableArray*)orderArray{
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];

    }
    return _orderArray;
}
- (void)tipShow:(NSString *)str
{
    if (self.tipView) {
        [self.tipView removeFromSuperview];
    }
    self.tipView = [[DBTipView alloc]initWithHeight:0.8 * ScreenHeight WithMessage:str];
    [self.view addSubview:self.tipView];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
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
