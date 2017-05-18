//
//  PHGroupTableViewCell.h
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJAssetCollection.h"

@interface PHGroupTableViewCell : UITableViewCell

/**
 展示Cell

 @param assetCollection KJAssetCollection
 */
- (void)showCellWithKJAssetCollection:(KJAssetCollection *)assetCollection;

@end
