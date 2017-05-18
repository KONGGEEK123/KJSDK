//
//  KJAsset.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface KJAsset : NSObject

/**
 初始化方法

 @param asset asset
 @return KJAsset
 */
- (KJAsset *)initWithPHAsset:(PHAsset *)asset;
/**
 Asset对象
 */
@property (strong, nonatomic) PHAsset *asset;

/**
 是否被选中
 */
@property (assign, nonatomic) BOOL selected;
@end
