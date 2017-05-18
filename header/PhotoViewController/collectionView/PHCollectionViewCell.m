//
//  PHCollectionViewCell.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHCollectionViewCell.h"
#import "PHData.h"
@implementation PHCollectionViewCell
{
    UIImageView         *_imageView;
    UIImageView         *_selectedImageView;
    UIView              *_shadowView;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 主图
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        // 选择区域 灰色背景
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 23, 3 ,20, 20)];
        _shadowView.alpha = 0.6;
        _shadowView.layer.cornerRadius = 20 / 2.0;
        _shadowView.clipsToBounds = YES;
        _shadowView.backgroundColor = [UIColor grayColor];
        [self addSubview:_shadowView];
        
        // 选择区域图标
        _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 23, 3 ,20, 20)];
        _selectedImageView.clipsToBounds = YES;
        _selectedImageView.layer.cornerRadius = 20 / 2.0;
        _selectedImageView.clipsToBounds = YES;
        _selectedImageView.image = [UIImage imageNamed:@"ic_unselected"];
        _selectedImageView.userInteractionEnabled = YES;
        [self addSubview:_selectedImageView];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_selectedImageView addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark -
#pragma mark - PRIVATE

- (void)showCellWithKJAsset:(KJAsset *)asset count:(NSInteger)count {
    [PHData imageHighQualityFormatFromPHAsset:asset.asset complete:^(UIImage *image) {
        _imageView.image = image;
    }];
    if (asset.selected == YES) {
        _selectedImageView.image = [UIImage imageNamed:@"ic_selected"];
    }else {
        _selectedImageView.image = [UIImage imageNamed:@"ic_unselected"];
    }
}
- (void)imageViewAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        _selectedImageView.bounds = CGRectMake(0, 0, 23, 23);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _selectedImageView.bounds = CGRectMake(0, 0, 20, 20);
        }];
    }];
}
#pragma mark -
#pragma mark - INTERFACE

- (void)tap:(UIGestureRecognizer *)tap {
    if (_block) {
        _block ();
    }
}
@end
