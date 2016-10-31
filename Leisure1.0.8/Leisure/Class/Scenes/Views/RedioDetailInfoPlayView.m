//
//  RedioDetailInfoPlayView.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailInfoPlayView.h"

@interface RedioDetailInfoPlayView ()

@end

@implementation RedioDetailInfoPlayView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self layoutIfNeeded];
    self.coverimg.layer.cornerRadius = self.coverimg.frame.size.height/4;
    self.coverimg.layer.masksToBounds = YES;
}

- (void)setCellWithModel:(RedioDetailModel *)model {
    
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:model.playInfoModel.imgUrl]];
    self.title.text = model.playInfoModel.title;
}


@end
