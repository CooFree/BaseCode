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
#import "WSMovieController.h"
#import "WJViewController.h"
#import "RYTLoginManager.h"


@implementation RootTool

+ (UIViewController *)choosRootViewController {
    
    
    BOOL isFirstLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] boolValue];
    if (!isFirstLogin) {
        //是第一次
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
        WSMovieController *wsCtrl = [[WSMovieController alloc]init];
        wsCtrl.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"]];
        return wsCtrl;
    }else if([RYTLoginManager isLogin]){
        
        
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"touchID"]) {
            WJViewController *view=[[WJViewController alloc]init];
            return view;
        }
        
        //不是首次启动
        BaseTabBarController *tabVC = [[BaseTabBarController alloc] init];
        //    UIViewController *leftVC=[[UIViewController alloc]init];
        ViewController2 *leftVC=[[ViewController2 alloc]init];
        LeftSlideViewController *LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabVC];
            return LeftSlideVC;
    }else{
        //不是首次启动
        BaseTabBarController *tabVC = [[BaseTabBarController alloc] init];
        //    UIViewController *leftVC=[[UIViewController alloc]init];
        ViewController2 *leftVC=[[ViewController2 alloc]init];
        LeftSlideViewController *LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabVC];
        return LeftSlideVC;
    }
    

    

}

+ (void)setupTabViewController{
    BaseTabBarController *tabVC = [[BaseTabBarController alloc] init];
    //    UIViewController *leftVC=[[UIViewController alloc]init];
    ViewController2 *leftVC=[[ViewController2 alloc]init];
    LeftSlideViewController *LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabVC];
    
    [[[[UIApplication sharedApplication]delegate]window]setRootViewController:LeftSlideVC];
}

@end
