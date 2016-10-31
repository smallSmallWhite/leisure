//
//  RedioDetailPlayInfoModel.h
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedioDetailPlayInfoModel : NSObject

@property (strong, nonatomic)NSDictionary *userinfo;
@property (strong, nonatomic)NSDictionary *authorinfo;
@property (strong, nonatomic)NSDictionary *shareinfo;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *imgUrl;
@property (strong, nonatomic)NSString *musicUrl;
@property (strong, nonatomic)NSString *tingid;
@property (strong, nonatomic)NSString *webview_url;
@property (strong, nonatomic)NSString *ting_contentid;
@property (strong, nonatomic)NSString *sharepic;
@property (strong, nonatomic)NSString *sharetext;
@property (strong, nonatomic)NSString *shareurl;

@end
