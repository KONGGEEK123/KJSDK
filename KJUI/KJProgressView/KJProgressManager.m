//
//  KJProgressManager.m
//  CCube_2.0
//
//  Created by 王振 DemoKing on 2017/4/23.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "KJProgressManager.h"
#import "FunctionHeader.h"
#import "UIView+Category.h"
#import "UIColor+Hex.h"

static UIView       *_shadowView;
static UIView       *_contentView;
static UIView       *_progresBackgroundView;
static UIView       *_currentProgressView;
static UILabel      *_currentProgressLabel;
@implementation KJProgressManager

/**
 创建单例类

 @return 单例类对象
 */
+ (KJProgressManager *)sharedManager {
    static KJProgressManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[KJProgressManager alloc] init];
    });
    return sharedManager;
}

/**
 显示进度 进度为100时 自定隐藏

 @param progress 进度
 */
- (void)progress:(CGFloat)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!_shadowView) {
            _shadowView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _shadowView.backgroundColor = [UIColor blackColor];
            _shadowView.alpha = 0.4;
            [MainWindow addSubview:_shadowView];
        }
        if (!_contentView) {
            _contentView = [[UIView alloc] init];
            _contentView.backgroundColor = [UIColor whiteColor];
            _contentView.bounds = RECT(0, 0, 150, 120);
            _contentView.center = POINT(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
            [_contentView cornerWithRadius:5];
            [MainWindow addSubview:_contentView];
        }
        if (!_progresBackgroundView) {
            _progresBackgroundView = [[UIView alloc] init];
            _progresBackgroundView.bounds = RECT(0, 0, [_contentView getWidth] - 20, 10);
            _progresBackgroundView.center = POINT([_contentView getWidth] / 2.0, [_contentView getHeight] / 2.0);
            [_progresBackgroundView borderWithRadius:5 borderWidth:0.5 borderColor:@"999999"];
            [_contentView addSubview:_progresBackgroundView];
        }
        if (!_currentProgressView) {
            _currentProgressView = [[UIView alloc] init];
            _currentProgressView.frame = RECT(0, 0, 0, 10);
            [_currentProgressView cornerWithRadius:5];
            _currentProgressView.backgroundColor = [UIColor colorWithHexString:@"f59f00"];
            [_progresBackgroundView addSubview:_currentProgressView];
        }
        if (!_currentProgressLabel) {
            _currentProgressLabel = [[UILabel alloc] initWithFrame:RECT(0, [_contentView getHeight] / 2.0 + 10, [_contentView getWidth], [_contentView getHeight] - ([_contentView getHeight] / 2.0 + 10))];
            _currentProgressLabel.font = FONT(14);
            _currentProgressLabel.textAlignment = NSTextAlignmentCenter;
            _currentProgressLabel.textColor = [UIColor colorWithHexString:@"666666"];
            _currentProgressLabel.text = @"当前进度:0.0%";
            [_contentView addSubview:_currentProgressLabel];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = _currentProgressView.frame;
            rect.size.width = [_progresBackgroundView getWidth] * progress;
            _currentProgressView.frame = rect;
        }];
        _currentProgressLabel.text = [NSString stringWithFormat:@"当前进度:%.1f%@",progress * 100,@"%"];
    });
}

/**
 隐藏
 */
- (void)hidden {
    [_shadowView removeFromSuperview];
    [_contentView removeFromSuperview];
    _shadowView = nil;
    _contentView = nil;
    _progresBackgroundView = nil;
    _currentProgressView = nil;
    _currentProgressLabel = nil;
}

@end
