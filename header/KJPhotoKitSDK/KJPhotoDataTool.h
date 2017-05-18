//
//  KJPhotoDataTool.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KJPhotoGroupModel.h"

@interface KJPhotoDataTool : NSObject

/**
 所有图片分组
 
 @param block 回调
 */
+ (void)allPhotosGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block;
/**
 所有视频分组
 
 @param block 回调
 */
+ (void)allVedioGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block;
/**
 所有分组
 
 @param block 回调
 */
+ (void)allGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block;
/**
 获取组内信息
 
 @param model 组对象
 @param block 回调
 */
+ (void)assetsArrayWithKJPhotoGroupModel:(KJPhotoGroupModel *)model finished:(void(^)(NSArray <ALAsset *>* array))block;

/**
 获取asset对象
 
 @param url url
 @param block 回调
 */
+ (void)assetWithUrl:(NSURL *)url block:(void(^)(ALAsset *asset))block;
@end
