//
//  PHScanningCollectionViewCell.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/16.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHScanningCollectionViewCell.h"
#import "PHData.h"

@interface PHScanningCollectionViewCell ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation PHScanningCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.delegate = self;
        self.scrollView.maximumZoomScale = 1.5;
        self.scrollView.minimumZoomScale = 1;
        [self addSubview:self.scrollView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:self.imageView];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
        tap2.numberOfTapsRequired = 2;
        [self.scrollView addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
        [self.scrollView addGestureRecognizer:tap1];
    }
    return self;
}

#pragma mark -
#pragma mark - PRIVATE

/**
 展示图片
 
 @param asset KJAsset
 */
- (void)showWithKJAsset:(KJAsset *)asset {
    self.scrollView.zoomScale = 1;
    [PHData imageMaxSizeWithPHAsset:asset.asset complete:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

#pragma mark -
#pragma mark - <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        return self.imageView;
    }else {
        return nil;
    }
}

#pragma mark -
#pragma mark - INTERFACE

- (void)tap2:(UIGestureRecognizer *)tap2 {
    if (self.scrollView.zoomScale != 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    }else {
        [self.scrollView setZoomScale:1.5 animated:YES];
    }
}
- (void)tap1:(UIGestureRecognizer *)tap {
    if (self.block) {
        self.block ();
    }
}
@end
