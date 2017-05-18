//
//  PHCollectionViewController.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
typedef void(^PHGroupViewControllerBlock)(id result);

@interface PHCollectionViewController : UIViewController
@property (copy, nonatomic) PHGroupViewControllerBlock block;
/**
 可以选取图片的数量
 */
@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSString *titleString;

/**
 集合对象
 */
@property (strong, nonatomic) PHAssetCollection *assetCollection;
@end
