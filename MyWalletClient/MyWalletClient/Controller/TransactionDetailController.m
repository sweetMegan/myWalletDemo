//
//  TransactionDetailController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/25.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "TransactionDetailController.h"

@interface TransactionDetailController ()
@property (weak, nonatomic) IBOutlet UIButton *button_Check;
@property (weak, nonatomic) IBOutlet UITextField *textField_TxHash;
@property (weak, nonatomic) IBOutlet UITextView *textView_Detail;

@end

@implementation TransactionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易详情";
    _button_Check.layer.masksToBounds = YES;
    _button_Check.layer.cornerRadius = 5.0f;
    if(![BaseUtil isEmptyOrNull:self.txHash]){
        _textField_TxHash.text = self.txHash;
        [self checkAction:nil];
    }
}
-(void)makeNav{
    if(![BaseUtil isEmptyOrNull:self.txHash]){
        self.hideBackBtn = NO;
    }else{
        self.hideBackBtn = YES;
    }
    [super makeNav];
}
- (IBAction)checkAction:(id)sender {
    if (![BaseUtil isEmptyOrNull:_textField_TxHash.text]) {
        NSDictionary *params = @{
                                 @"txHash":_textField_TxHash.text,
                                 };
        __weak typeof(self) weakSelf = self;
        [AFNHttpTool post:@"transactionstatus" params:params uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            @try {
                NSLog(@"%@",responseObject);
                if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                    NSDictionary *responseData = [responseObject objectForKey:@"data"];
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseData options:NSJSONWritingPrettyPrinted error:nil];
                   weakSelf.textView_Detail.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                }else{
                    weakSelf.textView_Detail.text = @"查询出错";
                }
            } @catch (NSException *exception) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:kError_Unexpected];
            } @finally {
                
            }
        } failureHandler:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
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
