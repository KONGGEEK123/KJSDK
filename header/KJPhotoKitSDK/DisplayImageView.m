//
//  DisplayImageView.m
//  ImageDisplayManager
//
//  Created by 王振 DemoKing on 2016/11/3.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "DisplayImageView.h"
@interface DisplayImageView()<UIScrollViewDelegate>

@end
@implementation DisplayImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 5;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.delegate = self;
        [self addSubview:self.imageView];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

#pragma mark -
#pragma mark - <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark -
#pragma mark - INTERFACE

- (void)longPress:(UIGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (_longPressBlock) {
            _longPressBlock(longPress.view.tag);
        }
    }
}

#pragma mark -
#pragma mark - PRIVATE METHOD SET

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    // [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}
@end
