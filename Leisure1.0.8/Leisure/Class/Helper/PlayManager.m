//
//  PlayManager.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "PlayManager.h"

@interface PlayManager ()

@property (strong, nonatomic)NSTimer *timer;

@end

@implementation PlayManager

+ (PlayManager *)showPlayManager {
    
    static PlayManager *playManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        playManager = [[PlayManager alloc] init];
    });
    return playManager;
}

//重写init方法，当对象被初始化的时候，去创建player对象
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.player = [[AVPlayer alloc] init];
        //当播放结束的时候发送一个通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playRadioEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

//准备播放
- (void)prepareToPlayRadioWithUrl:(NSString *)url {
    
    if (!url) {
        return;
    }
    //根据Url创建AVPlayerItem对象
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
    //替换当前
    [self.player replaceCurrentItemWithPlayerItem:item];
}

//播放
- (void)playRadio {
    
    [self.player play];
    [self startTimer];
}

//暂停
- (void)pauseRedio {
    
    [self.player pause];
    [self closeTimer];
}

//获取当前播放时间
- (NSInteger)fetchCurrentTime {
    
    CMTime time = self.player.currentTime;
    //获取当前播放秒数time.value/time.timescale
    if (time.timescale == 0) {
        
        return 0;
    }
    return time.value/time.timescale;
}

//获取总时间
- (NSInteger)fetchTotalTime {
    
    CMTime time = self.player.currentItem.duration;
    if (time.timescale == 0) {
        
        return 0;
    }
    return time.value/time.timescale;
}

//获取播放进度
- (CGFloat)fetchPlayProgress {
    
    //当前时间
    CGFloat currentTime = [self fetchCurrentTime];
    //总时间
    CGFloat totalTime = [self fetchTotalTime];
    return currentTime/totalTime;
}

//把时间转换成字符串
- (NSString *)changTimeToString:(NSInteger)seconds {
    
    //获取分数
    NSInteger min = seconds/60;
    //获取余数
    NSInteger sec = seconds%60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}

//开启定时器
- (void)startTimer {
    
    //判断如果当前timer已经被初始化以后，不再去初始化
    if (self.timer) {
        
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

//关闭定时器
- (void)closeTimer {
    
    //把timer废除掉
    [self.timer invalidate];
    self.timer = nil;
}

//定时器事件
- (void)timerAction:(NSTimer *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playManagerFetchRestTime:progress:)]) {
        
        //获取剩余时间
        NSInteger restTime = [self fetchTotalTime] - [self fetchCurrentTime];
        [self.delegate playManagerFetchRestTime:[self changTimeToString:restTime] progress:[self fetchPlayProgress]];
    }
}

//通过滑块控制播放进度
- (void)bySliderValueToPalyRadio:(CGFloat)progress {
    
    //滑动的时候去暂停音乐
    [self pauseRedio];
    //从指定的时间去播放
    __weak PlayManager *weakSelf = self;  //(使用weakSelf替代self)
    [self.player seekToTime:CMTimeMake(progress * [weakSelf fetchTotalTime], 1) completionHandler:^(BOOL finished) {
        
        if (finished) {
            
            [self playRadio];
        }
    }];
}

#pragma mark - 通知回调方法
- (void)playRadioEnd {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playManagerPlayRadioEnd)]) {
        
        [self.delegate playManagerPlayRadioEnd];
    }
    
}

/**
 * 本地播放音乐
 */
- (void)playLocalMusicWithFile:(NSString *)filrPath {
    
    [self pauseRedio];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filrPath];
    //URL转换String
    NSString *str = url.absoluteString;
    [self prepareToPlayRadioWithUrl:str];
    [self playRadio];
}

@end
