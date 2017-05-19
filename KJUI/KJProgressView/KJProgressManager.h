//
//  KJProgressManager.h
//  CCube_2.0
//
//  Created by 王振 DemoKing on 2017/4/23.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJProgressManager : NSObject
+ (KJProgressManager *)sharedManager;
/**
 显示进度 进度为100时 自定隐藏
 
 @param progress 进度
 */
- (void)progress:(CGFloat)progress;

/**
 隐藏
 */
- (void)hidden;
@end
