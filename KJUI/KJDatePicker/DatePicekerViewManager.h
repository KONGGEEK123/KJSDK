//
//  DatePicekerViewManager.h
//  ShenGangTong_Driver
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePicekerViewManagerDelegate <NSObject>

@optional

- (void)didSelectectedCacenl;
- (void)didSelectectedSure;

@end

@interface DatePicekerViewManager : UIView
@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) NSDate *date;
+ (DatePicekerViewManager *)sharedManager;
- (void)showPickerViewIsMore64;
- (void)showDatePicker;
- (void)hiddenDatePicker;
- (void)remove;
/// 默认选择当前时间
- (void)currentDate;
@end
