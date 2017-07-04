//
//  DBFinishOrderDetailController.m
//  GJCARDRIVER
//
//  Created by 段博 on 2016/11/14.
//  Copyright © 2016年 DuanBo. All rights reserved.
//

#import "DBFinishOrderDetailController.h"
#import "DBFinishOrderDetailView.h"

//门到门订单
#import "DBDoorOrderVIew.h"

@interface DBFinishOrderDetailController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * detailScrollView ;
@property (nonatomic,strong)NSDictionary * dataDic ;


@end

@implementation DBFinishOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBasicUI];
    
    [self loadData];
    
}

//执行订单
-(void)loadData{
    
    [DBNewtWorkData orderIdGet:nil parameters:self.model success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"]isEqualToString:@"true"]) {

            self.dataDic = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"message"]];
            
            [self performSelectorOnMainThread:@selector(setUI) withObject:nil waitUntilDone:YES];
        }
        else{
            
        }
        
        NSLog(@"%@",responseObject);
 
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setBasicUI{
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.97 alpha:1];
    [self setNavigation];
    
   
}

-(void)setNavigation{
    self.title = @"订单详情";
    self.navigationController.navigationBar.barTintColor = BascColor ;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self leftBarButtonItem]];
    
    
}

//返回按钮
-(UIButton*)leftBarButtonItem{
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(20, 8, 30, 28);
    [userButton setAttrubutwithTitle:@"返回" withTitleColor:[UIColor blackColor] withFont:14];
    [userButton addTarget:self action:@selector(BackBtClick) forControlEvents:UIControlEventTouchUpInside];
    return userButton ;
}
-(void)BackBtClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setUI{

    
    [self setScrollView];
    
    
    if ([self.model.orderType isEqualToString:@"2"]) {
        
        DBDoorOrderVIew * doorView = [[DBDoorOrderVIew alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 276) withData:self.dataDic withOder:self.model.orderCode withModel:self.model];
        [_detailScrollView addSubview:doorView];
        
    }
    else{
        
        DBFinishOrderDetailView * detailView = [[DBFinishOrderDetailView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 396) withData:self.dataDic withOder:self.model.orderCode withModel:self.model];
        [_detailScrollView addSubview:detailView];
    }
    
    
 
    
}

-(void)setScrollView{
    
    _detailScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 396)];
    _detailScrollView.backgroundColor  = [UIColor whiteColor];
    _detailScrollView.showsVerticalScrollIndicator = NO;
    _detailScrollView.showsHorizontalScrollIndicator = NO ;
    _detailScrollView.delegate =self ;
    [self.view addSubview:_detailScrollView ];
    
    if ([self.model.orderType isEqualToString:@"2"]) {
        
        _detailScrollView.frame = CGRectMake(0, 64, ScreenWidth, 276);
    }

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
