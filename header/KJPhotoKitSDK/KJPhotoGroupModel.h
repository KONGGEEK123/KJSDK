//
//  KJPhotoGroupModel.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface KJPhotoGroupModel : NSObject
/**
 *  组名
 */
@property (nonatomic, copy) NSString *groupName;

/**
 *  缩略图
 */
@property (nonatomic, strong) UIImage *thumbImage;

/**
 *  组里面的图片个数
 */
@property (nonatomic, assign) NSInteger assetsCount;

/**
 *  类型 : Saved Photos...
 */
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) ALAssetsGroup *group;
@property (assign,nonatomic) BOOL isVideo;
@end
