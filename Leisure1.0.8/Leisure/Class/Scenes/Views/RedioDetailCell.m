//
//  RedioDetailCell.m
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailCell.h"

@interface RedioDetailCell ()

@property (strong, nonatomic) IBOutlet UIImageView *coverimg;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *musicVisit;

@end

@implementation RedioDetailCell

- (void)setCellWithModel:(id)model {
    
    RedioDetailModel *redioDetailModel = model;
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:redioDetailModel.coverimg]];
    self.title.text = redioDetailModel.title;
    self.musicVisit.text = redioDetailModel.musicVisit;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
