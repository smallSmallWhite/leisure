//
//  DownLoadManage.m
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "DownLoadManage.h"

@implementation DownLoadManage

+ (DownLoadManage *)shareDownLoadManage {
    
    static DownLoadManage *downLoadManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        downLoadManage = [[DownLoadManage alloc] init];
    });
    return downLoadManage;
}

- (NSMutableDictionary *)dic {
    
    if (!_dic) {
        
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (DownLoad *)addDownLoadWithModel:(RedioDetailModel *)model {
    
    //判断当前下载的对象是否正在下载
    DownLoad *downLoad = self.dic[model.musicUrl];
    if (!downLoad) {
        
        downLoad = [[DownLoad alloc] initWithRedioDetailModel:model];
        downLoad.delegate = self;
        //开始下载
        [downLoad startDownLoad];
        [self.dic setValue:downLoad forKey:model.musicUrl];
    }
    return downLoad;
}

//根据URL找到一个downLoad
- (DownLoad *)findDownLoadWithModel:(RedioDetailModel *)model {
    
    return self.dic[model.musicUrl];
}

#pragma mark - DownLoadDelegate协议方法
- (void)didFinishDownloadWithUrl:(NSString *)url {
    
    [self.dic removeObjectForKey:url];
}

@end
