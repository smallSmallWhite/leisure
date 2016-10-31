//
//  WYXScrollPicture.m
//  ScrollViewDemo
//
//  Created by xalo on 16/4/14.
//  Copyright © 2016年 Mr.wangYongxu. All rights reserved.
//

#import "WYXScrollPicture.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#define kCount self.imageArr.count

@interface WYXScrollPicture ()<UIScrollViewDelegate>
/*!
 *  自动轮播,默认为YES(即自动播放)；
 */
@property(nonatomic, assign)BOOL isAuto;
@property (nonatomic, retain)UIScrollView* scrollView;//轮播图
@property (nonatomic, strong) UIImageView *currentImageView;//当前视图
@property (nonatomic, strong) UIImageView *nextImageView;//下一个视图
@property (nonatomic, strong) UIImageView *perImageView;//上一个视图

@property (nonatomic, assign)BOOL isDragging;//是否正在拖动
@property (nonatomic, strong)NSTimer *timer;//设置定时器，管理动画
@property (nonatomic, strong)UIPageControl *pageCrotroller;//页面管理

@end

@implementation WYXScrollPicture

@synthesize  imageArr = _imageArr;
//@synthesize isNotAuto = _isNotAuto;
//@synthesize durationOfScroll = _durationOfScroll;

//小白点的懒加载
-(UIPageControl *)pageCrotroller{
    
    if (!_pageCrotroller) {
        _pageCrotroller = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kHeight-40, kWidth, 40)];
//        _pageCrotroller.numberOfPages = 0;//注意小白点的个数与图片数量相一致。
        _pageCrotroller.currentPage = 0;//初值为0，即一张图片都没有，在得到图片后给其赋值。
        _pageCrotroller.pageIndicatorTintColor = [UIColor grayColor];
        _pageCrotroller.currentPageIndicatorTintColor = [UIColor orangeColor];
        [_pageCrotroller setEnabled:NO];
    }
    return _pageCrotroller;
}
//上一张图片懒加载
-(UIImageView *)perImageView{
    
    if (!_perImageView) {
        _perImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    }
    return _perImageView;
}
//当前页面懒加载
-(UIImageView *)currentImageView{
    
    if (!_currentImageView) {
        _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
       
    }
    return _currentImageView;
}
//下一张图片懒加载
-(UIImageView *)nextImageView{
    
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*2, 0, kWidth, kHeight)];
    }
    return _nextImageView;
}
//初始化scrollview，并设置一系列参数
-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setContentSize:CGSizeMake(kWidth*3, kHeight)];//设置scrollView
        [_scrollView setPagingEnabled:YES];//设置滑动效果
        [_scrollView setContentOffset:CGPointMake(kWidth, 0)];
        [_scrollView setBounces:NO];
        [_scrollView setDelegate:self];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}
//扩展imageArr的set方法，使其得到图片后进行一系列的操作。
-(void)setImageArr:(NSArray *)imageArr{
    
    @synchronized(self) {
        _imageArr = [[NSMutableArray alloc] initWithArray:imageArr];
        self.pageCrotroller.numberOfPages = _imageArr.count;
        self.pageCrotroller.currentPage = 0;
        self.currentImageView.image = _imageArr[self.pageCrotroller.currentPage];
        if (_isAuto) {
            if (!self.timer||!self.timer.isValid) {
                [self intervalOfScroll:2.0];//默认播放时间为2.0
            }
        }
    }
}

//设置定时器，参数可以决定轮播时间间隔，或者不轮播
-(void)intervalOfScroll:(NSTimeInterval)time{
    
    if (time == -1) {//判断是否允许轮播
        _isAuto = NO;//不允许轮播，即是销毁定时器后，不需要再初始化新的定时器了;
    }else{
        _isAuto = YES;
    }
    if (self.timer != nil) {
        [self destoryTimer];//自己写的销毁定时器的方法
    }
    if (!_isAuto) {
        return;
    }
    if (!self.timer||!self.timer.isValid) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
}


//扩展初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _isAuto = YES;//默认可以轮播
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.perImageView];
        [self.scrollView addSubview:self.currentImageView];
        [self.scrollView addSubview:self.nextImageView];
        [self addSubview:self.pageCrotroller];
       
    }
    return self;
}


//定时器效果
-(void)timerAction{
    [self.scrollView setContentOffset:CGPointMake(2*kWidth, 0) animated:YES];
}



//触摸的方法
-(void)tapScrollView{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(WYXScrollPictureDidTap:)]) {
        NSInteger index = self.pageCrotroller.currentPage;
        [self.delegate WYXScrollPictureDidTap:index];
    }
}
#pragma mark - <UIScrollerViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.imageArr.count == 0||!self.imageArr) {
        return;
    }
    static NSInteger i = 0;//存储当前展示的图片
    self.pageCrotroller.currentPage = i;
    NSInteger count = self.imageArr.count;
    float offset_x = [self.scrollView contentOffset].x;//当前scrollView的滑动坐标
    
//    self.currentImageView.image = [self.imageArr objectAtIndex:i];
    //加载上一张和下一张图片
    if (self.perImageView.image == nil || self.nextImageView.image == nil) {
        self.perImageView.image = [self.imageArr objectAtIndex: i==0?count-1:i-1];
        self.nextImageView.image = [self.imageArr objectAtIndex:i==count-1?0:i+1];
    }
    if (offset_x == 0) {
        [self.scrollView setContentOffset:CGPointMake(kWidth, 0)];
        self.currentImageView.image = self.perImageView.image;
        self.perImageView.image = nil;
        i = i==0?count-1:i-1;
        self.pageCrotroller.currentPage = i;
    }
    if (offset_x == kWidth*2) {
        [self.scrollView setContentOffset:CGPointMake(kWidth, 0)];
        self.currentImageView.image = self.nextImageView.image;
        self.nextImageView.image = nil;
        i = i==count-1?0:i+1;
        self.pageCrotroller.currentPage = i;
    }
}

//开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
//结束拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self isAuto]) {
        if (self.timer.isValid) {
            [self.timer setFireDate:[NSDate dateWithTimeInterval:2.0 sinceDate:[NSDate date]]];
        }
        
    }
}

//销毁并置空定时器
-(void)destoryTimer{
    if (self.timer.isValid){//避免在多次更改其值得时候，初始化多个定时器，所以进来的时候先判断是否有定时器生效
        [self.timer invalidate];//销毁定时器后，定时器不为空，还需手动置为空
    }
    self.timer = nil;
}

-(void)dealloc{
    [self destoryTimer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
