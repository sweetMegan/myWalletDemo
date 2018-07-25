//
//  DownloadKeyStoreController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "DownloadKeyStoreController.h"
#import "KeyStoreListController.h"
@interface DownloadKeyStoreController ()
@property (weak, nonatomic) IBOutlet UIButton *button_Download;
@property (weak, nonatomic) IBOutlet UITextField *textfiled_PrivateKey;
@property (weak, nonatomic) IBOutlet UILabel *label_KeyStore;

@end

@implementation DownloadKeyStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button_Download.layer.masksToBounds = YES;
    _button_Download.layer.cornerRadius = 5.0f;
    _label_KeyStore.text = [NSString stringWithFormat:@"%@已保存，点击查看",_keyStore];
    
    _textfiled_PrivateKey.text = _privateKey;
}
- (IBAction)downloadAction:(id)sender {
    NSLog(@"%@",_keyStore);
    KeyStoreListController *keyStroreListVC = [[KeyStoreListController alloc]init];
    [self.navigationController pushViewController:keyStroreListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
