//
//  NSMutableAttributedString+RText.m
//  NSMutableAttributedString+Category
//
//  Created by 袁斌 on 16/9/4.
//  Copyright © 2016年 https://github.com/DefaultYuan/NSMutableAttributedString-RText. All rights reserved.
//

#import "NSMutableAttributedString+RText.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (RText)

#pragma mark 初始化
+ (NSMutableAttributedString *)attrStrWithString:(NSString *)fulString
{
    return [[NSMutableAttributedString alloc] initWithString:fulString];
}

#pragma mark 添加字体颜色
+ (void)addForegroundColorAttrNameWithColor:(UIColor *)color
                                      range:(NSRange)range
                                    attrStr:(NSMutableAttributedString *)attrStr
{
    //    [attrStr addAttribute:NSStrokeWidthAttributeName
    //                    value:@(range.length)
    //                    range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:range];
    //    [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(1) range:range];
}

#pragma mark 添加字体间距
+ (void)addFontSpaceAttrNameWithSpace:(CGFloat)space
                                range:(NSRange)range
                              attrStr:(NSMutableAttributedString *)attrStr
{
    long number = space;
    CFNumberRef numRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attrStr addAttribute:(id)kCTKernAttributeName
                    value:(__bridge id)numRef
                    range:range];
    CFRelease(numRef);
}

#pragma mark 添加行间距
+ (void)addParagraphStyleAttributeNameWithSpace:(CGFloat)space
                                          range:(NSRange)range
                                        attrStr:(NSMutableAttributedString *)attrStr
{
    NSMutableParagraphStyle *prgpStyle = [[NSMutableParagraphStyle alloc] init];
    [prgpStyle setLineSpacing:space];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:prgpStyle
                    range:range];
}

+ (NSMutableAttributedString *)colorAttrStringWithString:(NSString *)fuString
                                                fixColor:(UIColor *)changeColor
                                              subStrings:(NSArray<NSString *> *)subStrsArray

{
    NSMutableAttributedString *attributedStr = [self attrStrWithString:fuString];
    
    for (NSString *rangeStr in subStrsArray) {
        NSRange range = [fuString rangeOfString:rangeStr
                                        options:NSBackwardsSearch];
        [self addForegroundColorAttrNameWithColor:changeColor
                                            range:range
                                          attrStr:attributedStr];
    }
    return attributedStr;
}

+ (NSMutableAttributedString *)fontSpaceAttrStringWithString:(NSString *)fuString
                                                   fontSpace:(CGFloat)space
{
    NSMutableAttributedString *attrStr = [self attrStrWithString:fuString];
    [self addFontSpaceAttrNameWithSpace:space
                                  range:NSMakeRange(0, attrStr.length)
                                attrStr:attrStr];
    return attrStr;
}

+ (NSMutableAttributedString *)paragraphLineSpaceAttrWithString:(NSString *)fullStr
                                                      lineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attrStr = [self attrStrWithString:fullStr];
    [self addParagraphStyleAttributeNameWithSpace:lineSpace
                                            range:NSMakeRange(0, fullStr.length)
                                          attrStr:attrStr];
    return attrStr;
    
}

+ (NSMutableAttributedString *)fontSpaceAndLineSpaceAttrStrWithString:(NSString *)fullStr
                                                            fontSpace:(CGFloat)fontSpace
                                                            lineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attrStr = [self attrStrWithString:fullStr];
    [self addFontSpaceAttrNameWithSpace:fontSpace
                                  range:NSMakeRange(0, attrStr.length)
                                attrStr:attrStr];
    [self addParagraphStyleAttributeNameWithSpace:lineSpace
                                            range:NSMakeRange(0, fullStr.length)
                                          attrStr:attrStr];
    return attrStr;
}

@end
