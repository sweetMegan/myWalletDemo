//
//  ViewController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/22.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "ViewController.h"
#import "DownloadKeyStoreController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield_Pwd;
@property (weak, nonatomic) IBOutlet UIButton *button_Create;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建钱包";
    self.button_Create.layer.masksToBounds = YES;
    self.button_Create.layer.cornerRadius = 5.0f;
}
-(void)makeNav{
    self.hideBackBtn = YES;
    [super makeNav];
}
- (IBAction)createAccount:(id)sender {
    
    NSString *pwd = _textfield_Pwd.text;
    if ([BaseUtil isEmptyOrNull:pwd]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码不能为空"];
        return;
    }
    NSDictionary *params = @{
                             @"pwd":pwd,
                             };
    [AFNHttpTool post:@"createaccount" params:params uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        @try {
            NSLog(@"%@",responseObject);
            NSDictionary *responseData = [responseObject objectForKey:@"data"];
            NSDictionary *keyStore = [responseData objectForKey:@"keyStore"];
            NSString *privateKey = [responseData objectForKey:@"privateKey"];
            [self saveKeyStore:keyStore];
            DownloadKeyStoreController *keystoreVC = [[DownloadKeyStoreController alloc]init];
            keystoreVC.keyStore = [keyStore objectForKey:@"address"];
            keystoreVC.privateKey = privateKey;
            [self.navigationController pushViewController:keystoreVC animated:YES];
        } @catch (NSException *exception) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:kError_Unexpected];
        } @finally {
            
        }
    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//保存keyStore文件
-(void)saveKeyStore:(NSDictionary *)keyStore{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDateFormatter *formate = [[NSDateFormatter alloc]init];
        formate.dateFormat = @"yyyyMMddHHmmss";
        NSString *dateString = [formate stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"UTC--%@--%@.json",dateString,[keyStore objectForKey:@"address"]];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",kKeyStorePath,fileName];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:filePath]) {
            NSData *data= [NSJSONSerialization dataWithJSONObject:keyStore options:NSJSONWritingPrettyPrinted error:nil];
            
            [fm createFileAtPath:filePath contents:data attributes:nil];
        }
        
    });
    
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
