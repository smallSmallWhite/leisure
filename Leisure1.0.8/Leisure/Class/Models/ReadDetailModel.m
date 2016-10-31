//
//  ReadDetailModel.m
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadDetailModel.h"

@implementation ReadDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"ReadDetailModel中的key值出错了-----%@",key);
    //如果遇到没有被声明的key值“id”，就把id的值赋给typeID
    if ([key isEqualToString:@"id"]) {
        
        self.typeID = value;
    }
}

@end
