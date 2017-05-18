//
//  KJAsset.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "KJAsset.h"

@implementation KJAsset
/**
 初始化方法
 
 @param asset asset
 @return KJAsset
 */
- (KJAsset *)initWithPHAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}
@end
