//
//  LHICarouselTools.m
//  DemoText
//
//  Created by 刘虎 on 16/4/4.
//  Copyright © 2016年 刘虎. All rights reserved.
//

#import "LHICarouselTools.h"
#import "iCarousel.h"
#import <UIImageView+WebCache.h>

#define kTimeInterval 2 //旋转间隙时间（秒）

@interface LHICarouselTools ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,retain)NSTimer *time;
@property (nonatomic,retain)iCarousel *carouse;
@property (nonatomic, retain)NSArray *photosArr;//图片或者图片的URL
@property (nonatomic, assign)BOOL isURLLoadImage;//是否使用URL加载图片

@end


@implementation LHICarouselTools

- (instancetype)initWithFrame:(CGRect)frame photosArray:(NSArray<UIImage *> *)photosArray {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.isURLLoadImage = NO;
        self.photosArr = photosArray;
        self.carouse = [[iCarousel alloc] initWithFrame:frame];
        [self setCarouseAttributes];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame photosURLArray:(NSArray<NSURL *> *)photosURLArray {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.isURLLoadImage = YES;
        self.photosArr = photosURLArray;
        self.carouse = [[iCarousel alloc] initWithFrame:frame];
        [self setCarouseAttributes];
    }
    return self;
}

#pragma mark - 设置旋转视图的属性
- (void)setCarouseAttributes {
    
    self.backgroundColor = [UIColor whiteColor];
    self.carouse.delegate = self;
    self.carouse.dataSource = self;
    [self addSubview:self.carouse];
    self.carouse.type = iCarouselTypeCoverFlow2;
    self.carouse.bounceDistance = 0.2f;
    self.time = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(playPhotosTimerAction) userInfo:nil repeats:YES];
}

#pragma mark - 定时器回调
- (void)playPhotosTimerAction {
    
    [self.carouse scrollToItemAtIndex:self.carouse.currentItemIndex+1 animated:YES];
}

#pragma mark - 旋转视图的代理方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return self.photosArr.count;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    switch (option) {
        case iCarouselOptionWrap:{
            return YES;
        }
        case iCarouselOptionSpacing:{
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:{
            if (self.carouse.type == iCarouselTypeCustom) {
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 3*self.frame.size.height/2, self.frame.size.height)];
    if (self.isURLLoadImage) {
        [imageView sd_setImageWithURL:self.photosArr[index] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] options:SDWebImageRefreshCached];
    } else {
        imageView.image = self.photosArr[index];
    }
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 3*self.frame.size.height/2, self.frame.size.height)];
    [view addSubview:imageView];
    return view;
}

@end
