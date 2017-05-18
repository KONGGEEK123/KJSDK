//
//  UITextView+LimitCount.m
//  CCube_2.0
//
//  Created by 王振 DemoKing on 2017/3/21.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "UITextView+LimitCount.h"

@implementation UITextView (LimitCount)

- (BOOL)position {
    NSString *lang = [self textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (position) {
            return YES;
        }
    }
    return NO;
}
@end
