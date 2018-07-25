//
//  UnlockAccountController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "UnlockAccountController.h"
#import "SendTransactionController.h"
#import "KeyStoreListController.h"
@interface UnlockAccountController ()
@property (weak, nonatomic) IBOutlet UIButton *button_Keystore;
@property (weak, nonatomic) IBOutlet UITextField *textField_Pwd;
@property (weak, nonatomic) IBOutlet UIButton *button_unlock_Keystore;

@property (weak, nonatomic) IBOutlet UITextField *textfield_PrivateKey;
@property (weak, nonatomic) IBOutlet UIButton *button_PrivateKey;
@property(nonatomic,strong)NSDictionary *keyStore;

@end

@implementation UnlockAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"解锁账户";
    _button_Keystore.layer.masksToBounds = YES;
    _button_Keystore.layer.cornerRadius = 5.0f;
    _button_unlock_Keystore.layer.masksToBounds = YES;
    _button_unlock_Keystore.layer.cornerRadius = 5.0f;
    _button_PrivateKey.layer.masksToBounds = YES;
    _button_PrivateKey.layer.cornerRadius = 5.0f;
}
-(void)makeNav{
    self.hideBackBtn = YES;
    [super makeNav];
}
- (IBAction)chooseKeystoreAction:(id)sender {
    NSLog(@"选择Keystore");
    KeyStoreListController *keyStoreVC = [[KeyStoreListController alloc]init];
    __weak typeof(self) weakSelf = self;
    [keyStoreVC setSelectKeyStoreBlock:^(NSString *fileName) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",kKeyStorePath,fileName];
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:filePath]) {
            NSData *data = [NSData dataWithContentsOfFile:filePath options:NSUTF8StringEncoding error:nil];
            weakSelf.keyStore = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        }
        [weakSelf.button_Keystore setTitle:fileName forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:keyStoreVC animated:YES];
}
- (IBAction)unlockWithKeystoreAction:(id)sender {
    NSLog(@"Keystore解锁");
    NSString *pwd = _textField_Pwd.text;
    if ([BaseUtil isEmptyOrNull:pwd]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请填写私钥"];
        return;
    }
    
    NSDictionary *params = @{
                             @"pwd":pwd,
                             @"keyStore":self.keyStore,
                             };
    [AFNHttpTool post:@"unlockaccountwithkeystore" params:params uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                NSDictionary *responseData = [responseObject objectForKey:@"data"];
                NSString *address = [responseData objectForKey:@"address"];
                NSString *balance = [responseData objectForKey:@"balance"];
                NSString *privateKey = [responseData objectForKey:@"privateKey"];

                SendTransactionController *sendVC = [[SendTransactionController alloc]init];
                sendVC.address = address;
                sendVC.balance = balance;
                sendVC.privateKey = privateKey;
                [self.navigationController pushViewController:sendVC animated:YES];
            }else{
                NSLog(@"解锁失败");
            }
        } @catch (NSException *exception) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:kError_Unexpected];
        } @finally {
            
        }
    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)unlockWithPrivateKey:(id)sender {
    NSLog(@"privateKey解锁");
    NSString *privateKey = _textfield_PrivateKey.text;
    if ([BaseUtil isEmptyOrNull:privateKey]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请填写私钥"];
        return;
    }
    
    NSDictionary *params = @{
                             @"privateKey":privateKey,
                             };
    [AFNHttpTool post:@"unlockaccountwithprivatekey" params:params uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                NSDictionary *responseData = [responseObject objectForKey:@"data"];
                NSString *address = [responseData objectForKey:@"address"];
                NSString *balance = [responseData objectForKey:@"balance"];
                SendTransactionController *sendVC = [[SendTransactionController alloc]init];
                sendVC.address = address;
                sendVC.balance = balance;
                sendVC.privateKey = privateKey;
                [self.navigationController pushViewController:sendVC animated:YES];
            }else{
                NSLog(@"解锁失败");
            }
        } @catch (NSException *exception) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:kError_Unexpected];
        } @finally {
            
        }
    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
