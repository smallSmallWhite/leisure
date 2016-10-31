//
//  LHFetchData.h
//  Leisure
//
//  Created by 刘虎 on 16/4/18.
//  Copyright © 2016年 刘虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHFetchData : NSObject

+ (void)postFetchDataWithUrlString:(NSString *)urlStr paramenters:(NSDictionary *)parameters success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view;

+ (void)getFetchDataWithUrlString:(NSString *)urlStr paramenters:(NSDictionary *)parameters success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view;

@end
