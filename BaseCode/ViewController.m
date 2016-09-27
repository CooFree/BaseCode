//
//  ViewController.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController.h"

#import "HJCActionSheet.h"
#import "PDPullToRefresh.h"
#import "FDAlertView.h"
#import "ContentView.h"

@interface ViewController ()<HJCActionSheetDelegate,UITableViewDataSource,FDAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    switch (_index) {
        case 1:
            [self HJCActionSheetView];
            break;
        case 2:
        {
            [self initTableView];
            [self addPDRefresh];
        }
            break;
        case 3:
            [self AlertView];
            break;
            
        default:
            break;
    }
}




#pragma mark - HJCActionSheet

- (void)HJCActionSheetView{
    UIButton *btn=[UIButton buttonWithTitle:@"Click" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick)];
    btn.frame=CGRectMake(0, 70, 60, 30);
    [self.view addSubview:btn];
}

- (void)btnClick{
    // 1.创建HJCActionSheet对象, 可以随意设置标题个数，第一个为取消按钮的标题，需要设置代理才能监听点击结果
    HJCActionSheet *sheet = [[HJCActionSheet alloc] initWithDelegate:self CancelTitle:@"取消" OtherTitles:@"哈哈", @"嘿嘿", @"哄哄", nil];
    // 2.显示出来
    [sheet show];
}
// 3.实现代理方法，需要遵守HJCActionSheetDelegate代理协议
- (void)actionSheet:(HJCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
//            _testLabel.text = @"哈哈";
            break;
        case 2:
//            _testLabel.text = @"嘿嘿";
            break;
        case 3:
//            _testLabel.text = @"哄哄";
            break;
    }
}

#pragma mark - 文字绘写

- (void)addPDRefresh
{
    [self.tableView pd_addHeaderRefreshWithNavigationBar:YES andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Header - ActionHandler");
            [self.tableView.pdHeaderRefreshView stopRefreshing];
        });
    }];
    //    [self.tableView.pdHeaderRefreshView startRefreshing];
    
    [self.tableView pd_addFooterRefreshWithNavigationBar:YES andActionHandler:^{
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"Footer - ActionHandler");
            [self.tableView.pdFooterRefreshView stopRefreshing];
        });
    }];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
    return cell;
}

#pragma  mark - AlertView
- (void)AlertView{
    UIButton *btn=[UIButton buttonWithTitle:@"一般的信息弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn.frame=CGRectMake(0, 70, 160, 30);
    btn.tag=100;
    [self.view addSubview:btn];
    UIButton *btn1=[UIButton buttonWithTitle:@"带图标的信息弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn.frame=CGRectMake(0, 170, 160, 30);
    btn.tag=101;
    [self.view addSubview:btn1];
    UIButton *btn2=[UIButton buttonWithTitle:@"可自定义内容弹框" normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor] fontSize:14. target:self action:@selector(btnClick2:)];
    btn.frame=CGRectMake(0, 270, 160, 30);
    btn.tag=102;
    [self.view addSubview:btn2];
}
- (void)btnClick2:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
        {
            FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"退出登录" icon:nil message:@"确定退出登录吗？" delegate:self buttonTitles:@"确定", @"取消", nil];
            [alert setMessageColor:[UIColor redColor] fontSize:0];
            [alert show];
        }
            break;
        case 101:
        {
            FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"退出登录" icon:[UIImage imageNamed:@"exclamation-icon"] message:@"你确定退出登录吗？" delegate:self buttonTitles:@"确定", @"取消", nil];
            [alert show];
        }
            break;
        case 102:
        {
            FDAlertView *alert = [[FDAlertView alloc] init];
            ContentView *contentView = [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:nil options:nil].lastObject;
            contentView.frame = CGRectMake(0, 0, 270, 220);
            alert.contentView = contentView;
            [alert show];
        }
            break;
            
        default:
            break;
    }
}
- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
