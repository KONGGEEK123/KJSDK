//
//  KJPhotoKitUtil.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SCREEN_WIDTH_KJPHOTOKIT [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_KJPHOTOKIT [UIScreen mainScreen].bounds.size.height

@interface KJPhotoKitUtil : NSObject
/**
 *  获取颜色 含有alpha
 *
 *  @param color 6位16进制字符串
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color
                          alpha:(CGFloat)alpha;
/**
 *  获取颜色
 *
 *  @param color 6位16进制字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 弹框 UIAlertViewController 取消 + 确定 alert
 
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
                     sureBlock:(void(^)(void))sureBlock;
@end
