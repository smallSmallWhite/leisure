//
//  TopicViewController.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataSource;
@property (strong, nonatomic)NSMutableDictionary *parameters;
@property (assign, nonatomic)NSInteger startInteger;

@end

@implementation TopicViewController
#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableDictionary *)parameters {
    
    if (!_parameters) {
        
        _parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"start":@0}];
    }
    return _parameters;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - 数据请求
-(void)fetchDataWithURL:(NSString *)url parameters:(NSMutableDictionary *)parameter {
    
    [LHFetchData postFetchDataWithUrlString:url paramenters:parameter success:^(id data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSArray *arrayList = dic[@"data"][@"list"];
        for (NSDictionary *object in arrayList) {
            TopicModel *model = [[TopicModel alloc]init];
            [model setValuesForKeysWithDictionary:object];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } fail:^{
        
        NSLog(@"0");
    } view:self.view];
}

#pragma mark - tableView下拉刷新上拉加载
- (void)refreshTableData {
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        self.startInteger += 10;
        [self.parameters setValue:[NSNumber numberWithInteger:self.startInteger] forKey:@"start"];
        [self fetchDataWithURL:kTopicUrl parameters:self.parameters];
    }];
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.dataSource = nil;
        [self fetchDataWithURL:kTopicUrl parameters:self.parameters];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    TopicModel *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicDetailViewController *topicDetailVC = [[TopicDetailViewController alloc] init];
    TopicModel *model = self.dataSource[indexPath.row];
    topicDetailVC.contentid = model.contentid;
    [self.navigationController pushViewController:topicDetailVC animated:YES];
}

#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self.view addSubview:self.tableView];
    [self fetchDataWithURL:kTopicUrl parameters:self.parameters];
    [self refreshTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
