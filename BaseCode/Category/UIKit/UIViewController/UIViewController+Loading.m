//
//  UIViewController+Loading.m
//  NeiHan
//
//  Created by Charles on 16/5/15.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//
#pragma mark - 颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kCommonGrayTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]
#define kCommonRedColor [UIColor colorWithRed:0.91f green:0.33f blue:0.33f alpha:1.00f]
#define kBgColor kRGBColor(243,245,247)
#define kLineBgColor [UIColor colorWithRed:0.86f green:0.88f blue:0.89f alpha:1.00f]
#define kTextColor [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f]
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kRGBColor(r,g,b) kRGBAColor(r,g,b,1.0f)
#define kCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]
#define kSeperatorColor kRGBColor(234,237,240)
#define kDetailTextColor [UIColor colorWithRed:0.56f green:0.60f blue:0.62f alpha:1.00f]
#define kCommonTintColor [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f]
#define kCommonBgColor [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f]
#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]
#define kLeftMargin 15

#pragma mark - 系统UI
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  粗体 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)

#pragma mark - 字符串转化
#define kEmptyStr @""
#define kIntToStr(i) [NSString stringWithFormat: @"%d", i]
#define kIntegerToStr(i) [NSString stringWithFormat: @"%ld", i]
#define kValidStr(str) [NHUtils validString:str]


#import "UIViewController+Loading.h"
#import "UIView+Frame.h"

#import <objc/runtime.h>
const static char loadingViewKey;

@interface UIViewControllerLodingView : UIView
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIActivityIndicatorView *indView;
@end

@implementation UIViewControllerLodingView

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _label = label;
        label.font = kFont(13);
        label.textColor = kTextColor;
        label.text = @"正在加载...";
    }
    return _label;
}

- (UIActivityIndicatorView *)indView {
    if (!_indView) {
        UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:ind];
        _indView = ind;
    }
    return _indView;
}

- (void)startAnimating {
    [self.indView startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(self.width / 2.0 - 30, self.height / 2.0 - 40, 80, 40);
    self.indView.frame = CGRectMake(self.width / 2.0 - 70, self.label.y, 40, 40);
}

@end

@implementation UIViewController (Loading)

- (void)showLoadingView {
    [self showLoadingViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
}

- (UIView *)loadingView {
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)setLoadingView:(UIView *)loadingView {
    objc_setAssociatedObject(self, &loadingViewKey, loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showLoadingViewWithFrame:(CGRect)frame {
    if (!self.loadingView) {
        UIViewControllerLodingView *loadingView = [[UIViewControllerLodingView alloc]
                                                init];
        self.loadingView = loadingView;
        loadingView.frame = frame;
        [self.view addSubview:self.loadingView];
        loadingView.center = self.view.center;
        loadingView.centerY = self.view.centerY - 50;
        [loadingView startAnimating];
    }
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}
@end
