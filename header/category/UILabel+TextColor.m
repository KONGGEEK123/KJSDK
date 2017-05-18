//
//  UILabel+TextColor.m
//  wowobao_c
//
//  Created by Apple on 2016/10/26.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "UILabel+TextColor.h"

@implementation UILabel (TextColor)

- (void)changeTextColor:(UIColor *)color starpoint:(NSUInteger)star endwidth:(NSUInteger)width {
    NSString *contentStr = self.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(star, width)];
    self.attributedText = str;
}
@end
