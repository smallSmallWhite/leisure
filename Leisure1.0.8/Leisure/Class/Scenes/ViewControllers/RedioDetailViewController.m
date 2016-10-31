//
//  RedioDetailViewController.m
//  Leisure
//
//  Created by pengma on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailViewController.h"

@interface RedioDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableDictionary *parameter;  //网络参数
@property (strong, nonatomic)RedioDetailHeaderView *redioDetailHeaderView;  //头视图
@property (strong, nonatomic)NSMutableArray *dataSources;  //数据缓存
@property (strong, nonatomic)NSMutableArray *headerDataSource; //头视图数据缓存
@property (assign, nonatomic)NSInteger startInteger;

@end

@implementation RedioDetailViewController
#pragma mark - 懒加载
- (RedioDetailHeaderView *)redioDetailHeaderView {
    
    if (!_redioDetailHeaderView) {
        
        UINib *nib = [UINib nibWithNibName:@"RedioDetailHeaderView" bundle:nil];
        _redioDetailHeaderView = [[nib instantiateWithOwner:nil options:nil] firstObject];
        _redioDetailHeaderView.frame = CGRectMake(0, 0, kWidths, kHeights/3+40);
    }
    return _redioDetailHeaderView;
}

-(NSMutableDictionary *)parameter{
    
    
    if (!_parameter) {
        
        _parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"radioid":self.radioid,@"start":@0}];
    }
    return _parameter;
}

- (NSMutableArray *)dataSources {
    
    if (!_dataSources) {
        
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (NSMutableArray *)headerDataSource {
    
    if (!_headerDataSource) {
        
        _headerDataSource = [NSMutableArray array];
    }
    return _headerDataSource;
}

#pragma mark - 数据请求
- (void)fetchSourceDataWithUrl:(NSString *)url parameter:(NSMutableDictionary *)parameter {

    [LHFetchData postFetchDataWithUrlString:url paramenters:parameter success:^(id data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        RedioDetailHeaderViewModel *headerModel = [[RedioDetailHeaderViewModel alloc] init];
        [headerModel setValuesForKeysWithDictionary:dic[@"data"][@"radioInfo"]];
        [self.redioDetailHeaderView setCellWithModel:headerModel];
        
        NSArray *array = dic[@"data"][@"list"];
        for (NSDictionary *object in array) {
            
            RedioDetailModel *model = [[RedioDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:object];
            [self.dataSources addObject:model];
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
        [self.parameter setValue:[NSNumber numberWithInteger:self.startInteger] forKey:@"start"];
        [self fetchSourceDataWithUrl:kRedioDetailUrlUpdate parameter:self.parameter];
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.dataSources = nil;
        [self fetchSourceDataWithUrl:kRedioDetailUrl parameter:self.parameter];
    }];
}


#pragma mark -- tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSources.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    RedioDetailModel *model = [[RedioDetailModel alloc] init];
    model = self.dataSources[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedioDetailInfoViewController *redioDetailInfoViewController = [RedioDetailInfoViewController showRedioDetailInfoViewController];
    redioDetailInfoViewController.dataSources = self.dataSources;
    redioDetailInfoViewController.indexPath = indexPath.row;
    [self.navigationController pushViewController:redioDetailInfoViewController animated:YES];
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.redioDetailHeaderView layoutIfNeeded];
    [self.tableView layoutIfNeeded];
    self.tableView.tableHeaderView = self.redioDetailHeaderView;
    [self fetchSourceDataWithUrl:kRedioDetailUrl parameter:self.parameter];
    [self.tableView registerNib:[UINib nibWithNibName:@"RedioDetailCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self refreshTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
