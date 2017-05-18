//
//  UIView+Category.m
//  iOS SDK
//
//  Created by 王振 on 16/1/6.
//  Copyright © 2016年 杭州空极科技有限公司. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark -
#pragma mark - 拓展方法 (私有)

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
- (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1];
}


#pragma mark -
#pragma mark - 关于位置

/**
 * 获取视图 x 坐标
 *
 *  @return x 坐标
 */
- (CGFloat)getX {
    return self.frame.origin.x;
}
/**
 * 获取视图 y 坐标
 *
 *  @return y 坐标
 */
- (CGFloat)getY {
    return self.frame.origin.y;
}
/**
 * 获取视图 宽度
 *
 *  @return 宽度
 */
- (CGFloat)getWidth {
    return self.frame.size.width;
}
/**
 * 获取视图 高度
 *
 *  @return 高度
 */
- (CGFloat)getHeight {
    return self.frame.size.height;
}
/**
 * 获取视图 最右边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxX {
    return CGRectGetMaxX(self.frame);
}
/**
 * 获取视图 最下边距屏幕左边的距离
 *
 *  @return 距离
 */
- (CGFloat)getMaxY {
    return CGRectGetMaxY(self.frame);
}
/**
 *  获取视图 中心点 X
 *
 *  @return center.x
 */
- (CGFloat)getMidX {
    return self.center.x;
}
/**
 *  获取视图 中心点 Y
 *
 *  @return center.y
 */
- (CGFloat)getMidY {
    return self.center.y;
}

#pragma mark -
#pragma mark - 关于设置圆角

/**
 *  切圆
 */
- (void)fillCorner {
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.clipsToBounds = YES;
}
/**
 *  切指定圆角
 *
 *  @param radius 圆角半径
 */
- (void)cornerWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}
/**
 *  设置边框
 *
 *  @param radius      半径
 *  @param borderWidth 边框宽度
 *  @param colorString 边框颜色 6位16进制字符串
 */
- (void)borderWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(NSString *)colorString {
    self.layer.borderColor = [self colorWithHexString:colorString].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
}
/**
 *  60 秒倒计时限制交互性
 */
- (void)userInteractionEnabledControl {
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}
- (void)hiddenControl {
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.hidden = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{

            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -
#pragma mark - 关于画线

/**
 *  画线
 *
 *  @param top   居上
 *  @param left  居左
 *  @param right 居右
 */
- (void)lineFromTop:(float)top left:(float)left toRight:(float)right {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [self colorWithHexString:@"e5e5e5"].CGColor;
    layer.frame = CGRectMake(left, top, [self getWidth] - left - right, 0.5);
    [self.layer addSublayer:layer];
}
/**
 *  上部横线
 */
- (void)topLine {
    [self lineFromTop:0 left:0 toRight:0];
}
/**
 *  下部横线
 */
- (void)bottomLine {
    [self lineFromTop:[self getHeight] - 0.5  left:0 toRight:0];
}
- (void)shadowColorString:(NSString *)colorString opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    self.layer.shadowColor = [self colorWithHexString:colorString].CGColor; /// 阴影颜色
    self.layer.shadowOpacity = opacity; /// 阴影透明度
    self.layer.shadowRadius = radius; /// 阴影半径 默认 3
    self.layer.shadowOffset = offset; /// 向右 向下 偏移
}
@end
