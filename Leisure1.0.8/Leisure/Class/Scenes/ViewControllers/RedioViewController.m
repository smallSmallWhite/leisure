//
//  RedioViewController.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioViewController.h"

@interface RedioViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)HeadView *picture;
@property (strong, nonatomic)NSMutableArray *imageArray;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *dataSource;
@property (assign, nonatomic)NSInteger dataSourceInteger;
@property (strong, nonatomic)NSMutableDictionary *paramenters;

@end

@implementation RedioViewController
#pragma mark - 懒加载
- (HeadView *)picture {
    
    if (!_picture) {
        
        _picture = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kWidths, kHeights/4) ImageArray:self.imageArray];
        _picture.carousel.type = iCarouselTypeCoverFlow;
    }
    return _picture;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidths, kHeights)];
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

- (NSMutableDictionary *)paramenters {
    
    if (!_paramenters) {
        
        _paramenters = [NSMutableDictionary dictionaryWithDictionary:@{@"start":@0}];
    }
    return _paramenters;
}

#pragma mark - 数据请求
- (void)fetchSourceDataWithUrl:(NSString *)url paramenters:(NSMutableDictionary *)paramenters {
    
    [LHFetchData postFetchDataWithUrlString:url paramenters:paramenters success:^(id data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSMutableArray *imgArray = [NSMutableArray array];
        NSArray *imageArray = dic[@"data"][@"carousel"];
        for (NSDictionary *object in imageArray) {
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:object[@"img"]]];
            UIImage *image = [UIImage imageWithData:data];
            [imgArray addObject:image];
        }
        self.imageArray = imgArray;
        self.tableView.tableHeaderView = self.picture;
        
        
        
        NSArray *content = dic[@"data"][@"alllist"];
        NSArray *update = dic[@"data"][@"list"];
        if ([url isEqual:kRedioUrl]) {
            
            for (NSDictionary *object in content) {
                
                RedioModel *model = [[RedioModel alloc] init];
                [model setValuesForKeysWithDictionary:object];
                [self.dataSource addObject:model];
            }
        }
        else if ([url isEqual:kRedioUrlUpdate]) {
            
            for (NSDictionary *object in update) {
                
                RedioModel *model = [[RedioModel alloc] init];
                [model setValuesForKeysWithDictionary:object];
                [self.dataSource addObject:model];
            }
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } fail:^{
        
        NSLog(@"0");
    } view:self.view];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RedioDetailViewController *redioDetailViewController = [main instantiateViewControllerWithIdentifier:@"RedioDetailViewController"];
    
    RedioModel *model = self.dataSource[indexPath.item];
    redioDetailViewController.radioid = model.radioid;
    [self.navigationController pushViewController:redioDetailViewController animated:YES];
}

#pragma mark - tableView下拉刷新上拉加载
- (void)refreshTableData {
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        self.dataSourceInteger += 10;
        [self.paramenters setValue:[NSNumber numberWithInteger:self.dataSourceInteger] forKey:@"start"];
        [self fetchSourceDataWithUrl:kRedioUrlUpdate paramenters:self.paramenters];
    }];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        self.dataSource = nil;
        [self fetchSourceDataWithUrl:kRedioUrl paramenters:self.paramenters];
    }];
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    [self.view addSubview:self.tableView];
    [self fetchSourceDataWithUrl:kRedioUrl paramenters:self.paramenters];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RedioCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self refreshTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
