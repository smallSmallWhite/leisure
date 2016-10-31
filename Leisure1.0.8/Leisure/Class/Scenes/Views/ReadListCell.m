//
//  ReadListCell.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadListCell.h"

@implementation ReadListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellWithReadModel:(ReadModel *)model {
    
    self.name.text = [NSString stringWithFormat:@"%@ %@",model.name,model.enname];
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.coverimg.layer.cornerRadius = self.coverimg.frame.size.width/10;
    self.coverimg.layer.masksToBounds = YES;
}

@end
