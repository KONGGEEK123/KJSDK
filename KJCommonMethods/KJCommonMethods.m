//
//  KJCommonMethods.m
//  KJFrameworkProject
//
//  Created by 王振 DemoKing on 2016/11/15.
//  Copyright © 2016年 baozi. All rights reserved.
//

#import "KJCommonMethods.h"

@implementation KJCommonMethods

#pragma mark -
#pragma mark - 关于状态栏

/**
 高亮显示
 */
+ (void)lightStatus {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
/**
 黑色状态
 */
+ (void)darkStatus {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
/**
 隐藏状态
 
 @param hidden <#hidden description#>
 */
+ (void)hiddenStatus:(BOOL)hidden {
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
}

#pragma mark -
#pragma mark - 关于时间

/**
 date 转 固定格式时间
 
 @param date date
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date
                   formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!date) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 时间戳 转 固定格式时间
 
 @param timeString 时间戳字符串
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWith1970TimeString:(NSString *)timeString
                             formatter:(NSString *)formatter {
    NSTimeInterval timeInterval;
    if (timeString.length == 13) {
        // JAVA
        timeInterval = [timeString doubleValue] / 1000;
    } else if (timeString.length == 10) {
        // PHP
        timeInterval = [timeString doubleValue];
    } else {
        return nil;
    }
    if (!formatter) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 时间字符串格式转换
 
 @param timeString 需要转换的时间字符串
 @param fromFormatter 当前格式
 @param toFormatter 转换后的格式
 @return 新的时间字符串
 */
+ (NSString *)stringWithTimeString:(NSString *)timeString
                     fromFormatter:(NSString *)fromFormatter
                       toFormatter:(NSString *)toFormatter {
    if (!fromFormatter) {
        return nil;
    }
    if (!toFormatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDate *date = [KJCommonMethods dateWithTimeString:timeString formatter:fromFormatter];
    NSString *newSting = [KJCommonMethods stringWithDate:date formatter:toFormatter];
    return newSting;
}

/**
 固定格式时间 转 时间戳
 
 @param timeString 时间
 @param formatter 格式
 @return 时间戳
 */
+ (NSString *)timestampWithTimeString:(NSString *)timeString
                            formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDate *date = [KJCommonMethods dateWithTimeString:timeString formatter:formatter];
    NSString *timestamp = [NSString stringWithFormat:@"%lf",[date timeIntervalSince1970]];
    return timestamp;
}

/**
 date 转 时间戳字符串
 
 @param date 时间
 @return 时间戳字符串
 */
+ (NSString *)timestampWithDate:(NSDate *)date {
    if (!date) {
        return nil;
    }
    NSString *timestamp = [NSString stringWithFormat:@"%lf",[date timeIntervalSince1970]];
    return timestamp;
}

/**
 固定格式时间 转 date
 
 @param timeString 时间字符串
 @param formatter 格式
 @return date
 */
+ (NSDate *)dateWithTimeString:(NSString *)timeString
                     formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:formatter];
    NSDate *date = [formatter2 dateFromString:timeString];
    return date;
}

/**
 时间戳 转 date
 
 @param timeString 时间戳
 @return date
 */
+ (NSDate *)dateWith1970TimeString:(NSString *)timeString {
    if (!timeString) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:[timeString integerValue]];
}

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
                           end:(void(^)(void))end {
    if (allSecond == 0) {
        return;
    }
    __block NSInteger timeout = allSecond;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (end) {
                    end();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (perSecond) {
                    perSecond(timeout);
                }
                timeout --;
            });
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -
#pragma mark - 关于快速写入和读取（本地的）值

/**
 NSUserDefaults 存储
 
 @param value 值
 @param key 键
 */
+ (void)saveValue:(id)value
              key:(NSString *)key {
    if (!value) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}

/**
 NSUserDefaults 获取
 
 @param key 键
 @return 对象
 */
+ (id)valueForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/**
 NSUserDefaults 移除
 
 @param key 键
 */
+ (void)removeValueForkey:(NSString *)key {
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

/**
 根据本地json文件读取
 
 @param jsonName 文件名
 @return id
 */
+ (id)jsonName:(NSString *)jsonName {
    if (!jsonName) {
        return nil;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    if (!data) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

#pragma mark -
#pragma mark - 关于系统

/**
 判断是否开启推送
 
 @return YES||NO
 */
+ (BOOL)notificationAuthority {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }
    return NO;
}

/**
 获取当前语言
 
 @return 语言
 */
+ (NSString *)currentLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    return [languages objectAtIndex:0];
}
/**
 版本号
 
 @return 版本号
 */
+ (NSString *)version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

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
+ (int)abs:(int)ab {
    return abs(ab);
}

/**
 浮点型 取绝对值
 
 @param fab fab
 @return return
 */
+ (CGFloat)fabs:(CGFloat)fab {
    return fabs(fab);
}

/**
 向上取整
 
 @param c c
 @return NSInteger
 */
+ (NSInteger)ceilf:(CGFloat)c {
    return ceilf(c);
}

/**
 向下取整
 
 @param f f
 @return NSInteger
 */
+ (NSInteger)floor:(CGFloat)f {
    return floor(f);
}

/**
 获取随机数
 
 @param from 从
 @param to 到
 @return 随机数
 */
+ (NSInteger)randomNumberFromValue:(int)from
                           toValue:(int)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

/**
 float类型保留x位小数
 
 @param number number
 @param position position
 @return NSString
 */
+ (NSString *)positionNumber:(float)number
                    position:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

/**
 保留1位小数 但是小数为0时不保留小数
 
 @param number number
 @return 字符串
 */
+ (NSString *)floatNoZero:(CGFloat)number position:(NSInteger)position{
    NSString *string = [KJCommonMethods positionNumber:number position:(int)position];
    NSString *lastString = [[string componentsSeparatedByString:@"."] lastObject];
    if ([lastString integerValue] == 0) {
        return [[string componentsSeparatedByString:@"."] firstObject];
    }else {
        return string;
    }
}

#pragma mark -
#pragma mark - 关于JSON解析

/**
 将对象（如dictionary）转化为json
 
 @param dataObject 对象
 @return 字符串
 */
+ (NSString *)toJSONString:(id)dataObject {
    if (!dataObject) {
        return nil;
    }
    if ([NSJSONSerialization isValidJSONObject:dataObject]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataObject options:NSJSONWritingPrettyPrinted error:&error];
        if(error) {
            return nil;
        }
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

/**
 将json字符串转化为dictionary
 
 @param JSONString JSON string
 @return 字典
 */
+ (NSDictionary *)toDictionary:(NSString *)JSONString {
    if (JSONString == nil) {
        return nil;
    }
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

/**
 将json字符串转化为array
 
 @param JSONString json
 @return array
 */
+ (NSArray *)toArray:(NSString *)JSONString {
    if (JSONString == nil) {
        return nil;
    }
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        return nil;
    }
    return array;
}

#pragma mark -
#pragma mark - UUID

/**
 过去UUID

 @return UUID
 */
+ (NSString *)generateUUID {
    CFUUIDRef theUUID =CFUUIDCreate(NULL);
    CFStringRef guid = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *uuidString = [((__bridge NSString *)guid)stringByReplacingOccurrencesOfString:@"-"withString:@""];
    CFRelease(guid);
    return uuidString;
}

/**
 判断是否开启推送

 @return YES
 */
+ (BOOL)isAllowedNotification {
    if ([KJCommonMethods isSystemVersioniOS8]) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }else {
        //            UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        //            if(UIRemoteNotificationTypeNone != type)
        //                return YES;
    }
    return NO;
}
+ (BOOL)isSystemVersioniOS8 {
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 8.0f) {
        return YES;
    }
    return NO;
}

+ (void)call:(NSString *)phone {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
