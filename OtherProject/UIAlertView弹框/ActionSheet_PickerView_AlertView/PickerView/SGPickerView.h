//
//  SGPickerView.h
//  SGPickerView_DatePickerExample
//
//  Created by Jack on 16/9/23.
//  Copyright © 2016年 Jack. All rights reserved.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SGPickerViewTypeBottom,
    SGPickerViewTypeCenter,
} SGPickerViewType;

typedef void(^MyBlock)(NSString *);

@interface SGPickerView : UIView
/** SGPickerViewType */
@property (nonatomic, assign) SGPickerViewType pickerViewType;
/** 用于传值 */
@property (copy, nonatomic) MyBlock locationMessage;

- (void)show;

@end
