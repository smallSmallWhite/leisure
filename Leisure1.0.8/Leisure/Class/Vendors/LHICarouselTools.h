//
//  LHICarouselTools.h
//  DemoText
//
//  Created by 刘虎 on 16/4/4.
//  Copyright © 2016年 刘虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHICarouselTools : UIView


//旋转方式
//self.carouse.type = iCarouselTypeCoverFlow2;   改变.m中的这句代码可以改变旋转方式
/*

 iCarouselTypeLinear = 0,
 iCarouselTypeRotary,
 iCarouselTypeInvertedRotary,
 iCarouselTypeCylinder,
 iCarouselTypeInvertedCylinder,
 iCarouselTypeWheel,
 iCarouselTypeInvertedWheel,
 iCarouselTypeCoverFlow,
 iCarouselTypeCoverFlow2,
 iCarouselTypeTimeMachine,
 iCarouselTypeInvertedTimeMachine,
 iCarouselTypeCustom
 
*/

//需要使用两个第三方
//#import "iCarousel.h"
//#import <UIImageView+WebCache.h>

//根据一组视图初始化一个木马旋转视图
- (instancetype)initWithFrame:(CGRect)frame photosArray:(NSArray<UIImage *> *)photosArray;

//根据一组视图的URL初始化一个木马旋转视图
- (instancetype)initWithFrame:(CGRect)frame photosURLArray:(NSArray<NSURL *> *)photosURLArray;

@end
