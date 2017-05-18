//
//  HUDManager.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDManager : NSObject
+ (HUDManager *)sharedManager;
- (void)hud:(NSString *)string;
@end
