//
//  DownLoad.m
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "DownLoad.h"

@interface DownLoad () <NSURLSessionDownloadDelegate>

@property (strong, nonatomic)NSURLSession *session;           //根据session生成task,控制下载开始和暂停
@property (strong, nonatomic)NSURLSessionDownloadTask *task;  //下载任务
@property (copy, nonatomic)Complete complete;
@property (copy, nonatomic)DownLoading downloading;

@end
@implementation DownLoad

- (instancetype)initWithRedioDetailModel:(RedioDetailModel *)model {
    
    self = [super init];
    if (self) {
        
        self.model = model;
        //初始化的时候，直接进行下载
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        self.task = [self.session downloadTaskWithURL:[NSURL URLWithString:model.musicUrl]];
    }
    return self;
}

// 正在下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    float progress = totalBytesWritten*100/totalBytesExpectedToWrite;
    //判断是否存在
    //block赋值
    if (self.downloading) {
        
        self.downloading(progress);
    }
}


// 完成下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    //获取路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //根据服务器的命名创建文件路径
    filePath = [filePath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    //把临时的文件夹移到指定的路径
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:filePath error:nil];
    //下载完后执行协议方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishDownloadWithUrl:)]) {
        
        [self.delegate didFinishDownloadWithUrl:self.model.musicUrl];
    }
    //block赋值
    if (self.complete) {
        
        self.complete(filePath,self.model);
    }
    //取消下载器（让下载器失效）类似于定时器,用完后废弃
    [self.session invalidateAndCancel];
}

// 下载已恢复
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

//开始下载
- (void)startDownLoad {
    
    [self.task resume];
}


//暂停下载
- (void)pauseDownLoad {
    
    [self.task suspend];
}

- (void)didDownloading:(DownLoading)downloading complete:(Complete)complete {
    
    //给block赋值
    self.complete = complete;
    self.downloading = downloading;
}

@end
