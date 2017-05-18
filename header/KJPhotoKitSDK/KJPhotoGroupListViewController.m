//
//  KJPhotoGroupListViewController.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/16.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "KJPhotoGroupListViewController.h"
#import "KJPhotoKitUtil.h"
#import "KJPhotoDataTool.h"
#import "KJPhotoGroupDisplayViewController.h"
@interface KJPhotoGroupListViewController ()<UITableViewDelegate,UITableViewDataSource,GroupDisplayViewControllerDelegate>

/**
 视图表格
 */
@property (strong, nonatomic) UITableView *tableView;

/**
 刷新表视图
 */
@property (strong, nonatomic) NSMutableArray <KJPhotoGroupModel *>*groupListArray;

/**
 选择的视图
 */
@property (strong, nonatomic) NSMutableArray <KJPhotoAssetsModel *>*selectedArray;
@end

@implementation KJPhotoGroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self base];
    [self addTableView];
    [self groupData];
}

#pragma mark -
#pragma mark - DATA SOURCE 

- (void)groupData {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
        NSLog(@"无权限");
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [KJPhotoDataTool allPhotosGroup:^(id back) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.groupListArray = back;
                    [self.tableView reloadData];
                    if (self.isSingleSelected) {
                        [self.groupListArray enumerateObjectsUsingBlock:^(KJPhotoGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj.groupName isEqualToString:@"Camera Roll"] || [obj.groupName isEqualToString:@"相机胶卷"]) {
                                KJPhotoGroupDisplayViewController *vc = [[KJPhotoGroupDisplayViewController alloc] init];
                                vc.navigationItem.title = obj.groupName;
                                vc.model = obj;
                                vc.delegate = self;
                                vc.isSingleSelected = self.isSingleSelected;
                                [self.navigationController pushViewController:vc animated:NO];
                                *stop = YES;
                            }
                        }];
                    }
                });
            }];
        });
    }
}

#pragma mark -
#pragma mark - PRIVATE METHOD 导航设置

- (void)base {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择相册";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(groupListViewControllerClose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.selectedArray = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark -
#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 封面
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor grayColor];
        imageView.tag = 1;
        [cell addSubview:imageView];
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 200, 80)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [KJPhotoKitUtil colorWithHexString:@"333333"];
        titleLabel.tag = 2;
        [cell addSubview:titleLabel];
        
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, 79.5, SCREEN_WIDTH_KJPHOTOKIT, 0.5);
        layer.backgroundColor = [KJPhotoKitUtil colorWithHexString:@"999999"].CGColor;
        [cell.layer addSublayer:layer];
    }
    UIImageView *imageView = [cell viewWithTag:1];
    UILabel *titleLabel = [cell viewWithTag:2];
    
    KJPhotoGroupModel *model = self.groupListArray [indexPath.row];
    imageView.image = model.thumbImage;
    titleLabel.text = model.groupName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KJPhotoGroupModel *model = self.groupListArray [indexPath.row];
    KJPhotoGroupDisplayViewController *vc = [[KJPhotoGroupDisplayViewController alloc] init];
    vc.navigationItem.title = model.groupName;
    vc.model = model;
    vc.delegate = self;
    vc.isSingleSelected = self.isSingleSelected;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - <GroupDisplayViewControllerDelegate>

- (void)groupDisplayViewController:(UIViewController *)viewController didSelectedImageAsset:(KJPhotoAssetsModel *)model {
    [self.selectedArray addObject:model];
    if (self.isSingleSelected) {
        if ([self.delegate respondsToSelector:@selector(groupListViewController:didSelectedImageWithArray:)]) {
            [self.delegate groupListViewController:self didSelectedImageWithArray:self.arrayOfSelected];
        }
    }
}
- (void)groupDisplayViewController:(UIViewController *)viewController deSelectedImageAsset:(KJPhotoAssetsModel *)model {
    [self.selectedArray enumerateObjectsUsingBlock:^(KJPhotoAssetsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[NSString stringWithFormat:@"%@",[obj assetURL]] isEqualToString:[NSString stringWithFormat:@"%@",[model assetURL]]]) {
            [self.selectedArray removeObject:model];
            *stop = YES;
        }
    }];
}
- (NSMutableArray <KJPhotoAssetsModel *>*)arrayOfSelected {
    return self.selectedArray;
}
- (void)cancelAllSelected {
    [self.selectedArray removeAllObjects];
}
- (void)groupDisplayViewControllerSure {
    if ([self.delegate respondsToSelector:@selector(groupListViewController:didSelectedImageWithArray:)]) {
        [self.delegate groupListViewController:self didSelectedImageWithArray:self.arrayOfSelected];
    }
}
- (NSInteger)multipleCount {
    return self.count;
}

#pragma mark -
#pragma mark - PRIVATE METHOD SET

- (void)setCount:(NSInteger)count {
    if (count > 12) {
        count = 12;
    }
    _count = count;
}

#pragma mark -
#pragma mark - INTERFACE

/**
 关闭
 */
- (void)groupListViewControllerClose {
    if ([self.delegate respondsToSelector:@selector(groupListViewControllerCancel)]) {
        [self.delegate groupListViewControllerCancel];
    }
}

#pragma mark -
#pragma mark - PRIVATE METHOD 添加视图

- (void)addTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH_KJPHOTOKIT, SCREEN_HEIGHT_KJPHOTOKIT - 64)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
