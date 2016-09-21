//
//  BaseViewController.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftSlideViewController.h"
#import "AppDelegate.h"

#define SYColor(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a*1.0]
#define randomColor       SYColor(arc4random()%255, arc4random()%255, arc4random()%255, 1.)

#define rootVC  (LeftSlideViewController *)[[[[UIApplication sharedApplication]delegate]window]rootViewController]

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    //添加导航条上的按钮
    if (self.navigationController.childViewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"artcleList_btn_info_6P" target:self action:@selector(leftClick)];
        
        
    }else{
        
    }
    
}
#pragma 导航条左右边按钮点击
- (void)leftClick
{
    
    [rootVC openLeftView];
        
}

-(void)viewWillAppear:(BOOL)animated{
//    LeftSlideViewController *root=(LeftSlideViewController *)[[(AppDelegate *)[UIApplication sharedApplication].delegate window]rootViewController];
    
    [rootVC setPanEnabled:self.navigationController.childViewControllers.count == 1];

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
