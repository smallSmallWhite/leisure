//
//  ReadDetailCell.m
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadDetailCell.h"

@interface ReadDetailCell ()

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIImageView *coverimg;

@end

@implementation ReadDetailCell

- (void)setCellWithModel:(id)model {
    
    ReadDetailModel *readDetailModel = model;
    
    self.title.text = readDetailModel.title;
    self.content.text = readDetailModel.content;
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:readDetailModel.coverimg]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
