//
//  DownloadModel+CoreDataProperties.h
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DownloadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownloadModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *filePath;
@property (nullable, nonatomic, retain) NSString *coverimg;

@end

NS_ASSUME_NONNULL_END
