//
//  CollectionViewController.m
//  Leisure
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataSource;

@end

@implementation CollectionViewController

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableView showMessage:@"您还没有收藏" byDataSourceCount:self.dataSource.count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadDetailCell" forIndexPath:indexPath];
    ReadDetailModel *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

#pragma mark - UITableViewDelegate
////是否可编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return YES;
//}
//
////设置tableView的编辑模式
//- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return UITableViewCellEditingStyleDelete;
//}

//当tableViewCell编辑的时候执行的代理事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除数据源
        [[DataManager shareDataManager] deleteData:self.dataSource[indexPath.row]];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadDetailModel *model = [[ReadDetailModel alloc] init];
    model = self.dataSource[indexPath.row];
    ReadDetailInfoViewController *detailViewController = [[ReadDetailInfoViewController alloc] init];
    detailViewController.contentId = model.typeID;
    detailViewController.model = model;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataSource addObjectsFromArray:[[DataManager shareDataManager] selectedData]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadDetailCell" bundle:nil] forCellReuseIdentifier:@"ReadDetailCell"];
    
    [self.view addSubview:self.tableView];
    
    //语法糖 左按钮
//    self.navigationItem.leftBarButtonItem = ({
//        
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backItemAction:)];
//        backItem;
//    });
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
}

//- (void)backItemAction:(UIBarButtonItem *)sender {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
