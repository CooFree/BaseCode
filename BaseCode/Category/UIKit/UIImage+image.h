//
//  UIImage+image.h
//  01-城觅
//
//  Created by xiaomage on 16/8/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

//图片不被系统渲染

+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

/**
 *  根据颜色生成一张图片
 *  @param color 提供的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
