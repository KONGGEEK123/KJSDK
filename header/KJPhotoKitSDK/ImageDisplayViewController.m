
//
//  ImageDisplayViewController.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/18.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "ImageDisplayViewController.h"
#import "KJPhotoKitUtil.h"
#import "DisplayImageView.h"
@interface ImageDisplayViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ImageDisplayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addScrollView];
}

- (void)addScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_KJPHOTOKIT, SCREEN_HEIGHT_KJPHOTOKIT)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH_KJPHOTOKIT * self.array.count, SCREEN_HEIGHT_KJPHOTOKIT);
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
    for (int i = 0; i < self.array.count; i ++) {
        DisplayImageView *displayImageView = [[DisplayImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH_KJPHOTOKIT * i, 0, SCREEN_WIDTH_KJPHOTOKIT, SCREEN_HEIGHT_KJPHOTOKIT)];
        displayImageView.imageView.image = self.array [i];
        displayImageView.tag = i;
        __block DisplayImageView *displayImageViewWeak = displayImageView;
        displayImageViewWeak.longPressBlock = ^(NSInteger index){
            if ([self.delegate respondsToSelector:@selector(longPressAtIndex:)]) {
                [self.delegate longPressAtIndex:index];
            }
        };
        [self.scrollView addSubview:displayImageView];
    }
}

- (void)tapGesture {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
