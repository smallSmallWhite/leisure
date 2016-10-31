//
//  DownloadViewController.h
//  Leisure
//
//  Created by xalo on 16/4/24.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadViewController : UIViewController

+ (DownloadViewController *)shareDownloadViewController;
@property (strong, nonatomic)NSMutableArray *dataSource;          //正在下载
@property (strong, nonatomic)NSMutableArray *completeDataSource;  //完成下载
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *completeTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
