//
//  DataManager.h
//  Leisure
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadModel;
@class ReadDetailModel;
@class RedioDetailModel;
@interface DataManager : NSObject

+ (DataManager *)shareDataManager;
@property (strong, nonatomic)NSManagedObjectContext *context;   //关联上下文
/**
 * 收藏存储
 */
- (void)insertData:(ReadDetailModel *)model;
- (NSArray *)selectedData;
- (void)deleteData:(ReadDetailModel *)model;


/**
 * 下载存储
 */
- (void)insertDownloadData:(RedioDetailModel *)model filePath:(NSString *)filePath;
- (NSArray *)selectedDownloadData;
- (void)deleteDownloadData:(DownloadModel *)model;
@end
