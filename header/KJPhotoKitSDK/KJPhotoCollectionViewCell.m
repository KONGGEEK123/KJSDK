//
//  KJPhotoCollectionViewCell.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoCollectionViewCell.h"

@implementation KJPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView.backgroundColor = [UIColor grayColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        self.shadowView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.shadowView.userInteractionEnabled = NO;
        self.shadowView.hidden = YES;
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = 0.5;
        [self.shadowView setImage:[UIImage imageNamed:@"ic_selected"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shadowView];
    }
    return self;
}

@end
