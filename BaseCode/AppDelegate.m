//
//  AppDelegate.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTool.h"
#import "BaseTabBarController.h"
#import "ViewController2.h"
#import "LeftSlideViewController.h"
#import "WSMovieController.h"
#import "RYTLoginManager.h"
#import "WJViewController.h"
#import "introductoryPagesHelper.h"
#import "AdvertiseHelper.h"
#import "LoginViewController.h"
#import "BaseNavController.h"

#import "IQKeyboardManager.h"

#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kIntroPageKey @"intro_page_version"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    
//    self.window.rootViewController = [RootTool choosRootViewController];
    
    
    [self setupTabViewController];
    
//    if([RYTLoginManager isLogin]){
//        [self setupTouchIDViewController];
//    }else
//        [self setupLoginViewController];
    
 
//    [self setupIntroductoryPage];

    [self.window makeKeyAndVisible];
    
    if([RYTLoginManager isLogin]){
        [self setupTouchIDViewController];
    }else
        [self setupLoginViewController];
    
    [self setupFunctionIntroPage];
    [self setupAdveriseView];
    //键盘统一收回处理
    [self configureBoardManager];
    
    return YES;
}
- (void)setupLoginViewController {
    LoginViewController *vc=[[LoginViewController alloc]init];
//    [self.window setRootViewController:vc];
    [[BaseViewController presentingVC] presentViewController:vc animated:YES completion:nil];
}
- (void)setupTouchIDViewController {
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"touchID"]) {
        WJViewController *view=[[WJViewController alloc]init];
        [self.window setRootViewController:view];
    }
}
#pragma mark 启动广告
-(void)setupAdveriseView
{
    // TODO 请求广告接口 获取广告图片
    
    //现在了一些固定的图片url代替
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    
    [AdvertiseHelper showAdvertiserView:imageArray];
}
- (void)setupFunctionIntroPage {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *preVersion = [defaults stringForKey:kIntroPageKey];
    BOOL needToShow = ![preVersion isEqualToString:kVersion_Coding];
    if (needToShow) {
        NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
        [introductoryPagesHelper showIntroductoryPageView:images];
        
        [defaults setValue:kVersion_Coding forKey:kIntroPageKey];
        [defaults synchronize];
    }
   
}
- (void)setupIntroductoryPage {
    BOOL isNoFirstLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLogin"] boolValue];
    if (isNoFirstLaunch) {
       return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isFirstLogin"];
    WSMovieController *wsCtrl = [[WSMovieController alloc]init];
    wsCtrl.movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"]];
    [self.window setRootViewController:wsCtrl];
    
   
    
}
- (void)setupTabViewController {
    BaseTabBarController *tabVC = [[BaseTabBarController alloc] init];
    ViewController2 *leftVC=[[ViewController2 alloc]init];
    LeftSlideViewController *LeftSlideVC= [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:tabVC];
    
    [self.window setRootViewController:LeftSlideVC];
}
#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
