//
//  TopicCell.h
//  Leisure
//
//  Created by xalo on 16/4/24.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : BaseCell

@property (strong, nonatomic) IBOutlet UIButton *forwarding;   //转发
@property (strong, nonatomic) IBOutlet UIButton *comments;     //评论
@property (strong, nonatomic) IBOutlet UIButton *praise;       //赞

@end
