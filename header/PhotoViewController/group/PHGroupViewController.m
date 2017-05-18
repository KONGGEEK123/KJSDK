//
//  PHGroupViewController.m
//  KJPhotoManager
//
//  Created by 王振 DemoKing on 2017/3/9.
//  Copyright © 2017年 DemoKing. All rights reserved.
//

#import "PHGroupViewController.h"
#import "PHHeader.h"
#import "PHGroupTableViewCell.h"
#import "PHCollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PHGroupViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray <KJAssetCollection *>*grpupsArray;

@end

@implementation PHGroupViewController
{
    UITableView         *_tableView;
    NSTimer             *_timer;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigation];
    [self tableView];
    if ([PHPhotoLibrary authorizationStatus]) {
        [self dataSource];
    }else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(author) userInfo:nil repeats:YES];
    }
}

#pragma mark -
#pragma mark - PRIVATE

- (void)author {
    if ([PHPhotoLibrary authorizationStatus]) {
        [_timer invalidate];
        _timer = nil;
        [self dataSource];
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            }];
        });
    }
}
- (void)navigation {
    self.navigationItem.title = @"所有分组";
    [self changeNavAlpha:1 color:[UIColor colorWithHexString:@"2f2e33"]];
    [self titleColor:@"ffffff" font:17];
    [self barButtonItemTitle:@"  取消"];
}

#pragma mark -
#pragma mark - DATA SOURCE

- (void)dataSource {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        [KJCommonUI showAlertViewWithTitle:@"温馨提示" message:@"您没有开启相册权限，是否现在开启？" cancelButtonTitle:@"取消" sureButtonTitle:@"前往设置" inViewController:self cancelBlock:nil sureBlock:^{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }else {
                HUD(@"请手动设置")
            }
        }];
        return;
    }
    [PHData allImageGroup:^(NSMutableArray<KJAssetCollection *> *array) {
        self.grpupsArray = array;
        [_tableView reloadData];
        if (array.count) {
            KJAssetCollection *assetCollection = self.grpupsArray [0];
            PHCollectionViewController *vc = [[PHCollectionViewController alloc] init];
            vc.titleString = @"相机胶卷";
            vc.block = ^(id result){
                if (_block) {
                    _block (result);
                }
            };
            vc.count = self.count;
            vc.assetCollection = assetCollection.assetCollection;
            [self.navigationController pushViewController:vc animated:NO];
        }
    }];
}

#pragma mark -
#pragma mark - VIEWS

- (void)tableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - 20, SCREEN_WIDTH_PH, SCREEN_HEIGHT_PH + 20 - 64)];
    _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSMutableArray *)grpupsArray {
    if (!_grpupsArray) {
        _grpupsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _grpupsArray;
}

#pragma mark -
#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KJAssetCollection *assetCollection = self.grpupsArray [indexPath.row];
    PHCollectionViewController *vc = [[PHCollectionViewController alloc] init];
    if (indexPath.row == 0) {
        vc.titleString = @"相机胶卷";
    }else {
        vc.titleString = assetCollection.assetCollection.localizedTitle;
    }
    vc.block = ^(id result){
        if (_block) {
            _block (result);
        }
    };
    vc.count = self.count;
    vc.assetCollection = assetCollection.assetCollection;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.grpupsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KJAssetCollection *assetCollection = self.grpupsArray [indexPath.row];
    PHGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[PHGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell showCellWithKJAssetCollection:assetCollection];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
