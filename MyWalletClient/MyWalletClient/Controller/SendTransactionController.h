//
//  SendTransactionController.h
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "BaseViewController.h"

@interface SendTransactionController : BaseViewController
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *balance;
@property(nonatomic,strong)NSString *privateKey;
@end
