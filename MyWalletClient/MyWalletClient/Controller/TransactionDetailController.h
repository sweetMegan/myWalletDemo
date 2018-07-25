//
//  TransactionDetailController.h
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/25.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "BaseViewController.h"

@interface TransactionDetailController : BaseViewController
//确认交易后自动查看
@property(nonatomic,strong)NSString *txHash;

@end
