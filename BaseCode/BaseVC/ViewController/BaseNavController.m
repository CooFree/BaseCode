//
//  BaseNavController.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

+ (void)initialize {
    
    
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[
                                                                                             [self class]
                                                                                             ]];
//    [navBar setBackgroundImage:[UIImage imageNamed:@"navBg"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           NSFontAttributeName : [UIFont systemFontOfSize:20]
                           };
    navBar.tintColor = [UIColor blueColor];
    [navBar setTitleTextAttributes:dict];
    
    
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    return [super pushViewController:viewController animated:animated];
}
/*
 -(void)viewDidLoad{
 [super viewDidLoad];
 //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
 //self.interactivePopGestureRecognizer.delegate = nil;
 
 //禁止手势冲突
 self.interactivePopGestureRecognizer.enabled = NO;
 
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wundeclared-selector"
 UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
 #pragma clang diagnostic pop
 
 pan.delegate = self;
 
 [self.view addGestureRecognizer:pan];
 }
 #pragma mark - 手势代理方法
 // 是否开始触发手势
 - (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
 {
 // 判断下当前控制器是否是跟控制器
 return (self.topViewController != [self.viewControllers firstObject]);
 }
 */
/*
 - (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
 
 NSLog(@"%d",self.childViewControllers.count);
 if (self.childViewControllers.count == 0) {
 
 
 // viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:0 target:self action:@selector(menuClick)];
 viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"menu" style:0 target:self action:@selector(menuClick)];
 
 }else {
 
 
 // viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalWithName:@"NavBack"] style:0 target:self action:@selector(back)];
 
 viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:0 target:self action:@selector(back)];
 
 }
 
 
 [super pushViewController:viewController animated:animated];
 
 
 }
 
 - (void)menuClick {
 
 [[NSNotificationCenter defaultCenter] postNotificationName:@"opendra" object:nil];
 
 NSLog(@"你大爷的");
 
 
 
 }
 
 - (void)back {
 
 
 
 [self popViewControllerAnimated:YES];
 
 
 }
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
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
