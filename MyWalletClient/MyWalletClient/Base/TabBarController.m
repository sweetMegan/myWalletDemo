//
//  TabBarController.m
//  YiLinLi
//
//  Created by Shixiongwei on 15/5/19.
//  Copyright (c) 2015年 Shixiongwei. All rights reserved.
//**********************  设置tabbar,添加tabbarcontroller子控制器  ********************** //

#import "TabBarController.h"
#import "ViewController.h"
#import "UnlockAccountController.h"
#import "BaseNavController.h"
#import "TransactionDetailController.h"
@interface TabBarController ()<UITabBarControllerDelegate>

@end

@implementation TabBarController{
    //弹出拨号键盘
    UIImage *_showPadImage;
    //隐藏拨号键盘
    UIImage *_hidePadImage;
    BOOL _showPad;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [UITabBar appearance].translucent = NO;
    //创建账号
    ViewController *createVC = [[ViewController alloc]init];
    //解锁账号
    UnlockAccountController *unlockVC = [[UnlockAccountController alloc]init];
    //交易查询
    TransactionDetailController *transactionVC = [[TransactionDetailController alloc]init];

    BaseNavController *v0 = [[BaseNavController alloc]initWithRootViewController:createVC];
    BaseNavController* v1 = [[BaseNavController alloc] initWithRootViewController:unlockVC];
    BaseNavController* v2 = [[BaseNavController alloc] initWithRootViewController:transactionVC];

    self.viewControllers = @[v0,v1,v2];
    NSArray *titleArr=@[@"创建钱包",@"发起交易",@"交易详情"];
    for(int i=0;i<titleArr.count;i++)
    {
        UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:nil selectedImage:nil];
        self.viewControllers[i].tabBarItem = tabbarItem;
        [self.viewControllers[i].tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.317 alpha:1.000],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    }
    self.tabBar.opaque = YES; //005aa3
    
    //需要给tabbar设置图片
    //选中,tabbar字体设置
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_NAV_BLUE,NSFontAttributeName:[UIFont boldSystemFontOfSize:10]} forState:UIControlStateSelected];
    self.delegate=self;
}
#pragma mark-
#pragma mark 禁屏幕横屏
-(BOOL)shouldAutorotate{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
