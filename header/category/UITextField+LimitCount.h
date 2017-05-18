//
//  UITextField+LimitCount.h
//  Huiben_iOS
//
//  Created by BomBom on 16/8/26.
//  Copyright © 2016年 baozi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (LimitCount)<UIApplicationDelegate>
@property (nonatomic, assign) NSInteger limitCount;
- (void)placeholderColor:(UIColor *)color;
@end
