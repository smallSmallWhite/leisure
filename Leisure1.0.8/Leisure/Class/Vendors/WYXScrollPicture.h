//
//  WYXScrollPicture.h
//  ScrollViewDemo
//
//  Created by xalo on 16/4/14.
//  Copyright © 2016年 Mr.wangYongxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchScrollView)(NSInteger index);

@protocol WYXScrollPictureDelegate <NSObject>

/*!
 *  点击轮播图执行的代理方法
 *
 *  @param index 被点击的图片在数组中的位置
 */
-(void)WYXScrollPictureDidTap:(NSInteger) index;

@end

@interface WYXScrollPicture : UIView

/*!
 *  传入需要轮播的图片
 */
@property(nonatomic, retain)NSArray* imageArr;
@property(nonatomic, assign)id<WYXScrollPictureDelegate>delegate;//代理
/*!
 *  轮播间隔,设置为-1,即为不自动轮播；
 */
-(void)intervalOfScroll:(NSTimeInterval)time;


@end
