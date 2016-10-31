//
//  DownLoad.h
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RedioDetailModel;
// 正在下载的block
typedef void(^DownLoading)(float progress);
// 下载完成后的block
typedef void(^Complete)(NSString *filePath,RedioDetailModel *model);

@protocol DownLoadDelegate <NSObject>

/**
 * 下载完成后执行的代理方法,主要让单例移除下载完成后的对象
 */
- (void)didFinishDownloadWithUrl:(NSString *)url;

@end

@interface DownLoad : NSObject

- (instancetype)initWithRedioDetailModel:(RedioDetailModel *)model;

@property (strong, nonatomic)RedioDetailModel *model;    //保存正在下载的对象
@property (weak, nonatomic)id<DownLoadDelegate> delegate;
// 完成下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location;

// 正在下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;

// 下载已恢复
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes;

// 开始下载
- (void)startDownLoad;

// 暂停下载
- (void)pauseDownLoad;

/**
 * 正在下载时执行代码块，下载完成时执行代码块
 *
 * @param downloading 正在下载
 * @param complete    下载完成
 */
- (void)didDownloading:(DownLoading)downloading complete:(Complete)complete;

@end
