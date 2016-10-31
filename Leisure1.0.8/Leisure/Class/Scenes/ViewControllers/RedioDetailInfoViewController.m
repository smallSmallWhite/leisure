//
//  RedioDetailInfoViewController.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailInfoViewController.h"

@interface RedioDetailInfoViewController () <UITableViewDelegate,UITableViewDataSource,PlayManagerDelagate,UIScrollViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *playView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic)RedioDetailInfoPlayView *playViews;
@property (strong, nonatomic)RedioDetailInfoContent *contentViews;
@property (strong, nonatomic)NSString *currentUrl;   //记录当前正在播放的网址

@end

@implementation RedioDetailInfoViewController

+ (RedioDetailInfoViewController *)showRedioDetailInfoViewController {
    
    static RedioDetailInfoViewController *redioDetailInfoViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        redioDetailInfoViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RedioDetailInfoViewController"];
    });
    return redioDetailInfoViewController;
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSources {
    
    if (!_dataSources) {
        
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

#pragma mark - UIScrollView页面添加
- (void)addSubview {
    
    UINib *nibContent = [UINib nibWithNibName:@"RedioDetailInfoContent" bundle:nil];
    self.contentViews = [[nibContent instantiateWithOwner:nil options:nil] firstObject];
    self.contentViews.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.playView.frame.size.height);
    
    RedioDetailModel *model = [self.dataSources objectAtIndex:self.indexPath];
    [self.contentViews.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.playInfoModel.webview_url]]];
    self.contentViews.webView.delegate = self;
    [self.contentView addSubview:self.contentViews];
    
    
    
    UINib *nibPlayView = [UINib nibWithNibName:@"RedioDetailInfoPlayView" bundle:nil];
    self.playViews = [[nibPlayView instantiateWithOwner:nil options:nil] firstObject];
    self.playViews.frame = CGRectMake(0, 0, self.playView.frame.size.width, self.playView.frame.size.height);
    [self.playViews setCellWithModel:model];
    [self.playView addSubview:self.playViews];
}

#pragma mark - play相关
// 上一首
- (IBAction)playPre:(UIButton *)sender {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (self.indexPath == 0) {
            
            self.indexPath = self.dataSources.count-1;
        } else {
            
            self.indexPath--;
        }
        [self playRadio];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self refreshUI];
        });
    });
}

// 下一首
- (IBAction)playNext:(UIButton *)sender {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (self.indexPath == self.dataSources.count-1) {
            
            self.indexPath = 0;
        }
        else {
            
            self.indexPath++;
        }
        [self playRadio];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self refreshUI];
        });
    });
}

// 暂停
- (IBAction)playPause:(UIButton *)sender {
    
    
    if ([sender.currentTitle isEqualToString:@"暂停"]) {
        
        [sender setTitle:@"播放" forState:(UIControlStateNormal)];
        [[PlayManager showPlayManager] playRadio];
    }
    else if ([sender.currentTitle isEqualToString:@"播放"]) {
        
        [sender setTitle:@"暂停" forState:(UIControlStateNormal)];
        [[PlayManager showPlayManager] pauseRedio];
    }
}

// 播放音乐
- (void)playRadio {
    
    //获取即将播放的网址
    NSString *musicUrl = [self.dataSources[self.indexPath] musicUrl];
    if ([musicUrl isEqualToString:self.currentUrl]) {
        
        return;
    }
    else {
        
        self.currentUrl = musicUrl;
        [[PlayManager showPlayManager] prepareToPlayRadioWithUrl:[[self.dataSources[self.indexPath] playInfoModel] musicUrl]];
        [[PlayManager showPlayManager] playRadio];
    }
}

- (void)refreshUI {
    
    RedioDetailModel *model = [self.dataSources objectAtIndex:self.indexPath];
    [self.playViews setCellWithModel:model];
    [self.contentViews.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.playInfoModel.webview_url]]];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexPath inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
}

#pragma mark - UITableViewdelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RedioDetailInfoPlaylistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    [cell setCellWithModel:self.dataSources[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.indexPath = indexPath.row;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self playRadio];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self refreshUI];
        });
    });
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(kWidths, 0);
    } completion:nil];
    self.pageControl.currentPage = 1;
}

#pragma mark - playManagerDelegate
- (void)playManagerFetchRestTime:(NSString *)restTime progress:(CGFloat)progress {
    
    self.playViews.timeLabel.text = restTime;
    self.playViews.slider.value = progress;
}

//播放结束的协议
- (void)playManagerPlayRadioEnd {
    
    [self playNext:nil];
}

#pragma mark - PlayManagerDelagate
- (void)sliderAction:(UISlider *)sender {
    
    [[PlayManager showPlayManager] bySliderValueToPalyRadio:sender.value];
}

//下载按钮
- (void)downloadButtonAction:(UIButton *)sender {
    
    DownLoadManage *manager = [DownLoadManage shareDownLoadManage];
    RedioDetailModel *model = [self.dataSources objectAtIndex:self.indexPath];
    //先判断有没有正在下载
    DownLoad *downLoad = [manager findDownLoadWithModel:self.dataSources[self.indexPath]];
    if (downLoad) {
        
        [self alertController:@"已经在下载啦!赶快去下载列表看看👀"];
    }
    else {
        
        [self alertController:@"音乐🎵开始下载啦~\(≧▽≦)/~啦啦啦!快去下载列表看看👀"];
        //没有下载的时候进行下载
        downLoad = [manager addDownLoadWithModel:self.dataSources[self.indexPath]];
        DownloadViewController *downloadVC = [DownloadViewController shareDownloadViewController];
        [downloadVC.dataSource addObject:downLoad];
        [downloadVC.tableView reloadData];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    int index = offset.x/CGRectGetWidth(self.view.frame);
    self.pageControl.currentPage = index;
}
// 小白点的回调方法
- (void)pageControlAction:(UIPageControl *)sender {
    
    int index = (int)sender.currentPage;
    self.scrollView.contentOffset = CGPointMake(index*CGRectGetWidth(self.view.frame), 0);
}

#pragma mark - 视图声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RedioDetailInfoPlaylistCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [PlayManager showPlayManager].delegate = self;
    
    //让约束提前生效
    [self.scrollView layoutIfNeeded];
    [self.playViews layoutIfNeeded];
    self.scrollView.contentOffset = CGPointMake(kWidths, 0);
    [self addSubview];
    
    [self.playViews.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.playViews.downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.delegate = self;
    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.pageControl.currentPage = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self playRadio];
    [self refreshUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 警示框
- (void)alertController:(NSString *)alertContent{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:alertContent preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
