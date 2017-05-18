//
//  KJAssetCollection.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/15.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "KJAssetCollection.h"
#import "PHData.h"
@implementation KJAssetCollection
- (KJAssetCollection *)initWithPHAssetCollection:(PHAssetCollection *)assetCollection {
    self = [super init];
    if (self) {
        self.assetCollection = assetCollection;
        // 获取分组内对象数量
        // 创建过滤器
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
        self.count = assetsFetchResult.count;
        PHAsset *asset = [assetsFetchResult lastObject];
        self.lastAsset = asset;
        
        [PHData imageHighQualityFormatFromPHAsset:asset complete:^(UIImage *image) {
            if (image) {
                self.coverImage = image;
            }else {
                self.coverImage = [UIImage imageNamed:@"ic_PH_default"];
            }
        }];
    }
    return self;
}

@end
