//
//  ViewController3.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"31_2"]];
    view.frame=CGRectMake(0, 65, 80, 80);
    [self.view addSubview:view];
    
    UIScrollView *scro=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scro];
    
    for (int i=0; i<6; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 200+i*90, 200, 80)];
        textField.borderStyle=UITextBorderStyleRoundedRect;
        [scro addSubview:textField];
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
