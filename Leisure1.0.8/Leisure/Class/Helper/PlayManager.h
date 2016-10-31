//
//  PlayManager.h
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayManagerDelagate <NSObject>

- (void)playManagerFetchRestTime:(NSString *)restTime progress:(CGFloat)progress;

//播放结束的协议方法
- (void)playManagerPlayRadioEnd;
@end

@class AVPlayer;
@interface PlayManager : NSObject

@property (weak, nonatomic)id<PlayManagerDelagate> delegate;

@property (strong, nonatomic)AVPlayer *player;  //专门用来处理音频

+ (PlayManager *)showPlayManager;

//准备播放
- (void)prepareToPlayRadioWithUrl:(NSString *)url;

//播放
- (void)playRadio;

//暂停
- (void)pauseRedio;

//通过滑块控制播放进度
- (void)bySliderValueToPalyRadio:(CGFloat)progress;

/**
 * 本地播放音乐
 */
- (void)playLocalMusicWithFile:(NSString *)filrPath;
@end
