//
//  SGLocationPickerCenterView.h
//  SGPickerView_DatePickerExample
//
//  Created by Jack on 16/9/23.
//  Copyright © 2016年 Jack. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface SGLocationPickerCenterView : UIView

/** pickerView */
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

/** 取消按钮的点击事件 */
- (void)addTargetCancelBtn:(id)target action:(SEL)action;
/** 确定按钮的点击事件 */
- (void)addTargetSureBtn:(id)target action:(SEL)action;

@end
