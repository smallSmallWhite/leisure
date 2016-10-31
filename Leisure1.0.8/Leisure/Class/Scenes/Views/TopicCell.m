//
//  TopicCell.m
//  Leisure
//
//  Created by xalo on 16/4/24.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "TopicCell.h"

@interface TopicCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *participants;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *contentImg;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel; //评论
@property (strong, nonatomic) IBOutlet UILabel *praiseLabel;   //赞
@property (strong, nonatomic) IBOutlet UILabel *contentTwo;

@end

@implementation TopicCell

- (void)setCellWithModel:(id)model {
    
    TopicModel *topicModel = model;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:topicModel.userinfo[@"icon"]]];
    self.userName.text = topicModel.userinfo[@"uname"];
    self.participants.text = [NSString stringWithFormat:@"%@人参与",[topicModel.counterList[@"view"] stringValue]];
    self.title.text = topicModel.title;
    self.commentsLabel.text = [topicModel.counterList[@"comment"] stringValue];
    self.praiseLabel.text = [topicModel.counterList[@"like"] stringValue];
    
    if (topicModel.coverimg.length == 0) {
        
        self.content.hidden = YES;
        self.contentImg.hidden = YES;
        self.contentTwo.hidden = NO;
        self.contentTwo.text = topicModel.content;
    }
    else {
        
        self.content.hidden = NO;
        self.contentImg.hidden = NO;
        self.contentTwo.hidden = YES;
        self.content.text = topicModel.content;
        [self.contentImg sd_setImageWithURL:[NSURL URLWithString:topicModel.coverimg]];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
