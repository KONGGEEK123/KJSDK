//
//  PHTool.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHTool.h"
#import "PHGroupViewController.h"

@implementation PHTool

/**
 弹出自定义相册 默认到所有照片中 (无视频)
 
 @param count 选择数量
 */
+ (void)showImagesWithCount:(NSInteger)count complete:(void(^)(id result))complete {
    PHGroupViewController *vc = [[PHGroupViewController alloc] init];
    __block PHGroupViewController *vcWeak = vc;
    vc.count = count;
    vcWeak.block = ^(id asset) {
        if (complete) {
            complete (asset);
        }
        [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
