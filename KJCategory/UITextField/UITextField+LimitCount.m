//
//  UITextField+LimitCount.m
//  Huiben_iOS
//
//  Created by BomBom on 16/8/26.
//  Copyright © 2016年 baozi. All rights reserved.
//

#import "UITextField+LimitCount.h"
#import <objc/runtime.h>
static char limit;
@implementation UITextField (LimitCount)
- (void)setLimitCount:(NSInteger)limitCount {
    objc_setAssociatedObject(self, &limit, [NSString stringWithFormat:@"%ld", (long)limitCount], OBJC_ASSOCIATION_ASSIGN);
    [self setTextLimit];
}

- (NSInteger)limitCount {
    return [objc_getAssociatedObject(self, &limit) integerValue];
}

- (void)setTextLimit {
    [self addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
}

- (void)changeText:(UITextField *)textField {
    NSString *toBeString = textField.text;
    NSString *lang = [textField textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        int chNum =0;
        for (int i=0; i<toBeString.length; ++i)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *subString = [toBeString substringWithRange:range];
            const char *cString = [subString UTF8String];
            if (cString == nil) {
                chNum ++;
            } else if (strlen(cString) == 3) {
//                NSLog(@"汉字:%@",subString);
                chNum ++;
            }
        }
        if (!position) {
            if (toBeString.length > self.limitCount) {
                textField.text = [toBeString substringToIndex:self.limitCount];
            }
        } else {
            
        }
    } else {
        if (toBeString.length > self.limitCount) {
            textField.text = [toBeString substringToIndex:self.limitCount];
        }
    }
}

- (void)placeholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
@end
