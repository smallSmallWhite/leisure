//
//  RedioDetailHeaderView.h
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedioDetailHeaderView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *coverimg;
@property (strong, nonatomic) IBOutlet UILabel *uname;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UILabel *musicvisitnum;

- (void)setCellWithModel:(RedioDetailHeaderViewModel *)model;

@end
