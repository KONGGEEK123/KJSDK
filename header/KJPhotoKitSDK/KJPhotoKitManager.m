//
//  KJPhotoKitManager.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/18.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoKitManager.h"

typedef void(^KJPhotoKitManagerCameraSureBlock)(UIImage *image);
typedef void(^KJPhotoKitManagerSureBlock)(NSMutableArray <KJPhotoAssetsModel *>*array);
typedef void(^KJPhotoKitManagerCancelBlock)(void);

static KJPhotoKitManager *manager;

@interface KJPhotoKitManager ()<KJPhotoGroupListViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (assign, nonatomic) BOOL isSingleSelected;

/**
 照相机 单选
 */
@property (strong, nonatomic) UIImagePickerController *pickerViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (copy, nonatomic)  KJPhotoKitManagerCameraSureBlock cameraSureBlock;
@property (copy, nonatomic)  KJPhotoKitManagerSureBlock sureBlock;
@property (copy, nonatomic)  KJPhotoKitManagerCancelBlock cancelBlock;

@end

@implementation KJPhotoKitManager

+ (KJPhotoKitManager *)shareManager {
    if (!manager) {
        manager = [[KJPhotoKitManager alloc] init];
    }
    return manager;
}

/**
 调取系统相册
 
 @param viewController 调取的视图控制器
 @param selectType 调取类型
 @param count 如果是多选 则必传
 @param sure 确定回调
 @param cancel 取消回调
 */
+ (void)showKitInViewController:(UIViewController *)viewController selectedType:(KJPhotoKitManagerType)selectType count:(NSInteger)count sure:(void(^)(NSMutableArray <KJPhotoAssetsModel *>*array))sure cancel:(void(^)(void))cancel {
    [KJPhotoKitManager shareManager].sureBlock = sure;
    [KJPhotoKitManager shareManager].cancelBlock = cancel;
    KJPhotoGroupListViewController *vc = [[KJPhotoGroupListViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [KJPhotoKitManager shareManager].navigationController = nav;
    vc.delegate = [KJPhotoKitManager shareManager];
    vc.count = count;
    if (selectType == KJPhotoKitManagerTypeMutable) {
        vc.isSingleSelected = NO;
        [KJPhotoKitManager shareManager].isSingleSelected = NO;
    }else {
        vc.isSingleSelected = YES;
        [KJPhotoKitManager shareManager].isSingleSelected = YES;
    }
    [viewController presentViewController:nav animated:YES completion:nil];
}

/**
 调取照相机 单张
 
 @param viewController 试图控制器
 @param sure 确定
 @param cancel 取消
 */
+ (void)showCameraInViewController:(UIViewController *)viewController sure:(void(^)(UIImage *image))sure cancel:(void(^)(void))cancel {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    // 判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = [KJPhotoKitManager shareManager];
        // 设置拍照后的图片可被编辑
        picker.allowsEditing = NO;
        // 资源类型为照相机
        picker.sourceType = sourceType;
        [viewController presentViewController:picker animated:YES completion:nil];
        [KJPhotoKitManager shareManager].pickerViewController = picker;
    }else {
        NSLog(@"该设备无摄像头");
    }
    [KJPhotoKitManager shareManager].cameraSureBlock = sure;
    [KJPhotoKitManager shareManager].cancelBlock = cancel;
}

#pragma mark -
#pragma mark - PRIVATE METHOD <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([KJPhotoKitManager shareManager].cancelBlock) {
        [KJPhotoKitManager shareManager].cancelBlock ();
    }
    [[KJPhotoKitManager shareManager].pickerViewController dismissViewControllerAnimated:YES completion:^{
        [KJPhotoKitManager release];
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([KJPhotoKitManager shareManager].cameraSureBlock) {
        [KJPhotoKitManager shareManager].cameraSureBlock ([info objectForKey:UIImagePickerControllerOriginalImage]);
        [[KJPhotoKitManager shareManager].pickerViewController dismissViewControllerAnimated:YES completion:^{
            [KJPhotoKitManager release];
        }];
    }
}

#pragma mark -
#pragma mark - <KJPhotoGroupListViewControllerDelegate>

- (void)groupListViewController:(KJPhotoGroupListViewController *)viewContoller didSelectedImageWithArray:(NSMutableArray<KJPhotoAssetsModel *> *)array {
    if ([KJPhotoKitManager shareManager].sureBlock) {
        [KJPhotoKitManager shareManager].sureBlock (array);
    }
    [[KJPhotoKitManager shareManager].navigationController dismissViewControllerAnimated:YES completion:^{
        [KJPhotoKitManager release];
    }];
}
- (void)groupListViewControllerCancel {
    if ([KJPhotoKitManager shareManager].cancelBlock) {
        [KJPhotoKitManager shareManager].cancelBlock ();
    }
    [[KJPhotoKitManager shareManager].navigationController dismissViewControllerAnimated:YES completion:^{
        [KJPhotoKitManager release];
    }];
}

#pragma mark -
#pragma mark - PRIVATE METHOD 释放对象

+ (void)release {
    manager = nil;
    [KJPhotoKitManager shareManager].sureBlock = nil;
    [KJPhotoKitManager shareManager].cancelBlock = nil;
    [KJPhotoKitManager shareManager].navigationController = nil;
    [KJPhotoKitManager shareManager].cameraSureBlock = nil;
}
@end
