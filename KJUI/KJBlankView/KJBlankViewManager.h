//
//  KJBlankViewManager.h
//  CCube_2.0
//
//  Created by 王振 DemoKing on 2017/4/26.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KJBlankViewManager : NSObject

+ (KJBlankViewManager *)sharedManager;
- (UIView *)showInView:(UIView *)view frame:(CGRect)frame image:(UIImage *)image;
- (void)hidden;
- (UIView *)showInView:(UIView *)view frame:(CGRect)frame image:(UIImage *)image title:(NSString *)title;
@end
