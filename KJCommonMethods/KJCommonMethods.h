//
//  KJCommonMethods.h
//  KJFrameworkProject
//
//  Created by 王振 DemoKing on 2016/11/15.
//  Copyright © 2016年 baozi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJCommonMethods : NSObject

#pragma mark -
#pragma mark - 关于状态栏

/**
 高亮显示
 */
+ (void)lightStatus;

/**
 黑色状态
 */
+ (void)darkStatus;

/**
 隐藏状态

 @param hidden YES||NO
 */
+ (void)hiddenStatus:(BOOL)hidden;

#pragma mark -
#pragma mark - 关于时间

/**
 date 转 固定格式时间
 
 @param date date
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date
                   formatter:(NSString *)formatter;

/**
 时间戳 转 固定格式时间
 
 @param timeString 时间戳字符串
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWith1970TimeString:(NSString *)timeString
                             formatter:(NSString *)formatter;

/**
 时间字符串格式转换

 @param timeString 需要转换的时间字符串
 @param fromFormatter 当前格式
 @param toFormatter 转换后的格式
 @return 新的时间字符串
 */
+ (NSString *)stringWithTimeString:(NSString *)timeString
                     fromFormatter:(NSString *)fromFormatter
                       toFormatter:(NSString *)toFormatter;

/**
 固定格式时间 转 时间戳

 @param timeString 时间
 @param formatter 格式
 @return 时间戳
 */
+ (NSString *)timestampWithTimeString:(NSString *)timeString
                            formatter:(NSString *)formatter;

/**
 date 转 时间戳字符串

 @param date 时间
 @return 时间戳字符串
 */
+ (NSString *)timestampWithDate:(NSDate *)date;

/**
 固定格式时间 转 date

 @param timeString 时间字符串
 @param formatter 格式
 @return date
 */
+ (NSDate *)dateWithTimeString:(NSString *)timeString
                     formatter:(NSString *)formatter;

/**
 时间戳 转 date

 @param timeString 时间戳
 @return date
 */
+ (NSDate *)dateWith1970TimeString:(NSString *)timeString;

#pragma mark -
#pragma mark - 关于倒计时

/**
 倒计时

 @param allSecond 总秒数
 @param perSecond 每秒回调
 @param end 结束回调
 */
+ (void)countDownWithAllSecond:(NSInteger)allSecond
                     perSecond:(void(^)(NSInteger second))perSecond
                           end:(void(^)(void))end;

#pragma mark -
#pragma mark - 关于快速写入和读取（本地的）值

/**
 NSUserDefaults 存储

 @param value 值
 @param key 键
 */
+ (void)saveValue:(id)value
              key:(NSString *)key;

/**
 NSUserDefaults 获取

 @param key 键
 @return 对象
 */
+ (id)valueForKey:(NSString *)key;

/**
 NSUserDefaults 移除

 @param key 键
 */
+ (void)removeValueForkey:(NSString *)key;

/**
 根据本地json文件读取

 @param jsonName 文件名
 @return id
 */
+ (id)jsonName:(NSString *)jsonName;

#pragma mark -
#pragma mark - 关于系统

/**
 判断是否开启推送

 @return YES||NO
 */
+ (BOOL)notificationAuthority;

/**
 获取当前语言

 @return 语言
 */
+ (NSString *)currentLanguage;

/**
 版本号

 @return 版本号
 */
+ (NSString *)version;

#pragma mark -
#pragma mark - 关于数字格式转换

/**
 *  取绝对值 整形
 *
 *  @param fab
 *
 *  @return
 */

/**
 取绝对值

 @param ab ab
 @return ab
 */
+ (int)abs:(int)ab;

/**
 浮点型 取绝对值

 @param fab fab
 @return return
 */
+ (CGFloat)fabs:(CGFloat)fab;

/**
 向上取整

 @param c c
 @return NSInteger
 */
+ (NSInteger)ceilf:(CGFloat)c;

/**
 向下取整

 @param f f
 @return NSInteger
 */
+ (NSInteger)floor:(CGFloat)f;

/**
 获取随机数

 @param from 从
 @param to 到
 @return 随机数
 */
+ (NSInteger)randomNumberFromValue:(int)from
                           toValue:(int)to;

/**
 float类型保留x位小数

 @param number number
 @param position position
 @return NSString
 */
+ (NSString *)positionNumber:(float)number
                    position:(int)position;

/**
 保留小数 但是小数为0时不保留小数

 @param number number
 @return 字符串
 */
+ (NSString *)floatNoZero:(CGFloat)number position:(NSInteger)position;

#pragma mark -
#pragma mark - 关于JSON解析

/**
 将对象（如dictionary）转化为json

 @param dataObject 对象
 @return 字符串
 */
+ (NSString *)toJSONString:(id)dataObject;

/**
 将json字符串转化为dictionary

 @param JSONString JSON string
 @return 字典
 */
+ (NSDictionary *)toDictionary:(NSString *)JSONString;

/**
 将json字符串转化为array

 @param JSONString json
 @return array
 */
+ (NSArray *)toArray:(NSString *)JSONString;

#pragma mark -
#pragma mark - UUID

/**
 过去UUID
 
 @return UUID
 */
+ (NSString *)generateUUID;

/**
 判断是否开启推送
 
 @return YES
 */
+ (BOOL)isAllowedNotification;

/**
 拨打电话

 @param phone 电话号码
 */
+ (void)call:(NSString *)phone;
@end
