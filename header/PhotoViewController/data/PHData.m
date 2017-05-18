//
//  PHData.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHData.h"
#import "PHHeader.h"

@implementation PHData

/**
 获取所有图片分组
 
 @param callback 回调
 */
+ (void)allImageGroup:(void (^) (NSMutableArray <KJAssetCollection *>* array))callback {

    NSMutableArray *arrayResult = [NSMutableArray arrayWithCapacity:0];
    
    // 系统相册 只遍历Main
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    PHFetchResult *userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        PHCollection *collection = smartAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            KJAssetCollection *collection = [[KJAssetCollection alloc] initWithPHAssetCollection:assetCollection];
            [arrayResult addObject:collection];
        }
    }
    for (int i = 0; i < userAlbums.count; i++) {
        PHCollection *collection = userAlbums[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            KJAssetCollection *collection = [[KJAssetCollection alloc] initWithPHAssetCollection:assetCollection];
            [arrayResult addObject:collection];
        }
    }
    callback(arrayResult);
}
+ (void)imageHighQualityFormatFromPHAsset:(PHAsset *)asset complete:(void (^) (UIImage *image))complete {
    if (asset.mediaType == PHAssetMediaTypeImage) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:TUMB_IMAGE_SIZE contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (complete) {
                complete (result);
            }
        }];
    }else {
        if (complete) {
            complete (nil);
        }
    }
}
/**
 获取集合内asset对象数组
 
 @param assetCollection assetCollection
 @return NSMutableArray
 */
+ (NSMutableArray *)assetsInCollection:(PHAssetCollection *)assetCollection {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    [assetsFetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj];
    }];
    return array;
}

/**
 根据Asset 获取图片
 
 @param asset asset
 @param complete 回调
 */
+ (void)imageMaxSizeWithPHAsset:(PHAsset *)asset complete:(void (^) (UIImage *image))complete {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (complete) {
            complete (result);
        }
    }];
}

@end
