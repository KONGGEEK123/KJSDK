//
//  KJPhotoDataTool.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoDataTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface KJPhotoDataTool ()

@end

@implementation KJPhotoDataTool

#pragma mark -
#pragma mark - PRIVATE METHOD 获取单例

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,^ {
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

/**
 所有图片分组

 @param block 回调
 */
+ (void)allPhotosGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block {
    NSMutableArray *groups = [NSMutableArray arrayWithCapacity:0];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            KJPhotoGroupModel *pickerGroup = [[KJPhotoGroupModel alloc] init];
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            pickerGroup.group = group;
            pickerGroup.groupName = [group valueForProperty:ALAssetsGroupPropertyName];
            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            pickerGroup.assetsCount = [group numberOfAssets];
            if (pickerGroup.assetsCount != 0) {
                [groups addObject:pickerGroup];
            }
        }else{
            block(groups);
        }
    };
    NSInteger type = ALAssetsGroupAll;
    [[KJPhotoDataTool defaultAssetsLibrary] enumerateGroupsWithTypes:type usingBlock:resultBlock failureBlock:nil];
}

/**
 所有视频分组

 @param block 回调
 */
+ (void)allVedioGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block {
    NSMutableArray *groups = [NSMutableArray arrayWithCapacity:0];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            KJPhotoGroupModel *pickerGroup = [[KJPhotoGroupModel alloc] init];
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            pickerGroup.group = group;
            pickerGroup.groupName = [group valueForProperty:ALAssetsGroupPropertyName];
            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            pickerGroup.assetsCount = [group numberOfAssets];
            if (pickerGroup.assetsCount != 0) {
                [groups addObject:pickerGroup];
            }
        }else{
            block(groups);
        }
    };
    NSInteger type = ALAssetsGroupAll;
    [[KJPhotoDataTool defaultAssetsLibrary] enumerateGroupsWithTypes:type usingBlock:resultBlock failureBlock:nil];
}

/**
 所有分组

 @param block 回调
 */
+ (void)allGroup:(void(^)(NSMutableArray <KJPhotoGroupModel *>*))block {
    NSMutableArray *groups = [NSMutableArray arrayWithCapacity:0];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            KJPhotoGroupModel *pickerGroup = [[KJPhotoGroupModel alloc] init];
            pickerGroup.group = group;
            pickerGroup.groupName = [group valueForProperty:ALAssetsGroupPropertyName];
            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            pickerGroup.assetsCount = [group numberOfAssets];
            if (pickerGroup.assetsCount != 0) {
                [groups addObject:pickerGroup];
            }
        }else{
            block(groups);
        }
    };
    NSInteger type = ALAssetsGroupAll;
    [[KJPhotoDataTool defaultAssetsLibrary] enumerateGroupsWithTypes:type usingBlock:resultBlock failureBlock:nil];
}

/**
 获取组内信息

 @param model 组对象
 @param block 回调
 */
+ (void)assetsArrayWithKJPhotoGroupModel:(KJPhotoGroupModel *)model finished:(void(^)(NSArray <ALAsset *>* array))block {
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:0];
    ALAssetsGroupEnumerationResultsBlock result = ^(ALAsset *asset , NSUInteger index , BOOL *stop){
        if (asset) {
            [assets addObject:asset];
        }else{
            block(assets);
        }
    };
    [model.group enumerateAssetsUsingBlock:result];
}

/**
 获取asset对象

 @param url url
 @param block 回调
 */
+ (void)assetWithUrl:(NSURL *)url block:(void(^)(ALAsset *asset))block {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:url resultBlock:^(ALAsset *asset){
        if (block) {
            block (asset);
        }
    }failureBlock:^(NSError *error){
        if (block) {
            block (nil);
        }
    }];
}
@end
