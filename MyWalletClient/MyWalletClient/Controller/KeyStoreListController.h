//
//  KeyStoreListController.h
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/24.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^SelectKeyStoreBlock) (NSString *fileName);

@interface KeyStoreListController : BaseViewController{
    SelectKeyStoreBlock _selectKeyStoreBlock;
}
-(void)setSelectKeyStoreBlock:(SelectKeyStoreBlock)block;
@end
