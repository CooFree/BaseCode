//
//  UIView+Boom.h
//  粒子效果demo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 雷晏. All rights reserved.
//


/*用法
 
 -(void)GCDMethod:(UIView *)myView afterTime:(NSTimeInterval)interval{
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 [myView boom];
 });
 }
 
 */

#import <UIKit/UIKit.h>

@interface UIView (Boom)

-(void)boom;
@end
