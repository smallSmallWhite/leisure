//
//  ReadDetailInfoViewController.h
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadDetailInfoViewController : UIViewController

@property (strong, nonatomic)NSNumber *contentId;      //文章的ID
@property (strong, nonatomic)ReadDetailModel *model;   //传进来一个model为了收藏分享

@end
