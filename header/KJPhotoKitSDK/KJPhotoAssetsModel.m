//
//  KJPhotoAssetsModel.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoAssetsModel.h"

@implementation KJPhotoAssetsModel
- (UIImage *)aspectRatioImage{
    return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
}

- (UIImage *)thumbImage{
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}

- (UIImage *)originImage{
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}

- (BOOL)isVideoType{
    NSString *type = [self.asset valueForProperty:ALAssetPropertyType];
    // 媒体类型是视频
    return [type isEqualToString:ALAssetTypeVideo];
}

- (NSURL *)assetURL{
    return [[self.asset defaultRepresentation] url];
}
@end
