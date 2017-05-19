//
//  UIColor+Hex.h
//  JJHuzhu
//
//  Created by Vision.Wang on 15/8/25.
//  Copyright (c) 2015年 KongGeek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *  获取颜色 含有alpha
 *
 *  @param color 6位16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
