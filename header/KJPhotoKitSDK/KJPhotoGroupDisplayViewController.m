//
//  KJPhotoGroupDisplayViewController.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoGroupDisplayViewController.h"
#import "KJPhotoCollectionViewCell.h"
#import "ImageDisplayViewController.h"

@interface KJPhotoGroupDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ImageDisplayViewControllerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray <KJPhotoAssetsModel *>*dataSource;
@end

@implementation KJPhotoGroupDisplayViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self base];
    [self addCollectionView];
    [self bottomView];
    [self assetsData];
}

#pragma mark -
#pragma mark - DATA SOURCE

- (void)assetsData {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [KJPhotoDataTool assetsArrayWithKJPhotoGroupModel:self.model finished:^(NSArray<ALAsset *> *array) {
            [array enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
                __block KJPhotoAssetsModel *model = [[KJPhotoAssetsModel alloc] init];
                model.asset = asset;
                [weakSelf.dataSource addObject:model];
                [[self.delegate arrayOfSelected] enumerateObjectsUsingBlock:^(KJPhotoAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([[NSString stringWithFormat:@"%@",[obj assetURL]] isEqualToString:[NSString stringWithFormat:@"%@",[model assetURL]]]) {
                        model.isSelected = YES;
                        *stop = YES;
                    }
                }];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    });
}

#pragma mark -
#pragma mark - PRIVATE METHOD 导航设置

- (void)base {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navButton:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark -
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    KJPhotoAssetsModel *model = self.dataSource [indexPath.row];
    cell.imageView.image = [model thumbImage];
    if (model.isSelected) {
        cell.shadowView.hidden = NO;
    }else {
        cell.shadowView.hidden = YES;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KJPhotoAssetsModel *model = self.dataSource [indexPath.row];
    KJPhotoCollectionViewCell *cell = (KJPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.isSingleSelected) {
        if ([self.delegate respondsToSelector:@selector(groupDisplayViewController:didSelectedImageAsset:)]) {
            [self.delegate groupDisplayViewController:self didSelectedImageAsset:model];
        }
        return;
    }
    if (model.isSelected) {
        model.isSelected = NO;
    }else {
        if (self.delegate) {
            if ([self.delegate arrayOfSelected].count >= [self.delegate multipleCount]) {
                [KJPhotoKitUtil showAlertViewWithTitle:@"提示" message:@"已经是最大数量" cancelButtonTitle:@"知道了" sureButtonTitle:nil inViewController:self cancelBlock:nil sureBlock:nil];
                return;
            }
        }else {
            return;
        }
        model.isSelected = YES;
    }
    if (model.isSelected) {
        cell.shadowView.hidden = NO;
        if ([self.delegate respondsToSelector:@selector(groupDisplayViewController:didSelectedImageAsset:)]) {
            [self.delegate groupDisplayViewController:self didSelectedImageAsset:model];
        }
    }else {
        cell.shadowView.hidden = YES;
        if ([self.delegate respondsToSelector:@selector(groupDisplayViewController:deSelectedImageAsset:)]) {
            [self.delegate groupDisplayViewController:self deSelectedImageAsset:model];
        }
    }
}


#pragma mark -
#pragma mark - INTERFACE

- (void)navButton:(UIButton *)button {
    if (button.tag == 1) {
        // 确定
        if ([self.delegate arrayOfSelected].count == 0) {
            [KJPhotoKitUtil showAlertViewWithTitle:@"提示" message:@"当前没有选择任何图片" cancelButtonTitle:@"知道了" sureButtonTitle:nil inViewController:self cancelBlock:nil sureBlock:nil];
            return;
        }
        [self.delegate groupDisplayViewControllerSure];
    }else if (button.tag == 2) {
        // 预览
        if ([self.delegate arrayOfSelected].count == 0) {
            [KJPhotoKitUtil showAlertViewWithTitle:@"提示" message:@"当前没有选择任何图片" cancelButtonTitle:@"知道了" sureButtonTitle:nil inViewController:self cancelBlock:nil sureBlock:nil];
            return;
        }
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        [[self.delegate arrayOfSelected] enumerateObjectsUsingBlock:^(KJPhotoAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[obj originImage]];
        }];
        ImageDisplayViewController *vc = [[ImageDisplayViewController alloc] init];
        vc.delegate = self;
        vc.array = array;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 3) {
        // 取消所有
        [self.dataSource enumerateObjectsUsingBlock:^(KJPhotoAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = NO;
        }];
        [self.collectionView reloadData];
        [self.delegate cancelAllSelected];
    }
}

#pragma mark -
#pragma mark - PRIVATE METHOD 添加视图

- (void)addCollectionView {
    NSInteger cellW = (self.view.frame.size.width - 2 * 4 + 1) / 4.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(cellW, cellW);
    layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH_KJPHOTOKIT, SCREEN_HEIGHT_KJPHOTOKIT - 64) collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView registerClass:[KJPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}
- (void)bottomView {
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT_KJPHOTOKIT - 49, SCREEN_WIDTH_KJPHOTOKIT, 49)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0.5;
    [self.view addSubview:shadowView];
    
    UIButton *buttonDisplay = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonDisplay.frame = CGRectMake(SCREEN_WIDTH_KJPHOTOKIT - 15 - 50, SCREEN_HEIGHT_KJPHOTOKIT - 49, 40, 49);
    [buttonDisplay setTitle:@"预览" forState:UIControlStateNormal];
    buttonDisplay.titleLabel.font = [UIFont systemFontOfSize:17];
    [buttonDisplay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonDisplay addTarget:self action:@selector(navButton:) forControlEvents:UIControlEventTouchUpInside];
    buttonDisplay.tag = 2;
    [self.view addSubview:buttonDisplay];
    
    UIButton *buttonCancelAll = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancelAll.frame = CGRectMake(15, SCREEN_HEIGHT_KJPHOTOKIT - 49, 70, 49);
    [buttonCancelAll setTitle:@"取消所有" forState:UIControlStateNormal];
    buttonCancelAll.titleLabel.font = [UIFont systemFontOfSize:17];
    [buttonCancelAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonCancelAll addTarget:self action:@selector(navButton:) forControlEvents:UIControlEventTouchUpInside];
    buttonCancelAll.tag = 3;
    [self.view addSubview:buttonCancelAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
