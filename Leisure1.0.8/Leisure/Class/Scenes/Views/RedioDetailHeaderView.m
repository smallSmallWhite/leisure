//
//  RedioDetailHeaderView.m
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailHeaderView.h"

@implementation RedioDetailHeaderView

- (void)setCellWithModel:(RedioDetailHeaderViewModel *)model {
    
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.uname.text = model.userinfo[@"uname"];
    self.desc.text = model.desc;
    self.musicvisitnum.text = [model.musicvisitnum stringValue];
}

@end
