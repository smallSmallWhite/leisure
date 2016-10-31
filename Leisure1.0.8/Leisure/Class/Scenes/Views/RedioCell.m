//
//  RedioCell.m
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioCell.h"

@interface RedioCell ()

@property (strong, nonatomic) IBOutlet UIImageView *coverimg;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *userinfo;
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UILabel *desc;

@end

@implementation RedioCell

- (void)setCellWithModel:(id)model {
    
    RedioModel *redioModel = model;
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:redioModel.coverimg]];
    self.title.text = redioModel.title;
    self.userinfo.text = redioModel.userinfo[@"uname"];
    self.desc.text = redioModel.desc;
    self.count.text = [NSString stringWithFormat:@"%ld",[redioModel.count integerValue]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
