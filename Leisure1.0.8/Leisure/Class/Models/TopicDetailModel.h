//
//  TopicDetailModel.h
//  Leisure
//
//  Created by xalo on 16/4/23.
//  Copyright © 2016年 罗昭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicDetailModel : NSObject

@property (retain, nonatomic)NSString *addtime_f;
@property (retain, nonatomic)NSNumber *cmtnum;
@property (retain, nonatomic)NSString *content;
@property (retain, nonatomic)NSNumber *contentid;
@property (retain, nonatomic)NSString *coverimg;
@property (retain, nonatomic)NSString *coverimg_wh;
@property (retain, nonatomic)NSArray *imglist;
@property (assign, nonatomic)BOOL isdel;
@property (assign, nonatomic)BOOL islike;
@property (retain, nonatomic)NSNumber *likenum;
@property (retain, nonatomic)NSDictionary *userinfo;

@end
