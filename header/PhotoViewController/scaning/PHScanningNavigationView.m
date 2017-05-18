//
//  PHScanningNavigationView.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHScanningNavigationView.h"
#import "PHHeader.h"

@interface PHScanningNavigationView ()

{
    UIView          *_shadowView;
    UIButton        *_buttonSelect;
    UILabel         *_titleLabel;
}

@end

@implementation PHScanningNavigationView

- (id)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH_PH, 64);
    if (self) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.7;
        _shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH_PH, 64);
        [self addSubview:_shadowView];
        
        UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 55, 55)];
        [buttonBack setImage:[UIImage imageNamed:@"ic_login_back"] forState:UIControlStateNormal];
        [buttonBack addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        buttonBack.tag = 1;
        [self addSubview:buttonBack];
        
        _buttonSelect = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH_PH - 30, 30, 20, 20)];
        [_buttonSelect addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttonSelect.tag = 2;
        [self addSubview:_buttonSelect];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.bounds = CGRectMake(0, 0, 100, 64);
        _titleLabel.center = CGPointMake(SCREEN_WIDTH_PH / 2.0, 20 + 44 / 2.0);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark -
#pragma mark - PRIVATE

/**
 对象是否被选择
 
 @param selected YES||NO
 */
- (void)selected:(BOOL)selected {
    if (selected) {
        [_buttonSelect setImage:[UIImage imageNamed:@"ic_selected"] forState:UIControlStateNormal];
    }else {
        [_buttonSelect setImage:[UIImage imageNamed:@"ic_unselected"] forState:UIControlStateNormal];
    }
    self.selected = selected;
}
/**
 显示标题
 
 @param amount 总数
 @param index 当前index
 */
- (void)titleWithAmount:(NSInteger)amount index:(NSInteger)index {
    _titleLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)index, (long)amount];
}

#pragma mark -
#pragma mark - INTERFACE

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(scanningNavigationView:clickAtIndex:)]) {
        [self.delegate scanningNavigationView:self clickAtIndex:button.tag];
    }
}
@end
