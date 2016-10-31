//
//  TopicModel.m
//  Leisure
//
//  Created by xalo on 16/4/23.
//  Copyright © 2016年 罗昭. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"TopicModel中的key值出错了-----%@",key);
}

@end
