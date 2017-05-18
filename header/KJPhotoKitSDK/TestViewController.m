//
//  TestViewController.m
//  KJPhotoKit
//
//  Created by 王振 DemoKing on 2016/11/18.
//  Copyright © 2016年 DemoKing. All rights reserved.
//

#import "TestViewController.h"
#import "KJPhotoKitManager.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [KJPhotoKitManager showKitInViewController:self selectedType:KJPhotoKitManagerTypeSingle count:0 sure:^(NSMutableArray<KJPhotoAssetsModel *> *array) {
        
    } cancel:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
