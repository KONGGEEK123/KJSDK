//
//  KJPhotoGroupListViewController.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KJPhotoAssetsModel.h"
@class KJPhotoGroupListViewController;

@protocol KJPhotoGroupListViewControllerDelegate <NSObject>

@required
/**
 确定选择回调

 @param viewContoller 当前视图控制器
 @param array 数组
 */
- (void)groupListViewController:(KJPhotoGroupListViewController *)viewContoller
      didSelectedImageWithArray:(NSMutableArray <KJPhotoAssetsModel *>*)array;

/**
 取消选择
 */
- (void)groupListViewControllerCancel;

@end

@interface KJPhotoGroupListViewController : UIViewController

/**
 设置代理
 */
@property (assign, nonatomic) id <KJPhotoGroupListViewControllerDelegate> delegate;

/**
 当为多选时 最大数量 最大值为12
 */
@property (assign, nonatomic) NSInteger count;

/**
 是否单选
 */
@property (assign, nonatomic) BOOL isSingleSelected;
@end
