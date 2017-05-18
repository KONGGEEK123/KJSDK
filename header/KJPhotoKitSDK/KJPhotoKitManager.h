//
//  KJPhotoKitManager.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/18.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJPhotoGroupListViewController.h"
#import "KJPhotoDataTool.h"

typedef enum : NSUInteger {
    KJPhotoKitManagerTypeMutable,       // 多选
    KJPhotoKitManagerTypeSingle,        // 单选
} KJPhotoKitManagerType;

@interface KJPhotoKitManager : NSObject

/**
 调取系统相册
 
 @param viewController 调取的视图控制器
 @param selectType 调取类型
 @param count 如果是多选 则必传
 @param sure 确定回调
 @param cancel 取消回调
 */
+ (void)showKitInViewController:(UIViewController *)viewController selectedType:(KJPhotoKitManagerType)selectType count:(NSInteger)count sure:(void(^)(NSMutableArray <KJPhotoAssetsModel *>*array))sure cancel:(void(^)(void))cancel;

/**
 调取照相机 单张

 @param viewController 试图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showCameraInViewController:(UIViewController *)viewController sure:(void(^)(UIImage *image))sure cancel:(void(^)(void))cancel;
@end
