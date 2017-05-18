//
//  KJPhotoKitUtil.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoKitUtil.h"

@implementation KJPhotoKitUtil
/**
 *  获取颜色 含有alpha
 *
 *  @param color 6位16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1];
}
/**
 弹框 UIAlertViewController
 
 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param sureButtonTitle 确定按钮
 @param viewController 视图控制器
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
              inViewController:(id)viewController
                   cancelBlock:(void(^)(void))cancelBlock
                     sureBlock:(void(^)(void))sureBlock {
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (sureButtonTitle) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:sureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertVC addAction:actionSure];
    }
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alertVC addAction:actionCancel];
    [viewController presentViewController:alertVC animated:YES completion:nil];
}
@end
