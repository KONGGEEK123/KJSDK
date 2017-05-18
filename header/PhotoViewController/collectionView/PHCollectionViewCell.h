//
//  PHCollectionViewCell.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJAsset.h"

typedef void (^PHCollectionViewCellTapBlock)(void);
@interface PHCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) PHCollectionViewCellTapBlock block;

/**
 展示图片

 @param asset KJAsset
 @param count 数量
 */
- (void)showCellWithKJAsset:(KJAsset *)asset count:(NSInteger)count;

/**
 被选中时 图片动画显示
 */
- (void)imageViewAnimation;
@end
