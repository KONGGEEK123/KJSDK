//
//  KJCommonUI.h
//  KJFrameworkProject
//
//  Created by 王振 DemoKing on 2016/11/15.
//  Copyright © 2016年 baozi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJCommonUI : NSObject

#pragma mark -
#pragma mark - 关于系统弹框

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
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               sureButtonTitle:(NSString *)sureButtonTitle
              inViewController:(id)viewController
                   cancelBlock:(void(^)(void))cancelBlock
                     sureBlock:(void(^)(void))sureBlock;

/**
 弹框 UIAlertViewController sheet

 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param titleArray 按钮标题数组
 @param viewController 视图控制器
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)showSheetViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
               titleArray:(NSArray <NSString *>*)titleArray
              inViewController:(id)viewController
                   cancelBlock:(void(^)(void))cancelBlock
                     sureBlock:(void(^)(UIAlertAction *action))sureBlock;
@end
