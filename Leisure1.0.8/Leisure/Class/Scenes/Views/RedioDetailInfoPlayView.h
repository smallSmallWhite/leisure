//
//  RedioDetailInfoPlayView.h
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedioDetailInfoPlayView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *coverimg;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (void)setCellWithModel:(RedioDetailModel *)model;

@end
