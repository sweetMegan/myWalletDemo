//
//  SendTransactionController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "SendTransactionController.h"
#import "ConfirmTransactionController.h"
@interface SendTransactionController ()
@property (weak, nonatomic) IBOutlet UILabel *label_Address;
@property (weak, nonatomic) IBOutlet UILabel *label_Amount;
@property (weak, nonatomic) IBOutlet UITextField *textfield_Recieve;
@property (weak, nonatomic) IBOutlet UITextField *textfiled_Money;
@property (weak, nonatomic) IBOutlet UIButton *button_Send;

@end

@implementation SendTransactionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发送交易";
    _label_Address.text = _address;
    _label_Amount.text = [NSString stringWithFormat:@"%@ ETH",_balance];
    _button_Send.layer.masksToBounds = YES;
    _button_Send.layer.cornerRadius = 5.0f;
    
}
- (IBAction)sendAction:(id)sender {
    NSLog(@"发送交易");
    
    NSString *toAddress = _textfield_Recieve.text;
#warning 正则判断
    NSString *money = _textfiled_Money.text;
    if ([BaseUtil isEmptyOrNull:toAddress]||[BaseUtil isEmptyOrNull:money]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"接收人地址和转账金额不能为空"];
        return;
    }
    
    NSDictionary *params = @{
                             @"from":_address,
                             @"to":toAddress,
                             @"money":money,
                             };
    __weak typeof(self) weakSelf = self;
    [AFNHttpTool post:@"createtransaction" params:params uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                NSDictionary *responseData = [responseObject objectForKey:@"data"];
                ConfirmTransactionController *confirmVC = [[ConfirmTransactionController alloc]init];
                confirmVC.tranctionInfo = [[NSMutableDictionary alloc]initWithDictionary:responseData];
                [confirmVC.tranctionInfo setObject:weakSelf.privateKey forKey:@"privateKey"];
                [weakSelf.navigationController pushViewController:confirmVC animated:YES];
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
