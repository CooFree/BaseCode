//
//  BaseTabBar.h
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTabBar;

@protocol BaseTabBarDelegate <NSObject>

@optional
- (void)tabBarPlusBtnClick:(BaseTabBar *)tabBar;

@end

@interface BaseTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<BaseTabBarDelegate> myDelegate ;

@end
