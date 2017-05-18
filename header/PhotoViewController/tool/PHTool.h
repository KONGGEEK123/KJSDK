//
//  PHTool.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHTool : NSObject

/**
 弹出自定义相册 默认到所有照片中 (无视频)

 @param count 选择数量
 */
+ (void)showImagesWithCount:(NSInteger)count complete:(void(^)(id result))complete;
@end
