//
//  DisplayImageView.h
//  ImageDisplayManager
//
//  Created by 王振 DemoKing on 2016/11/3.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DisplayImageViewLongPressBlock)(NSInteger index);
@interface DisplayImageView : UIScrollView
@property (assign, nonatomic) DisplayImageViewLongPressBlock longPressBlock;
@property (strong, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *imageURL;
@property (copy, nonatomic) NSString *imageName;
@end
