//
//  ReadModel.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"ReadModel中的key值出错了-----%@",key);
}

@end
