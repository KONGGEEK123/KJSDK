//
//  ImageDisplayViewController.h
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/18.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageDisplayViewControllerDelegate <NSObject>

@optional

- (void)longPressAtIndex:(NSInteger)index;

@end

@interface ImageDisplayViewController : UIViewController

@property (strong, nonatomic) NSArray <UIImage *>*array;
@property (assign, nonatomic) id <ImageDisplayViewControllerDelegate> delegate;

@end
