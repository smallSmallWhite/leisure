//
//  ReadViewController.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadViewController.h"
#import "WYXScrollPicture.h"

@interface ReadViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)NSMutableArray *dataSource; //存放数据的数组
@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)WYXScrollPicture *picture;

@end

@implementation ReadViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kWidths/3-20, kWidths/3-20);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidths/3+64+50, kWidths, kHeights) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (WYXScrollPicture *)picture {
    
    if (!_picture) {
        
        _picture = [[WYXScrollPicture alloc] initWithFrame:CGRectMake(0, 64, kWidths, kWidths/3+100)];
        [_picture intervalOfScroll:2];
    }
    return _picture;
}

#pragma mark - 请求数据
- (void)fetchDataSoucreWithUrl:(NSString *)url {
    
    
    [LHFetchData postFetchDataWithUrlString:url paramenters:@{} success:^(id data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *listArray = dic[@"data"][@"list"];
        for (NSDictionary *object in listArray) {
            
            ReadModel *model = [[ReadModel alloc] init];
            [model setValuesForKeysWithDictionary:object];
            [self.dataSource addObject:model];
        }
        [self.collectionView reloadData];
        
        NSArray *carousel = dic[@"data"][@"carousel"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *object in carousel) {
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:object[@"img"]]];
            UIImage *image = [UIImage imageWithData:data];
            [array addObject:image];
        }
        self.picture.imageArr = array;
        [self.view addSubview:self.picture];
    } fail:^{
        
        NSLog(@"0");
    } view:self.view];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setCellWithReadModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReadDetailViewController *readDetailViewController = [main instantiateViewControllerWithIdentifier:@"ReadDetailViewController"];
    ReadModel *model = self.dataSource[indexPath.row];
    readDetailViewController.typeId = model.type;
    [self.navigationController pushViewController:readDetailViewController animated:YES];
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    [self fetchDataSoucreWithUrl:kReadUrl];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ReadListCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    
//    开眼
//    [LHFetchData getFetchDataWithUrlString:@"http://baobab.wandoujia.com/api/v2/feed" paramenters:@{} success:^(id data) {
//        
//        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        NSLog(@"%@",dic);
//    } fail:^{
//        
//        NSLog(@"0");
//    } view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
