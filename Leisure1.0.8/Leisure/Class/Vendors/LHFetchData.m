//
//  LHFetchData.m
//  Leisure
//
//  Created by 刘虎 on 16/4/18.
//  Copyright © 2016年 刘虎. All rights reserved.
//

#import "LHFetchData.h"
#import <MBProgressHUD.h>

@implementation LHFetchData

+ (void)postFetchDataWithUrlString:(NSString *)urlStr paramenters:(NSDictionary *)parameters success:(void (^)(id))success fail:(void (^)())fail view:(UIView *)view {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
        if (status <= 0) {
            
            mb.mode = MBProgressHUDModeText;
            mb.labelText = @"网络你要去哪儿？";
            [mb hide:YES afterDelay:2];
        } else {
            
            mb.mode = MBProgressHUDModeIndeterminate;
            mb.labelText = @"拼命请求中";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
                if (view) {
                    
                } else {
                    
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [mb removeFromSuperview];
                if (success) {
                
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [mb removeFromSuperview];
                if (fail) {
                    
                    fail();
                }
                
            }];
        }
    }];
}







+ (void)getFetchDataWithUrlString:(NSString *)urlStr paramenters:(NSDictionary *)parameters success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view {
    

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
        if (status <= 0) {
            
            mb.mode = MBProgressHUDModeText;
            mb.labelText = @"网络你要去哪儿？";
            [mb hide:YES afterDelay:2];
        } else {
            

            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                if (dic) {
                    
                    [mb removeFromSuperview];
                    if (success) {
                        
                        success(responseObject);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [mb removeFromSuperview];
                if (fail) {
                    
                    fail();
                }
            }];
        }
    }];
}






@end
