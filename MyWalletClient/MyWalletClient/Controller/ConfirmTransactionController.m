//
//  ConfirmTransactionController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/25.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "ConfirmTransactionController.h"
#import "TransactionDetailController.h"
@interface ConfirmTransactionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button_Confirm;
@property (weak, nonatomic) IBOutlet UIButton *button_Cancel;

@end

@implementation ConfirmTransactionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易确认";
    [self prepareTableView];
}
-(void)prepareTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    _button_Confirm.layer.masksToBounds = YES;
    _button_Confirm.layer.cornerRadius = 5.0f;
    _button_Cancel.layer.masksToBounds = YES;
    _button_Cancel.layer.cornerRadius = 5.0f;
}
- (IBAction)confirmAction:(id)sender {
    NSLog(@"确认交易");
    __weak typeof(self) weakSelf = self;
    [AFNHttpTool post:@"sendtransaction" params:_tranctionInfo uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @try {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"code"] integerValue] == 0) {
                NSDictionary *responseData = [responseObject objectForKey:@"data"];
                NSString *txHash = [responseData objectForKey:@"hash"];
                TransactionDetailController *transactionVC = [[TransactionDetailController alloc]init];
                transactionVC.txHash = txHash;
                [weakSelf.navigationController pushViewController:transactionVC animated:YES];
            }else{
            }
        } @catch (NSException *exception) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:kError_Unexpected];
        } @finally {
            
        }
    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"交易失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = [NSString stringWithFormat:@"发送人:%@",[_tranctionInfo objectForKey:@"from"]];
            break;
        }
        case 1:{
            cell.textLabel.text = [NSString stringWithFormat:@"接收人:%@",[_tranctionInfo objectForKey:@"to"]];
            break;
        }
        case 2:{
            cell.textLabel.text = [NSString stringWithFormat:@"转账金额:%@",[_tranctionInfo objectForKey:@"value"]];
            break;
        }
        case 3:{
            cell.textLabel.text = [NSString stringWithFormat:@"gasPrice:%@",[_tranctionInfo objectForKey:@"gasPrice"]];
            break;
        }
        case 4:{
            cell.textLabel.text = [NSString stringWithFormat:@"nonce:%@",[_tranctionInfo objectForKey:@"nonce"]];
            break;
        }
        case 5:{
            cell.textLabel.text = [NSString stringWithFormat:@"gas:%@",[_tranctionInfo objectForKey:@"gas"]];
            break;
        }
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
