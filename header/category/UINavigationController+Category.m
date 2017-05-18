//
//  UINavigationController+Category.m
//  KJProject
//
//  Created by 王振 DemoKing on 2017/2/28.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "UINavigationController+Category.h"

@implementation UINavigationController (Category)

+ (UINavigationController *)navWithViewController:(UIViewController *)viewController {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    return nav;
}

@end
