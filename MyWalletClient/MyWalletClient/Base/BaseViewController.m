//
//  BaseViewController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNav];
    _hideBackBtn = NO;
    // Do any additional setup after loading the view.
}
-(void)makeNav{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBar.barTintColor = COLOR_NAV_BLUE;
    //    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    if (!_hideBackBtn) {
        UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"title_bar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(navBack)];
        self.navigationItem.leftBarButtonItem = backBtnItem;
    }
}
-(void)navBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
