//
//  TopicDetailViewController.m
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "TopicDetailViewController.h"

@interface TopicDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataSource;
@property (strong, nonatomic)TopicDetailHeaderView *headerView;
@property (strong, nonatomic)NSMutableDictionary *parameter;

@end

@implementation TopicDetailViewController
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

- (TopicDetailHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [[TopicDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidths, kHeights/3)];
    }
    return _headerView;
}

- (NSMutableDictionary *)parameter {
    
    if (!_parameter) {
        
        _parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"contentid":self.contentid,@"start":@0}];
    }
    return _parameter;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"a";
    return cell;
}


#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
