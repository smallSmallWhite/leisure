//
//  UITableView+EmptyData.h
//  Leisure
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

/**
 * 根据数据源的个数显示内容
 */
- (NSInteger)showMessage:(NSString *)title byDataSourceCount:(NSInteger)count;

@end
