//
//  PHData.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "KJAssetCollection.h"

@interface PHData : NSObject

/**
 获取所有图片分组

 @param callback 回调
 */
+ (void)allImageGroup:(void (^) (NSMutableArray <KJAssetCollection *>*array))callback;

/**
 根据Asset 获取图片 size:200 * 200

 @param asset asset
 @param complete 回调
 */
+ (void)imageHighQualityFormatFromPHAsset:(PHAsset *)asset complete:(void (^) (UIImage *image))complete;

/**
 获取集合内asset对象数组
 
 @param assetCollection assetCollection
 @return NSMutableArray
 */
+ (NSMutableArray *)assetsInCollection:(PHAssetCollection *)assetCollection;

/**
 根据Asset 获取图片 size:max
 
 @param asset asset
 @param complete 回调
 */
+ (void)imageMaxSizeWithPHAsset:(PHAsset *)asset complete:(void (^) (UIImage *image))complete;
@end
