//
//  UITableView+EmptyData.m
//  Leisure
//
//  Created by xalo on 16/4/22.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (NSInteger)showMessage:(NSString *)title byDataSourceCount:(NSInteger)count {
    
    if (count == 0) {
        
        self.backgroundView = ({
            
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.alpha = 0.5;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
        //去掉tableView上的分割线
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSelectionStyleBlue;
    }
    return count;
}

@end
