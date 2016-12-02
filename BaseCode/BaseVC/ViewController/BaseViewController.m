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
#import "BaseNavController.h"
#import "BaseTabBarController.h"

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

+ (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[LeftSlideViewController class]]) {
        result = [(LeftSlideViewController *)result mainVC];
    }
    if ([result isKindOfClass:[BaseTabBarController class]]) {
        result = [(BaseTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (void)presentVC:(UIViewController *)viewController{
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [[BaseNavController alloc] initWithRootViewController:viewController];
    if (!viewController.navigationItem.leftBarButtonItem) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalViewControllerAnimated:)];
    }
    [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}



@end
