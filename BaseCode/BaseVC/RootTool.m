//
//  RootTool.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "RootTool.h"
#import "BaseTabBarController.h"
#import "LeftSlideViewController.h"
#import "ViewController2.h"

@implementation RootTool

+ (UIViewController *)choosRootViewController {
    
    
    //    DGBDragerViewController *mainVC = [[DGBDragerViewController alloc] init];
    
    BaseTabBarController *tabVC = [[BaseTabBarController alloc] init];
//    UIViewController *leftVC=[[UIViewController alloc]init];
    ViewController2 *leftVC=[[ViewController2 alloc]init];
    LeftSlideViewController *LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabVC];
    
    
    return LeftSlideVC;
    
    
}

@end
