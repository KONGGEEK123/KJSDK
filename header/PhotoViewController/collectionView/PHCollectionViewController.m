//
//  PHCollectionViewController.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHCollectionViewController.h"
#import "PHCollectionViewCell.h"
#import "PHHeader.h"
#import "PHTabbarView.h"
#import "PHScanningViewController.h"

@interface PHCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,PHTabbarViewDelegate>

@property (strong, nonatomic) NSMutableArray <KJAsset *>*array;
@property (strong, nonatomic) NSMutableArray <KJAsset *>*selectedArray;
@property (strong, nonatomic) PHTabbarView *tabView;

@end

@implementation PHCollectionViewController
{
    UICollectionView            *_collectionView;
    
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_collectionView reloadData];
    [self.selectedArray removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.array enumerateObjectsUsingBlock:^(KJAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.selected) {
                [self.selectedArray addObject:obj];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabView count:self.selectedArray.count];
        });
    });
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self preferredStatusBarStyle];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray arrayWithCapacity:0];
    self.selectedArray = [NSMutableArray arrayWithCapacity:0];
    [self navigation];
    [self collectionView];
    [self dataSource];
    [self tabBarView];
}

#pragma mark -
#pragma mark - DATA SOURCE

- (void)dataSource {
    NSMutableArray *array = [PHData assetsInCollection:self.assetCollection];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KJAsset *asset = [[KJAsset alloc] initWithPHAsset:obj];
        [self.array addObject:asset];
    }];
    [_collectionView reloadData];
}

#pragma mark -
#pragma mark - PRIVATE

- (void)navigation {
    self.navigationItem.title = self.titleString;
    [self barButtonItemImageName:@"ic_login_back" position:@"left"];
    [self barButtonItemTitle:@"  取消"];
}

- (void)barImageTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scanningViewControllerWithArray:(NSMutableArray *)array index:(NSInteger)index {
    PHScanningViewController *vc = [[PHScanningViewController alloc] init];
    vc.array = array;
    vc.index = index;
    // 此处是计算下个页面还可以添加的数量
    vc.count = self.count - self.selectedArray.count;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - VIEWS

- (void)collectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH_PH - 25) / 4.0, (SCREEN_WIDTH_PH - 25) / 4.0);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_PH, SCREEN_HEIGHT_PH - 64 - 49) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [_collectionView registerClass:[PHCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

- (void)tabBarView {
    self.tabView = [[PHTabbarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_PH - 49 - 64, SCREEN_WIDTH_PH, 49)];
    self.tabView.delegate = self;
    [self.view addSubview:self.tabView];
}

#pragma mark -
#pragma mark - <<UICollectionViewDelegate,UICollectionViewDataSource>>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KJAsset *asset = self.array [indexPath.row];
    
    PHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __block PHCollectionViewCell *cellWeak = cell;
    cellWeak.block = ^{
        if (asset.selected == YES) {
            asset.selected = NO;
            [self.selectedArray removeObject:asset];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }else {
            if (self.selectedArray.count >= self.count) {
                [[HUDManager sharedManager] hud:MAX_ALERT_STRING];
                return ;
            }
            asset.selected = YES;
            [self.selectedArray addObject:asset];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [cell imageViewAnimation];
        }
        [self.tabView count:self.selectedArray.count];
    };
    [cell showCellWithKJAsset:asset count:self.count];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self scanningViewControllerWithArray:self.array index:indexPath.item];
}

#pragma mark -
#pragma mark - <PHTabbarViewDelegate>

- (void)tabbarView:(PHTabbarView *)tabbarView didSelectAtIndex:(NSInteger)index {
    if (index == 1) {
        // 预览
        [self.selectedArray removeAllObjects];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.array enumerateObjectsUsingBlock:^(KJAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.selected) {
                    [self.selectedArray addObject:obj];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.selectedArray.count) {
                    [self scanningViewControllerWithArray:self.selectedArray index:0];
                }else {
                    [[HUDManager sharedManager] hud:SELECTED_NONE];
                }
            });
        });
    }else if (index == 2) {
        // 完成
        if (self.block) {
            self.block (self.selectedArray);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
