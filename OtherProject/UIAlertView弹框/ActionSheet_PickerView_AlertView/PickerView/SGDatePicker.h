//
//  SGDatePicker.h
//  SGPickerView_DatePickerExample
//
//  Created by Jack on 16/9/23.
//  Copyright © 2016年 Jack. All rights reserved.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SGDatePickerTypeBottom,
    SGDatePickerTypeCenter,
} SGDatePickerType;

typedef void (^DataTimeSelect)(NSDate *selectDataTime);

@interface SGDatePicker : UIView

/** SGDatePickerType */
@property (nonatomic, assign) SGDatePickerType datePickerType;
/** 当前选中的Date */
@property (nonatomic, strong) NSDate *selectDate;
/** 是否可选择当前时间之前的时间, 默认为NO */
@property (nonatomic, assign) BOOL isBeforeTime;
/** DatePickerMode, 默认是DateAndTime */
@property (nonatomic, assign) UIDatePickerMode datePickerMode;

- (void)didFinishSelectedDate:(DataTimeSelect)selectDataTime;
- (void)show;

@property (nonatomic, strong) NSDate *maxSelectDate;
/** 优先级低于isBeforeTime */
@property (nonatomic, strong) NSDate *minSelectDate;

@end
