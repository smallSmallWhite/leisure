//
//  RedioDetailInfoPlaylistCell.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "RedioDetailInfoPlaylistCell.h"

@interface RedioDetailInfoPlaylistCell ()

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *uname;

@end

@implementation RedioDetailInfoPlaylistCell

- (void)setCellWithModel:(id)model {
    
    RedioDetailModel *redioDetailModel = model;
    self.uname.text = redioDetailModel.playInfoModel.authorinfo[@"uname"];
    self.title.text = redioDetailModel.playInfoModel.title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
