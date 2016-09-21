//
//  BaseTabBarController.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavController.h"
#import "BaseTabBar.h"

@interface BaseTabBarController ()<BaseTabBarDelegate>

@end

@implementation BaseTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(BaseTabBar *)tabBar
{
    
    NSLog(@"plusBtnClick");
    self.selectedIndex=2;

}

#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    NSArray *childName = @[@"ViewController1",
                           @"ViewController2",
                           @"ViewController3",
                           @"ViewController4",
                           @"ViewController5",
                           ];
    
    NSArray *image = @[@"home_normal",@"fish_normal",@"",@"message_normal",@"account_normal"];
    NSArray *selectedImage=@[@"home_highlight",@"fish_highlight",@"",@"message_highlight",@"account_highlight"];
    
    for (NSString *className  in childName) {
        
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        
        BaseNavController *nabBar = [[BaseNavController alloc] initWithRootViewController:vc];
        vc.navigationItem.title = className;
        vc.tabBarItem.title = className;
        NSInteger i=[childName indexOfObject:className];
        UIImage *myImage = [UIImage imageNamed:image[i]];
        myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
        vc.tabBarItem.image = myImage;
        
        UIImage *mySelectedImage = [UIImage imageNamed:selectedImage[i]];
        mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = mySelectedImage;
        
        [self addChildViewController:nabBar];
        
    }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    BaseTabBar *tabbar = [[BaseTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    
    // Do any additional setup after loading the view.
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
