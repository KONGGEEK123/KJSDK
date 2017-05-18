//
//  KJAssetCollection.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/15.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface KJAssetCollection : NSObject
- (KJAssetCollection *)initWithPHAssetCollection:(PHAssetCollection *)assetCollection;
@property (strong, nonatomic) PHAssetCollection *assetCollection;
/**
 对象数量
 */
@property (assign, nonatomic) NSInteger count;

/**
 将最后一个对象获取
 */
@property (strong, nonatomic) PHAsset *lastAsset;

/**
 封面
 */
@property (strong, nonatomic) UIImage *coverImage;
@end
