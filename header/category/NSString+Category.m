//
//  NSString+Category.m
//  iOS SDK
//
//  Created by 王振 on 16/1/6.
//  Copyright © 2016年 杭州空极科技有限公司. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

/**
 *  获取例如 138****3838 格式的字符串
 *
 *  @return 138****3838 格式的字符串
 */
- (NSString *)safePhone {
    if (self.length != 11) {
        return nil;
    }else {
        return [NSString stringWithFormat:@"%@****%@",[self substringToIndex:3],[self substringWithRange:NSMakeRange(7, 4)]];
    }
}
/**
 *  判断字符串是否为nil 移除 空格 回车 后
 *
 *  @return 移除
 */
- (BOOL)isEmpty {
    if (self != nil) {
        NSString *string = self;
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return YES;
    }
}
/**
 *  获取对象的字符串类型
 *
 *  @param object 对象
 *
 *  @return 字符串类型
 */
- (NSString *)stringForId:(id)object{
    NSString *str = (NSString *)object;
    
    if (str == nil) return @"";
    if (str == NULL) return @"";
    if ([str isKindOfClass:[NSNull class]]) return @"";
    
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}
/**
 *  是否是整型数字类型的字符串
 *  @return YES？NO
 */
- (BOOL)stringIsPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
/**
 *  float判断
 *
 *  @return YES？NO
 */
- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
/**
 *  正则校验
 *
 *  @param type   需要校验的类型
 *
 *  @return YES？NO
 */
- (BOOL)checkStringType:(CheckStringType)type {
    NSString *string = [self stringForId:self];
    if (type == phoneString) {
        if (string.length == 11 && [string hasPrefix:@"1"] && [self stringIsPureInt]) {
            return YES;
        }
    }
    if (type == emailString) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:string];
    }
    if (type == numberString) {
        NSString *emailRegex = @"^[0-9]*$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:string];
    }
    if (type == minusculeString) {
        NSString *emailRegex = @"^[a-z]+$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:string];
    }
    if (type == majusculeString) {
        NSString *emailRegex = @"^[A-Z]+$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:string];
    }
    if (type == IDCardString) {
        BOOL flag;
        if (string.length <= 0) {
            flag = NO;
            return flag;
        }
        NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        return [identityCardPredicate evaluateWithObject:string];
    }
    if (type == SpecialSymbolBut_) {
        BOOL flag;
        if (string.length <= 0) {
            flag = NO;
            return flag;
        }
        NSString *regex2 = @"^[\u4e00-\u9fa5_A-Za-z0-9]+$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
        return [identityCardPredicate evaluateWithObject:string];
    }
    if (type == ChineseString) {
        for(int i = 0; i < [string length]; i++){
            int a = [string characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
                return YES;
        }
    }
    return NO;
}
/**
 自定义正则
 
 @param regularString 正则
 @return 判断
 */
- (BOOL)checkStringRegularString:(NSString *)regularString {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = regularString;
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
/**
 *  获取NSMutableAttributedString类型的字符串
 *
 *  @return NSMutableAttributedString类型的字符串
 */
- (NSMutableAttributedString *)mutableAttributedString {
    return [[NSMutableAttributedString alloc] initWithString:self];
}
/**
 判断是否是几位小数以内的数字
 
 @param count count
 
 @return yes||no
 */
- (BOOL)checkNumberWithMainCount:(NSInteger)count {
    NSArray *array = [self componentsSeparatedByString:@"."];
    if (array.count >= 3) {
        return NO;
    }
    if (array.count == 2) {
        NSString *string1 = array [0];
        NSString *string2 = array [1];
        if (string1.length == 0) {
            return NO;
        }
        if (string2.length > count) {
            return NO;
        }
        if (![string2 checkStringType:numberString]) {
            return NO;
        }
        if (![string1 checkStringType:numberString]) {
            return NO;
        }
    }
    if (array.count == 1) {
        if (![self checkStringType:numberString]) {
            return NO;
        }
    }
    return YES;
}
/**
 字符串长度
 
 @param font 大小
 @return 长度
 */
- (float)widthWithFont:(NSInteger)font {
    CGFloat width = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width;
    return width;
}
/**
 字符串高度
 
 @param font 大小
 @return 长度
 */
- (float)heightWithFont:(NSInteger)font width:(CGFloat)width {
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    return height;

}
/**
 字符串长度
 
 @param font 大小
 @return 长度
 */
- (float)widthWithBoldFont:(NSInteger)font {
    CGFloat width = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]} context:nil].size.width;
    return width;
}
@end
