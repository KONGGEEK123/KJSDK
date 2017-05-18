//
//  UIViewController+Nav.m
//  wowobao_s
//
//  Created by 王振 DemoKing on 2016/10/17.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "UIViewController+Nav.h"
#define BAR_BUTTON_ITEM_FONT 14
#define BAR_BUTTON_ITEM_TITLECOLOR @"ffffff"
@implementation UIViewController (Nav)

/// 设置导航的背景颜色
- (void)setBarTintColor:(UIColor *)color {
    self.navigationController.navigationBar.barTintColor = color;
}
/// 隐藏导航下得分割线
- (void)setNavigationLineHidden {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
- (void)setNavigationLineColor:(UIColor *)color {
    self.navigationController.navigationBar.shadowImage = [self imageWithFrame:RECT(0, 0, SCREEN_WIDTH, 0.3) alpha:1 color:color];
}
/// LeftBarButtonItem itemTitle:标题 position：left or right
- (void)barButtonItemTitle:(NSString *)itemTitle position:(NSString *)position {
    [self barButtonItemTitle:itemTitle position:position color:[UIColor colorWithHexString:BAR_BUTTON_ITEM_TITLECOLOR]];
}
- (void)barButtonItemTitle:(NSString *)itemTitle position:(NSString *)position color:(UIColor *)color {
    UIButton *button = [[UIButton alloc] init];
    CGFloat width = [itemTitle widthWithFont:BAR_BUTTON_ITEM_FONT];
    button.frame = RECT(0, 0, width, 40);
    button.titleLabel.font = FONT(BAR_BUTTON_ITEM_FONT);
    [button setTitle:itemTitle forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickBar:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([position isEqualToString:@"left"]) {
        self.navigationItem.leftBarButtonItem = item;
        button.tag = 1;
    }else if ([position isEqualToString:@"right"]) {
        self.navigationItem.rightBarButtonItem = item;
        button.tag = 2;
    }
}
- (void)buttonClickBar:(id)button {
    
}
- (void)barImageTap:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/// BarButtonItem imageName:图片名称 position：left or right
- (void)barButtonItemImageName:(NSString *)imageName position:(NSString *)position {
    UIImageView *button = [[UIImageView alloc] init];
    button.frame = RECT(0, 0, 40, 40);
    button.image = IMAGE(imageName);
    if ([position isEqualToString:@"left"]) {
        button.contentMode = UIViewContentModeLeft;
    }else if ([position isEqualToString:@"right"]) {
        button.contentMode = UIViewContentModeRight;
    }
    button.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(barImageTap:)];
    [button addGestureRecognizer:tap];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([position isEqualToString:@"left"]) {
        self.navigationItem.leftBarButtonItem = item;
        button.tag = 1;
    }else if ([position isEqualToString:@"right"]) {
        self.navigationItem.rightBarButtonItem = item;
        button.tag = 2;
    }
}
//// BarButtonItem imageName:图片名称
- (UIBarButtonItem *)barButtonItemsTitle:(NSString *)title imgName:(NSString *)imgName tag:(NSInteger)tag {
    UIButton *button = [[UIButton alloc] init];
    if (title) {
        CGFloat width = [title widthWithFont:15];
        button.frame = RECT(0, 0, width, 40);
    }else {
        button.frame = RECT(0, 0, 20, 15);
    }
    button.tag = tag;
    button.titleLabel.font = FONT(15);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [button setImage:IMAGE(imgName) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickBar:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
/// 导航标题的颜色 大小
- (void)titleColor:(NSString *)titleColor font:(CGFloat)font {
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:titleColor],NSFontAttributeName:FONT(font)};
}
/// 导航view
- (void)titleViewWithImageName:(NSString *)imageName bounds:(CGRect)rect {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = rect;
    imageView.image = IMAGE(imageName);
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewTap)];
    [imageView addGestureRecognizer:tap];

    self.navigationItem.titleView = imageView;
}
- (void)titleViewTap {
    
}
/// 改变导航透明度
- (void)changeNavAlpha:(float)alphaValue color:(UIColor *)color {
    if (alphaValue < 0.99) {
        UINavigationBar * bar = self.navigationController.navigationBar;
        UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alpha:alphaValue color:color];
        [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
    }else {
        UINavigationBar * bar = self.navigationController.navigationBar;
        UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alpha:alphaValue color:color];
        [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
    }
}
- (UIImage *)imageWithFrame:(CGRect)frame alpha:(CGFloat)alpha color:(UIColor *)color {
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/// 全透明
- (void)OrangeTsunami {
    UIImage *image = [UIImage imageNamed:@"nav_clear"];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}
@end
