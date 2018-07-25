//
//  BaseNavController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "BaseNavController.h"
#import "UIImage+Color.h"
@interface BaseNavController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavController
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    //    return UIStatusBarStyleDefault;
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //    self.navigationBar.shadowImage = [UIImage imageWithColor:RGB(202, 218, 241) andSize:CGSizeMake(KscreenW, 10)];
    //    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor clearColor] andSize:CGSizeMake(KscreenW, 3)]];
    
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    //右滑返回
    __weak BaseNavController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        //        NSLog(@"$$$$$$$$$-----respondsToSelector");
        self.delegate = weakSelf;
    }
    
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
//右滑返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        //        NSLog(@"--------PushViewController  NO");
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //    NSLog(@"--------PushViewController  YES");
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        //        NSLog(@"++++++++popToRootViewController NO");
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //    NSLog(@"++++++++popToRootViewController YES");
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        //        NSLog(@"popToViewController NO");
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //    NSLog(@"popToViewController YES");
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            //            NSLog(@"poopopopopo  NO");
            return NO;
        }
    }
    //    NSLog(@"poopopopopo  YES");
    
    return YES;
}

@end
