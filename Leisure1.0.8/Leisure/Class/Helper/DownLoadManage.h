//
//  DownLoadManage.h
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadManage : NSObject <DownLoadDelegate>

@property (strong, nonatomic)NSMutableDictionary *dic;  //用来记录当前正在下载的对象

+ (DownLoadManage *)shareDownLoadManage;
/**
 * 根据model下载
 */
- (DownLoad *)addDownLoadWithModel:(RedioDetailModel *)model;
/**
 * 根据model找到一个downLoad
 */
- (DownLoad *)findDownLoadWithModel:(RedioDetailModel *)model;

@end
