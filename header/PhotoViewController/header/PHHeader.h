//
//  PHHeader.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#ifndef PHHeader_h
#define PHHeader_h

#define SCREEN_WIDTH_PH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_PH [UIScreen mainScreen].bounds.size.height

#define MAX_ALERT_STRING @"超出最大数量"
#define SELECTED_NONE    @"尚未选择任何图片"

#define TUMB_IMAGE_SIZE  CGSizeMake(150, 150)

#import "PHData.h"
#import "KJAssetCollection.h"
#import "UIColor+PHCate.h"
#import "UIViewController+PHCate.h"
#import "KJAsset.h"
#import "HUDManager.h"
#import "PHTool.h"
#endif /* PHHeader_h */
