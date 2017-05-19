//
//  UIViewController+Nav.h
//  wowobao_s
//
//  Created by 王振 DemoKing on 2016/10/17.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nav)
#pragma mark -
#pragma mark - 导航基础设置

/// 设置导航的背景颜色
- (void)setBarTintColor:(UIColor *)color;
/// 隐藏导航下得分割线
- (void)setNavigationLineHidden;
- (void)setNavigationLineColor:(UIColor *)color;
/// BarButtonItem itemTitle:标题 position：left or right
- (void)barButtonItemTitle:(NSString *)itemTitle position:(NSString *)position;
- (void)barButtonItemTitle:(NSString *)itemTitle position:(NSString *)position color:(UIColor *)color;
/// BarButtonItem点击事件 button.tag == 1:left button.tag == 2:right
- (void)buttonClickBar:(id)button;
/// 导航图片类型按钮
- (void)barImageTap:(UITapGestureRecognizer *)tap;
/// BarButtonItem imageName:图片名称 position：left or right
- (void)barButtonItemImageName:(NSString *)imageName position:(NSString *)position;
//// BarButtonItem imageName:图片名称
- (UIBarButtonItem *)barButtonItemsTitle:(NSString *)title imgName:(NSString *)imgName tag:(NSInteger)tag;
/// 导航标题的颜色 大小
- (void)titleColor:(NSString *)titleColor font:(CGFloat)font;
/// 导航view
- (void)titleViewWithImageName:(NSString *)imageName bounds:(CGRect)rect;
- (void)titleViewTap;
/// 改变导航透明度
- (void)changeNavAlpha:(float)alphaValue color:(UIColor *)color;
/// 全透明
- (void)OrangeTsunami;
@end
