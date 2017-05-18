//
//  KJPhotoGroupDisplayViewController.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJPhotoKitUtil.h"
#import "KJPhotoDataTool.h"
#import "KJPhotoAssetsModel.h"

@protocol GroupDisplayViewControllerDelegate <NSObject>

@required

/**
 选择图片时回调

 @param viewController viewController
 @param model model
 */
- (void)groupDisplayViewController:(UIViewController *)viewController
             didSelectedImageAsset:(KJPhotoAssetsModel *)model;

/**
 取消选择图片时回调

 @param viewController viewController
 @param model model
 */
- (void)groupDisplayViewController:(UIViewController *)viewController
              deSelectedImageAsset:(KJPhotoAssetsModel *)model;
/**
 获取所选择的图片对象
 
 @return 选择的对象数组
 */
- (NSMutableArray <KJPhotoAssetsModel *>*)arrayOfSelected;

/**
 取消所有的选择的对象
 */
- (void)cancelAllSelected;

/**
 确定
 */
- (void)groupDisplayViewControllerSure;

/**
 多选数量

 @return 多选数量
 */
- (NSInteger)multipleCount;
@end

@interface KJPhotoGroupDisplayViewController : UIViewController
/**
 获取组对象
 */
@property (strong, nonatomic) KJPhotoGroupModel *model;
@property (assign, nonatomic) id <GroupDisplayViewControllerDelegate> delegate;

/**
 是否单选
 */
@property (assign, nonatomic) BOOL isSingleSelected;
@end
