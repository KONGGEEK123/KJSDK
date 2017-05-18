//
//  KJPhotoAssetsModel.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface KJPhotoAssetsModel : NSObject
@property (strong,nonatomic) ALAsset *asset;
@property (nonatomic, strong) NSString * uploadUrl;
@property (nonatomic, assign) NSInteger tag;
/**
 *  缩略图
 */
- (UIImage *)aspectRatioImage;
/**
 *  缩略图
 */
- (UIImage *)thumbImage;
/**
 *  原图
 */
- (UIImage *)originImage;
/**
 *  获取是否是视频类型, Default = false
 */
@property (assign,nonatomic) BOOL isVideoType;
/**
 *  获取图片的URL
 */
- (NSURL *)assetURL;

/**
 视图效果使用
 */
@property (assign, nonatomic) BOOL isSelected;
@end
