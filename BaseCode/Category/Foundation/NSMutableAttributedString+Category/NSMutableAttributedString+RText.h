//
//  NSMutableAttributedString+RText.h
//  NSMutableAttributedString+Category
//
//  Created by 袁斌 on 16/9/4.
//  Copyright © 2016年 https://github.com/DefaultYuan/NSMutableAttributedString-RText. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (RText)
/**
 *  改变字符串中某些字的颜色
 *  @param fullString   整个字符串
 *  @param changeColor  这些字需要改变的颜色
 *  @param subStrsArray 存储需要改变字体颜色的字符串
 *  @return 富文本
 */
+ (NSMutableAttributedString *)colorAttrStringWithString:(NSString *)fuString
                                                fixColor:(UIColor *)changeColor
                                              subStrings:(NSArray<NSString *> *)subStrsArray;
/**
 *  改变字符串的间距
 *  @param fuString 需要改的字符串
 *  @param space    子间距
 *  @return 富文本
 */
+ (NSMutableAttributedString *)fontSpaceAttrStringWithString:(NSString *)fuString
                                                   fontSpace:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *  @param fullStr   需要更改的字符串
 *  @param lineSpace 行间距
 *  @return 富文本
 */
+ (NSMutableAttributedString *)paragraphLineSpaceAttrWithString:(NSString *)fullStr
                                                      lineSpace:(CGFloat)lineSpace;

+ (NSMutableAttributedString *)fontSpaceAndLineSpaceAttrStrWithString:(NSString *)fullStr
                                                            fontSpace:(CGFloat)fontSpace
                                                            lineSpace:(CGFloat)lineSpace;
@end
