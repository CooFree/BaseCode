//
//  ViewController5.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController5.h"
#import "RootTool.h"
#import "RYTLoginManager.h"
#import "AppDelegate.h"

@interface ViewController5 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *rowArr;

@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGFLOAT_MIN)];
    table.sectionHeaderHeight = [self headerHeight];
    table.sectionFooterHeight = [self footerHeight];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
//    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [downBtn setTitle:@"world" forState:UIControlStateNormal];
//    downBtn.frame = CGRectMake(10, 400, 100, 100);
//    [self.view addSubview:downBtn];
//    [downBtn addTarget:self
//                action:@selector(showTable:)
//      forControlEvents:UIControlEventTouchUpInside];
//    [downBtn setBackgroundColor:[UIColor purpleColor]];
}
- (void)showTable:(UIButton *)btn {
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstLogin"];
    [(AppDelegate *)[UIApplication sharedApplication].delegate setupIntroductoryPage];
}
- (CGFloat)headerHeight
{
    return CGFLOAT_MIN;
}

- (CGFloat)footerHeight
{
    return CGFLOAT_MIN;
}

- (NSArray *)rowArr {
    if (_rowArr==nil) {
        _rowArr = @[@"设置",@"启动图"];
    }
    return _rowArr;
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section?10:CGFLOAT_MIN;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 1 : self.rowArr.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=indexPath.section ? @"退出登录" : self.rowArr[indexPath.row] ;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        [[RYTLoginManager shareInstance]doLogout];
        [[[UIApplication sharedApplication]delegate]window].rootViewController=[RootTool choosRootViewController];

    }else{
        switch (indexPath.row) {
            case 0:
                [[NSUserDefaults standardUserDefaults]setBool:![[NSUserDefaults standardUserDefaults] boolForKey:@"touchID"] forKey:@"touchID"];
                break;
            case 1:
                [self showTable:nil];
                break;
            default:
                break;
        }
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
