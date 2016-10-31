//
//  RedioDetailInfoViewController.h
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedioDetailInfoViewController : UIViewController

@property (strong, nonatomic)NSMutableArray *dataSources;   //储存上个界面的数据
@property (assign, nonatomic)NSInteger indexPath;       //记录点击cell

//为了保证每一次进来都是统一播放源，即时切出此界面，界面上的数据依然在保持运行
+ (RedioDetailInfoViewController *)showRedioDetailInfoViewController;

@end
