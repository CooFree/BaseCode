//
//  BaseTabBar.m
//  BaseCode
//
//  Created by yssj on 16/9/20.
//  Copyright © 2016年 YSSJ. All rights reserved.
//

#import "BaseTabBar.h"
#import "UIImage+image.h"

#define LBMagin 10
@interface BaseTabBar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;
@property (nonatomic, weak) UILabel *plusLabel ;

@end


@implementation BaseTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        
        //[self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        
        self.plusBtn = plusBtn;
        
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"发布";
        label.textAlignment=NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [label sizeToFit];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        
        self.plusLabel=label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _plusBtn.frame=CGRectMake(self.frame.size.width / 5 * 2, self.bounds.size.height - 55-20, self.frame.size.width / 5, 55);
    _plusLabel.frame=CGRectMake(self.frame.size.width / 5 * 2, CGRectGetMaxY(_plusBtn.frame), self.frame.size.width / 5, 23);

}


//点击了发布按钮
- (void)plusBtnDidClick
{
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            __weak typeof(self) weakSelf = self;
            
            return weakSelf.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
