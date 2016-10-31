//
//  ReadDetailViewController.m
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadDetailViewController.h"

//数据类型
typedef enum {
    
    addTimeType,  //最新
    hotType       //最热
}DataType;

@interface ReadDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *addTimeTableView;  //最新列表
@property (strong, nonatomic) IBOutlet UITableView *hotTableView;      //最热列表
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;  //分段控制器
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;       //滚动视图
@property (strong, nonatomic)NSMutableDictionary *parameter; //请求参数
@property (strong, nonatomic)NSMutableArray *addtimeDataSource;  //存放最新数据的数组
@property (strong, nonatomic)NSMutableArray *hotDataSource;      //存放最热数据的数组
@property (assign, nonatomic)DataType dataType;    //数据类型
//@property (assign, nonatomic)NSInteger addTimeStartInteger;  //最新加载数据的起始位置
//@property (assign, nonatomic)NSInteger hotStartInteger;      //最热加载数据的起始位置
@property (assign, nonatomic)NSInteger StartInteger;

@end

@implementation ReadDetailViewController
#pragma mark - 懒加载
- (NSMutableDictionary *)parameter {
    
    if (!_parameter) {
        
        _parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"sort":@"addtime",@"limit":@10,@"typeid":[NSNumber numberWithInt:self.typeId],@"start":@0}];
    }
    return _parameter;
}

- (NSMutableArray *)addtimeDataSource {
    
    if (!_addtimeDataSource) {
        
        _addtimeDataSource = [NSMutableArray array];
    }
    return _addtimeDataSource;
}

- (NSMutableArray *)hotDataSource {
    
    if (!_hotDataSource) {
        
        _hotDataSource = [NSMutableArray array];
    }
    return _hotDataSource;
}

#pragma mark - 数据请求
//根据网址请求数据
- (void)fetchSourceDataWithUrl:(NSString *)url parameter:(NSMutableDictionary *)parameter {
    
    [LHFetchData postFetchDataWithUrlString:url paramenters:parameter success:^(id data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *listArray = dic[@"data"][@"list"];
        for (NSDictionary *object in listArray) {
            ReadDetailModel *model = [[ReadDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:object];
            if (self.dataType == addTimeType) {
                [self.addtimeDataSource addObject:model];
            }
            else {
                [self.hotDataSource addObject:model];
            }
        }
        [self.addTimeTableView reloadData];
        [self.hotTableView reloadData];
        [self.hotTableView.mj_footer endRefreshing];
        [self.hotTableView.mj_header endRefreshing];
        [self.addTimeTableView.mj_footer endRefreshing];
        [self.addTimeTableView.mj_header endRefreshing];
    } fail:^{
        
        NSLog(@"0");
    } view:self.view];
}

#pragma mark - UISegmentedControlAction
- (IBAction)clickSegmentedControlAction:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
            break;
        case 1:{
            [self.scrollView setContentOffset:CGPointMake(kWidths, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //如果当前滑动的滚动视图是我们自己的
    if (scrollView == self.scrollView) {
        
        //通过滑动视图的偏移量来判断当前segmentedControl
        if (scrollView.contentOffset.x == 0) {
            
            self.segmentedControl.selectedSegmentIndex = 0;
            self.dataType = addTimeType;
            [self.parameter setValue:@"addtime" forKey:@"sort"];
        }
        else if (scrollView.contentOffset.x == kWidths) {
            
            self.segmentedControl.selectedSegmentIndex = 1;
            self.dataType = hotType;
            [self.parameter setValue:@"hot" forKey:@"sort"];
            if (self.hotDataSource.count == 0) {
                
                [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
            }
        }
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //如果是最新列表的话返回最新数据的数组的个数
    if ([tableView isEqual:self.addTimeTableView]) {
        
        return self.addtimeDataSource.count;
    }
    else {
        return self.hotDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    ReadDetailModel *model = [[ReadDetailModel alloc] init];
    if (tableView == self.addTimeTableView) {
        
        model = self.addtimeDataSource[indexPath.row];
    }
    else if (tableView == self.hotTableView) {
        
        model = self.hotDataSource[indexPath.row];
    }
    [cell setCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadDetailModel *model = [[ReadDetailModel alloc] init];
    if (tableView == self.addTimeTableView) {
        
        model = self.addtimeDataSource[indexPath.row];
    }
    else if (tableView == self.hotTableView) {
        
        model = self.hotDataSource[indexPath.row];
    }
    ReadDetailInfoViewController *detailViewController = [[ReadDetailInfoViewController alloc] init];
    detailViewController.contentId = model.typeID;
    detailViewController.model = model;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - tableView下拉刷新上拉加载
- (void)refreshTableData {
    
    self.hotTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        self.StartInteger += 10;
        [self.parameter setValue:[NSNumber numberWithInteger:self.StartInteger] forKey:@"start"];
        [self.parameter setValue:@"hot" forKey:@"sort"];
        [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
    }];
    self.addTimeTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        self.StartInteger += 10;
        [self.parameter setValue:[NSNumber numberWithInteger:self.StartInteger] forKey:@"start"];
        [self.parameter setValue:@"addtime" forKey:@"sort"];
        [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
    }];
    
    
    self.addTimeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.addtimeDataSource = nil;
        [self.parameter setValue:@"addtime" forKey:@"sort"];
        [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
    }];
    self.hotTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.hotDataSource = nil;
        [self.parameter setValue:@"hot" forKey:@"sort"];
        [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
    }];
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消系统提供的64高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //最初的数据类型为最新
    self.dataType = addTimeType;
    [self fetchSourceDataWithUrl:kReadDetailUrl parameter:self.parameter];
    
    [self.addTimeTableView registerNib:[UINib nibWithNibName:@"ReadDetailCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self.hotTableView registerNib:[UINib nibWithNibName:@"ReadDetailCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    
    //刷新tableView
    [self refreshTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
