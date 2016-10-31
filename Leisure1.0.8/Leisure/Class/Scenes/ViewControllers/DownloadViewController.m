//
//  DownloadViewController.m
//  Leisure
//
//  Created by xalo on 16/4/24.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (assign, nonatomic)BOOL isPlay;

@end

@implementation DownloadViewController

+ (DownloadViewController *)shareDownloadViewController {
    
    static DownloadViewController *downloadVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        downloadVC = [main instantiateViewControllerWithIdentifier:@"DownloadViewController"];
    });
    return downloadVC;
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)completeDataSource {
    
    if (!_completeDataSource) {
        
        _completeDataSource = [NSMutableArray array];
    }
    return _completeDataSource;
}

#pragma mark - 从数据库中获取下载完成数据
- (void)getDataFromDB {
    
    [self.completeDataSource removeAllObjects];
    DataManager *manager = [DataManager shareDataManager];
    self.completeDataSource = [[manager selectedDownloadData] mutableCopy];;
    [self.completeTableView reloadData];
}

#pragma mark - UIScrollViewDelegate,UISegmentedControlAction
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.scrollView]) {
        
        self.segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x / kWidths;
    }
    [self.completeTableView reloadData];
}

- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * kWidths, 0) animated:YES];
    [self.completeTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:self.tableView]) {
        
        return [tableView showMessage:@"你还没有正在下载的任务" byDataSourceCount:self.dataSource.count];
    }
    else {
        
        return [tableView showMessage:@"你还没有下载" byDataSourceCount:self.completeDataSource.count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    if ([tableView isEqual:self.tableView]) {
        
        //获取正在下载的model
        DownLoad *download = self.dataSource[indexPath.row];
        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:download.model.coverimg]];
        cell.title.text = download.model.title;
        [download didDownloading:^(float progress) {
            
            cell.progress.text = [NSString stringWithFormat:@"%.2f%%",progress];
        } complete:^(NSString *filePath, RedioDetailModel *model) {
            
            DataManager *dataManager = [DataManager shareDataManager];
            [dataManager insertDownloadData:model filePath:filePath];
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self getDataFromDB];
        }];
    }
    else {
        
        DownloadModel *model = [self.completeDataSource objectAtIndex:indexPath.row];
        cell.title.text = model.title;
        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        cell.progress.text = @"下载完成";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

#pragma mark - UITableViewDelegate
//当tableViewCell编辑的时候执行的代理事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //删除数据源
        [[DataManager shareDataManager] deleteDownloadData:self.completeDataSource[indexPath.row]];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.isPlay) {
    
        if ([tableView isEqual:self.completeTableView]) {
            
            DownloadModel *model = [self.completeDataSource objectAtIndex:indexPath.row];
            NSString *path = [[model.filePath componentsSeparatedByString:@"/"] lastObject];
            NSString *str = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            path = [str stringByAppendingPathComponent:path];
            [[PlayManager showPlayManager] playLocalMusicWithFile:path];
        }
        self.isPlay = YES;
    }
    else {
        
        [[PlayManager showPlayManager] pauseRedio];
        self.isPlay = NO;
    }
}

#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //语法糖 左按钮
//    self.navigationItem.leftBarButtonItem = ({
//        
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backItemAction:)];
//        backItem;
//    });
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DownloadCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    [self.completeTableView registerNib:[UINib nibWithNibName:@"DownloadCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self getDataFromDB];
}


//跳转
//- (void)backItemAction:(UIBarButtonItem *)sender {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
