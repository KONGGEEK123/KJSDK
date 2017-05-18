//
//  NSString+Category.h
//  iOS SDK
//
//  Created by 王振 on 16/1/6.
//  Copyright © 2016年 杭州空极科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CheckStringType) {
    /**
     *  手机号
     */
    phoneString = 0,
    /**
     *  邮箱
     */
    emailString,
    /**
     *  全数字
     */
    numberString,
    /**
     *  全小写字母
     */
    minusculeString,
    /**
     *  全大写字母
     */
    majusculeString,
    /**
     *  身份证
     */
    IDCardString,
    /**
     *  全中文字符
     */
    ChineseString,
    /**
     *  无特殊符号但是包含 _
     */
    SpecialSymbolBut_,
};
@interface NSString (Category)

/**
 *  获取例如 138****3838 格式的字符串
 *
 *  @return 138****3838 格式的字符串
 */
- (NSString *)safePhone;
/**
 *  判断字符串是否为nil 移除 空格 回车 后
 *
 *  @return 1
 */
- (BOOL)isEmpty;
/**
 *  获取对象的字符串类型
 *
 *  @return 字符串类型
 */
- (BOOL)stringIsPureInt;
/**
 *  float判断
 *
 *  @return YES？NO
 */
- (BOOL)isPureFloat;
/**
 *  正则校验
 *
 *  @param type   需要校验的类型
 *
 *  @return YES？NO
 */
- (BOOL)checkStringType:(CheckStringType)type;
/**
 自定义正则

 @param regularString 正则
 @return 判断
 */
- (BOOL)checkStringRegularString:(NSString *)regularString;
/**
 *  获取NSMutableAttributedString类型的字符串
 *
 *  @return NSMutableAttributedString类型的字符串
 */
- (NSMutableAttributedString *)mutableAttributedString;

/**
 判断是否是几位小数以内的数字

 @param count count

 @return yes||no
 */
- (BOOL)checkNumberWithMainCount:(NSInteger)count;
/**
 字符串长度
 
 @param font 大小
 @return 长度
 */
- (float)widthWithFont:(NSInteger)font;
/**
 字符串高度
 
 @param font 大小
 @return 长度
 */
- (float)heightWithFont:(NSInteger)font width:(CGFloat)width;
/**
 字符串长度
 
 @param font 大小
 @return 长度
 */
- (float)widthWithBoldFont:(NSInteger)font;
@end
