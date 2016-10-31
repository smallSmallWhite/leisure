//
//  TopicModel.h
//  Leisure
//
//  Created by xalo on 16/4/23.
//  Copyright © 2016年 罗昭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (retain, nonatomic)NSNumber *addtime;       //添加时间
@property (retain, nonatomic)NSString *addtime_f;     //距上次时间
@property (retain, nonatomic)NSString *content;       //内容
@property (retain, nonatomic)NSNumber *contentid;     //话题id
@property (retain, nonatomic)NSDictionary *counterList;       //话题状态
@property (retain, nonatomic)NSString *coverimg;      //图片网址
@property (assign, nonatomic)BOOL ishot;      //是否精品
@property (retain, nonatomic)NSString *songid;        //音乐id
@property (assign, nonatomic)BOOL isrecommend;            //位置
@property (retain, nonatomic)NSString *title;         //标题
@property (retain, nonatomic)NSDictionary *userinfo;      //作者信息

@end
