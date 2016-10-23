//
//  ViewController2.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController2.h"
#import "GradientProgressController.h"

#import "ViewController.h"

@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *textArr;
}
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGFLOAT_MIN)];
    table.sectionHeaderHeight = [self headerHeight];
    table.sectionFooterHeight = [self footerHeight];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    textArr=@[@"顶部 GradientProgress",@"ActionSheetView",@"文字绘写-写文字",
              @"文字绘写-刷新文字",@"AlertView",@"MBTwitterScroll",@"新浪弹框动画",@"带箭头弹框"];
    
}
- (CGFloat)headerHeight
{
    return CGFLOAT_MIN;
}

- (CGFloat)footerHeight
{
    return CGFLOAT_MIN;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return textArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=textArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            GradientProgressController *view = [[GradientProgressController alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
        {
            ViewController *view = [[ViewController alloc]init];
            view.index=indexPath.row;
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
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
