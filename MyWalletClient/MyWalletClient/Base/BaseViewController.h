//
//  BaseViewController.h
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**
 *是否显示回退按钮
 */
@property(nonatomic,assign) BOOL hideBackBtn;
-(void)makeNav;
-(void)navBack;
@end
