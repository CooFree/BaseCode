//
//  SGDatePickerSheetView.h
//  SGPickerView_DatePickerExample
//
//  Created by Jack on 16/9/23.
//  Copyright © 2016年 Jack. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface SGDatePickerSheetView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
/** 取消按钮的点击事件 */
- (void)addTargetCancelBtn:(id)target action:(SEL)action;
/** 确定按钮的点击事件 */
- (void)addTargetSureBtn:(id)target action:(SEL)action;

@end
