//
//  ViewController5.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController5.h"
#import "RootTool.h"

@interface ViewController5 ()

@end

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downBtn setTitle:@"world" forState:UIControlStateNormal];
    downBtn.frame = CGRectMake(10, 400, 100, 100);
    [self.view addSubview:downBtn];
    [downBtn addTarget:self
                action:@selector(showTable:)
      forControlEvents:UIControlEventTouchUpInside];
    [downBtn setBackgroundColor:[UIColor purpleColor]];
}
- (void)showTable:(UIButton *)btn {
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstLogin"];
    [[[UIApplication sharedApplication]delegate]window].rootViewController=[RootTool choosRootViewController];
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
