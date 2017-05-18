//
//  PHScanningNavigationView.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHScanningNavigationView;

@protocol PHScanningNavigationViewDelegate <NSObject>

@optional

/**
 点击按钮的事件回调

 @param scanningNavigationView 当前视图
 @param index 1.返回
 */
- (void)scanningNavigationView:(PHScanningNavigationView *)scanningNavigationView clickAtIndex:(NSInteger)index;

@end

@interface PHScanningNavigationView : UIView

/**
 当前是否是被选中状态
 */
@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) id <PHScanningNavigationViewDelegate> delegate;

/**
 显示标题

 @param amount 总数
 @param index 当前index
 */
- (void)titleWithAmount:(NSInteger)amount index:(NSInteger)index;
/**
 对象是否被选择

 @param selected YES||NO
 */
- (void)selected:(BOOL)selected;
@end
