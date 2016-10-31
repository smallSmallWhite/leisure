//
//  DataManager.m
//  Leisure
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "DataManager.h"

/**
 * NSManagedObjectContext         //用来关联上下文的一切的操作，由他来执行，相当于秘书职位
 * NSManagedObjectModel           //关联数据库模型
 * NSPersistentStoreCoordinator   //将coreData的数据存入本地，简称数据持久化助理
 */

@implementation DataManager

+ (DataManager *)shareDataManager {
    
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataManager = [[DataManager alloc] init];
    });
    return dataManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //关联上下文
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSPrivateQueueConcurrencyType)];
        //关联表模型
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"]];
        //初始化数据持久化助理
        NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        //数据存储路径
        NSString *doucumentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        //储存的文件名
        NSString *fileName = [doucumentPath stringByAppendingPathComponent:@"model.sqlite"];
        [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:fileName] options:nil error:nil];
        self.context.persistentStoreCoordinator = store;
    }
    return self;
}

#pragma mark - 收藏
//增
- (void)insertData:(ReadDetailModel *)model {
    
    //先判断收藏是否存在
    if (![self isContaintDate:model]) {
        
        //创建一个实体
        CollectionModel *collectionModel = [NSEntityDescription insertNewObjectForEntityForName:@"CollectionModel" inManagedObjectContext:self.context];
        collectionModel.name = model.title;
        collectionModel.content = model.content;
        collectionModel.coverimg = model.coverimg;
        collectionModel.typeID = [NSString stringWithFormat:@"%@",model.typeID];
        //保存
        [self.context save:nil];
        [self creadteAlerViewWithTitle:@"提示" message:@"收藏成功"];
    }
    else {
        [self creadteAlerViewWithTitle:@"友情提示" message:@"已经被收藏"];
    }
}

//删
- (void)deleteData:(ReadDetailModel *)model {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CollectionModel" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"typeID = %@", [NSString stringWithFormat:@"%@",model.typeID]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    for (CollectionModel *model in fetchedObjects) {
        
        [self.context deleteObject:model];
        [self.context save:nil];
    }
}

//查询所有数据
- (NSArray *)selectedData {
    
    //创建请求体
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CollectionModel"];
    return [self.context executeFetchRequest:request error:nil];
}

//查询某个数据
- (BOOL)isContaintDate:(ReadDetailModel *)data {
    
    //创建请求体
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CollectionModel"];
    //谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"typeID = %@",[NSString stringWithFormat:@"%@",data.typeID]];
    request.predicate = predicate;
    NSArray *array = [self.context executeFetchRequest:request error:nil];
    if (array.count > 0) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}


#pragma mark - 下载
//增
- (void)insertDownloadData:(RedioDetailModel *)model filePath:(NSString *)filePath {
    
    //创建一个实体
    DownloadModel *downloadModel = [NSEntityDescription insertNewObjectForEntityForName:@"DownloadModel" inManagedObjectContext:self.context];
    downloadModel.name = model.playInfoModel.authorinfo[@"uname"];
    downloadModel.title = model.title;
    downloadModel.coverimg = model.coverimg;
    downloadModel.filePath = filePath;
    //保存
    [self.context save:nil];
    [self creadteAlerViewWithTitle:@"提示" message:@"下载成功"];
}

//删
- (void)deleteDownloadData:(DownloadModel *)model {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DownloadModel" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"filePath = %@", [NSString stringWithFormat:@"%@",model.filePath]];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    for (DownloadModel *model in fetchedObjects) {
        
        [self.context deleteObject:model];
        [self.context save:nil];
    }
}

//查询所有数据
- (NSArray *)selectedDownloadData {
    
    //创建请求体
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DownloadModel"];
    return [self.context executeFetchRequest:request error:nil];
}

//警示框
- (void)creadteAlerViewWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
