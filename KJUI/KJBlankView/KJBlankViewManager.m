//
//  KJBlankViewManager.m
//  CCube_2.0
//
//  Created by 王振 DemoKing on 2017/4/26.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "KJBlankViewManager.h"
#import "FunctionHeader.h"
#import "UIView+Category.h"
#import "UIColor+Hex.h"


static UIView       *_contentView;
static UIImageView  *_imageView;
static UILabel      *_contentLabel;
@implementation KJBlankViewManager

+ (KJBlankViewManager *)sharedManager {
    static KJBlankViewManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[KJBlankViewManager alloc] init];
    });
    return sharedManager;
}

#pragma mark -
#pragma mark - PRIVATE

- (void)hidden {
    [_contentView removeFromSuperview];
    _contentView = nil;
    [_imageView removeFromSuperview];
    _imageView = nil;
    [_contentLabel removeFromSuperview];
    _contentLabel = nil;
}

- (UIView *)showInView:(UIView *)view frame:(CGRect)frame image:(UIImage *)image {
    [[KJBlankViewManager sharedManager] hidden];
    _contentView = [[UIView alloc] initWithFrame:frame];
    [view addSubview:_contentView];
    
    _imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, [_contentView getWidth], [_contentView getHeight])];
    _imageView.image = image;
    [_contentView addSubview:_imageView];
    [_contentView sendSubviewToBack:_imageView];
    return _contentView;
}

- (UIView *)showInView:(UIView *)view frame:(CGRect)frame image:(UIImage *)image title:(NSString *)title {
    [[KJBlankViewManager sharedManager] hidden];
    
    _contentView = [[UIView alloc] initWithFrame:frame];
    [view addSubview:_contentView];
    
    _imageView = [[UIImageView alloc] initWithFrame:RECT(0, 0, [_contentView getWidth], [_contentView getHeight])];
    _imageView.image = image;
    [_contentView addSubview:_imageView];
    [_contentView sendSubviewToBack:_imageView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:RECT(0, 130, SCREEN_WIDTH, 20)];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = FONT(14);
    _contentLabel.textColor = [UIColor colorWithHexString:@"A5A5A5"];
    _contentLabel.text = title;
    [_imageView addSubview:_contentLabel];
    
    return _contentView;
}
@end
