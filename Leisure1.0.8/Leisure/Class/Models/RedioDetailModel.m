//
//  RedioDetailModel.m
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailModel.h"

@implementation RedioDetailModel

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        self.playInfo = [[RedioDetailPlayInfoModel alloc] init];
//    }
//    return self;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"RedioDetailModel中的key值出错了-----%@",key);
    if ([key isEqualToString:@"playInfo"]) {
        
        [self.playInfoModel setValuesForKeysWithDictionary:value];
    }
}

- (RedioDetailPlayInfoModel *)playInfoModel {
    
    if (!_playInfoModel) {
        
        _playInfoModel = [[RedioDetailPlayInfoModel alloc] init];
    }
    return _playInfoModel;
}

@end
