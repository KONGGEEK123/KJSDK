//
//  DatePicekerViewManager.m
//  ShenGangTong_Driver
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DatePicekerViewManager.h"
#define RATIO_HEIGHT 300
@interface DatePicekerViewManager ()

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation DatePicekerViewManager

+ (DatePicekerViewManager *)sharedManager {
    static DatePicekerViewManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[DatePicekerViewManager alloc] init];
        sharedManager.backgroundColor = [UIColor whiteColor];
        sharedManager.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, RATIO_HEIGHT);
        
        UIButton *cancel = [[UIButton alloc] init];
        cancel.frame = CGRectMake(0, 0, 50, 40);
        cancel.titleLabel.font = FONT(14);
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(buttonClickCancel) forControlEvents:UIControlEventTouchUpInside];
        [cancel setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [sharedManager addSubview:cancel];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:RECT((SCREEN_WIDTH - 80) / 2.0, 0, 80, 40)];
        titleLabel.text = nil;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [sharedManager addSubview:titleLabel];
        
        UIButton *sure = [[UIButton alloc] init];
        sure.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 40);
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(buttonClickSure) forControlEvents:UIControlEventTouchUpInside];
        [sure setTitleColor:[UIColor colorWithHexString:COLOR_COMMON] forState:UIControlStateNormal];
        sure.titleLabel.font = FONT(14);
        [sharedManager addSubview:sure];
        
        [sharedManager lineFromTop:39.5 left:0 toRight:0];
        [sharedManager addSubview:sharedManager.datePicker];
        
        [sharedManager topLine];
    });
    return sharedManager;
}
+ (void)buttonClickCancel {
    if ([[DatePicekerViewManager sharedManager].delegate respondsToSelector:@selector(didSelectectedCacenl)]) {
        [[DatePicekerViewManager sharedManager].delegate didSelectectedCacenl];
    }
}
+ (void)buttonClickSure {
    if ([[DatePicekerViewManager sharedManager].delegate respondsToSelector:@selector(didSelectectedSure)]) {
        [[DatePicekerViewManager sharedManager].delegate didSelectectedSure];
    }
}
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = CGRectMake(0, 40, SCREEN_WIDTH, RATIO_HEIGHT - 40);
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    NSLocale *chLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = chLocale;
    return _datePicker;
}
- (void)showDatePicker {
    _datePicker.minimumDate = [NSDate date];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = [DatePicekerViewManager sharedManager].frame;
        rect.origin.y = SCREEN_HEIGHT - RATIO_HEIGHT;
        [DatePicekerViewManager sharedManager].frame = rect;
    }completion:^(BOOL finished) {
        
    }];
}
- (void)showPickerViewIsMore64 {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = [DatePicekerViewManager sharedManager].frame;
        rect.origin.y = SCREEN_HEIGHT - RATIO_HEIGHT - 64;
        [DatePicekerViewManager sharedManager].frame = rect;
    }completion:^(BOOL finished) {
        
    }];
}
- (void)remove {
    [[DatePicekerViewManager sharedManager] removeFromSuperview];
}
- (void)hiddenDatePicker {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = [DatePicekerViewManager sharedManager].frame;
        rect.origin.y = SCREEN_HEIGHT;
        [DatePicekerViewManager sharedManager].frame = rect;
    } completion:^(BOOL finished) {
        [[DatePicekerViewManager sharedManager] removeFromSuperview];
    }];
}
/// 默认选择当前时间
- (void)currentDate {
    [DatePicekerViewManager sharedManager].datePicker.date = [NSDate date];
}
/// 获取当前控制器的日期
- (NSDate *)date {
    return [DatePicekerViewManager sharedManager].datePicker.date;
}
@end
