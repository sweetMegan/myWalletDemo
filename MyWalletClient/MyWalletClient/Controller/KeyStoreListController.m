//
//  KeyStoreListController.m
//  MyWalletClient
//
//  Created by zhqMAC on 2018/7/24.
//  Copyright © 2018年 zhqMAC. All rights reserved.
//

#import "KeyStoreListController.h"

@interface KeyStoreListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KeyStoreListController{
    NSMutableArray *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的keyStore";
    [self prepareTableView];
    [self prepareDataSource];
}
-(void)prepareTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
}
-(void)prepareDataSource{
    _dataSource = [[NSMutableArray alloc]init];
    NSFileManager *fm = [NSFileManager defaultManager];

    NSDirectoryEnumerator *files = [fm enumeratorAtPath:kKeyStorePath];
    NSString *fileName;
    while (fileName = [files nextObject]) {
        if ([[fileName pathExtension] isEqualToString:@"json"]) {
            [_dataSource addObject:fileName];
        }
    }
    [_tableView reloadData];
}
#pragma mark -tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectKeyStoreBlock) {
        _selectKeyStoreBlock(_dataSource[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)setSelectKeyStoreBlock:(SelectKeyStoreBlock)block{
    _selectKeyStoreBlock = block;
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
