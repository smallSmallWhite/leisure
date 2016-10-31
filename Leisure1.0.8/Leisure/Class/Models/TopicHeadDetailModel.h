//
//  TopicHeadDetailModel.h
//  Leisure
//
//  Created by xalo on 16/4/23.
//  Copyright © 2016年 罗昭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicHeadDetailModel : NSObject

@property (retain, nonatomic)NSNumber *addtime;
@property (retain, nonatomic)NSString *addtime_f;
@property (retain, nonatomic)NSNumber *contentid;
@property (retain, nonatomic)NSString *html;
@property (retain, nonatomic)NSDictionary *counterList;
@property (retain, nonatomic)NSDictionary *groupInfo;
@property (retain, nonatomic)NSArray *imglist;
@property (retain, nonatomic)NSDictionary *shareinfo;
@property (retain, nonatomic)NSString *songid;
@property (retain, nonatomic)NSString *title;
@property (retain, nonatomic)NSDictionary *userinfo;
@property (assign, nonatomic)BOOL islike;
@property (assign, nonatomic)BOOL isfav;
@property (assign, nonatomic)BOOL isrecommend;

@end
