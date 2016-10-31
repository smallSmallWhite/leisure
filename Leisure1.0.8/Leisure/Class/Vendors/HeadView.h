//
//  HeadView.h
//  newsApp
//
//  Created by zhupeng on 16/4/17.
//  Copyright © 2016年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface HeadView : UIView

@property (nonatomic ,retain)iCarousel *carousel;

@property (nonatomic ,retain)NSArray *imageArray;

@property (nonatomic ,retain) UILabel *textLabel;

@property (nonatomic,retain) NSTimer *timer;

-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)ImageArr;

//将视图转换为UIImage格式
- (UIImage*) imageWithUIView:(UIView*) view;

@end
