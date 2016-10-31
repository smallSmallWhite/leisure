//
//  DownloadCell.h
//  Leisure
//
//  Created by xalo on 16/4/26.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : BaseCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *progress;  //播放进度

@end
