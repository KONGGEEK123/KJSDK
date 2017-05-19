 //
//  UILabel+AutoSize.m
//  AutoSizeLabel
//
//  Created by 123 on 15/7/27.
//  Copyright (c) 2015年 Vision.Wang. All rights reserved.
//

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)
- (void)autoSize
{
    self.numberOfLines = 0;
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    //此处要使用ceil函数 大于或等于的最小整数
    //you must raise its value to the nearest higher integer using the ceil function.
    CGFloat height = ceil(CGRectGetHeight(rect));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)autoWidthSize {
    self.numberOfLines = 1;
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    CGFloat width = ceil(CGRectGetWidth(rect));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

@end
