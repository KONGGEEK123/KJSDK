//
//  FunctionHeader.h
//  iOS SDK
//
//  Created by 王振 on 16/1/6.
//  Copyright © 2016年 杭州空极科技有限公司. All rights reserved.
//

#ifndef FunctionHeader_h
#define FunctionHeader_h

// ****************** 功能类宏定义 ******************

/**
 获取屏幕宽度
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/**
 获取屏幕高度
 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/**
 屏幕高度比例
 */
#define WIDTH_MULTIPLE [UIScreen mainScreen].bounds.size.width/375.0
/**
 屏幕宽度比例
 */
#define HEIGHT_MULTIPLE [UIScreen mainScreen].bounds.size.height/667.0

/**
 *  快速设置 font
 */
#define FONT(_SIZE_) [UIFont systemFontOfSize:_SIZE_]
/**
 *  快速配置 imageName
 */
#define IMAGE(_IMAGE_)  [UIImage imageNamed:_IMAGE_]
/**
 *  快速设置 point
 */
#define POINT(_X_,_Y_) CGPointMake(_X_, _Y_)
/**
 *  快速设置 rect
 */
#define RECT(_X_,_Y_,_W_,_H_) CGRectMake(_X_, _Y_, _W_, _H_)
/**
 *  快速设置 size
 */
#define SIZE(_W_,_H_) CGSizeMake(_W_, _H_)
/**
 *  快速设置 bounds
 */
#define BOUNDS(_X_,_Y_,_W_,_H_) CGRectMake(0, 0, _W_, _H_)
/**
 *  快速设置 range
 */
#define RANGE(_location_,_length_) NSMakeRange(_location_,_length_)
/**
 *  快速设置 弧度转角度
 */
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
/**
 *  快速设置 角度转弧度
 */
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
/**
 *  快速设置 MBProgressHUD 的错误提示 这里需要结合 请求 和 HUD 使用
 */
#define ERROR_MESSAGE [MBProgressHUDUtil hudWithText:responseMessage.errorMessage];
/**
 *  快速设置 MBProgressHUD 使用
 */
#define HUD(_message_) [MBProgressHUDUtil hudWithText:_message_];
/**
 *  等待蒙版显示
 */
#define PROGRESS_SHOW [MBProgressHUDUtil showProgress];
/**
 *  等待蒙版隐藏
 */
#define PROGRESS_HIDDEN [MBProgressHUDUtil hidden];

/**
 *  快速设置国际化使用
 */
#define Loc(_key_)  NSLocalizedString(_key_,nil)

/*
 * bref 快速到找根试图的方法
 */
#define ROOTVC (RootViewController *)[UIApplication sharedApplication].delegate.window.rootViewController
/*
 * 快速设置weakself
 */
#define WS(weakself)  __block __typeof(&*self)weakself = self;

/**
 获取主视图
 */
#define MainWindow [UIApplication sharedApplication].delegate.window

/**
 输出语句
 */
#ifndef DEBUG
#define NSLog(...)
#else
#define NSLog(...) NSLog(__VA_ARGS__)
#endif

/**
 自定义视图的frame宏
 */
#define VIEW_RECT_0_64 self.frame = RECT(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
#define VIEW_RECT_0_64_49 self.frame = RECT(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
#endif /* FunctionHeader_h */
