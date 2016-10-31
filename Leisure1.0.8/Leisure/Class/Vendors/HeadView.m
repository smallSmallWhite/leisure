//
//  HeadView.m
//  newsApp
//
//  Created by zhupeng on 16/4/17.
//  Copyright © 2016年 朱鹏. All rights reserved.
//

#import "HeadView.h"
#import "FXImageView.h"

#define kWIDTH  self.frame.size.width
#define kHEIGHT  self.frame.size.height
@interface HeadView () <iCarouselDataSource,iCarouselDelegate>



@property (nonatomic ,retain) NSMutableArray *ImageArr;

@end

@implementation HeadView

-(iCarousel *)carousel{
    
    if (!_carousel) {
        
        _carousel =[[iCarousel alloc]initWithFrame:self.frame];
        _carousel.dataSource =self;
        _carousel.delegate =self;
//        _carousel.pagingEnabled =YES;
    }
    return _carousel;
}

-(NSMutableArray *)ImageArr{
    if (!_ImageArr) {
        
        _ImageArr =[[NSMutableArray alloc]init];
        
        for (int i=0; i<10; i++) {
            
            UIImage *iamge =[UIImage imageNamed:[NSString stringWithFormat:@"fengjin%d.png",i]];
            [_ImageArr addObject:iamge];
        }
    }
    return _ImageArr;
}


-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)ImageArr{
    
     self =[super initWithFrame:frame];
    if (self) {
//       创建背景图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        UIImage *iamge =[UIImage imageNamed:@"background.png"];
        imageView.image =iamge;
         [self addSubview:imageView];
//赋值
        self.imageArray = ImageArr;
//     添加显示label
       self.textLabel  =[[UILabel alloc]initWithFrame:CGRectMake(10, kHEIGHT-40, kWIDTH-20, 50)];
         self.textLabel.textAlignment =NSTextAlignmentCenter;
                 self.textLabel.textColor =[UIColor whiteColor];
        self.textLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview: self.textLabel];
        [self addSubview:self.carousel];
        self.timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark - 定时器回调
-(void)timerAction{
    
    NSInteger index = self.carousel.currentItemIndex;
    index+=1;
    if (index == self.imageArray.count+1) {
        
        index = 0;
    }
    [self.carousel scrollToItemAtIndex:index animated:YES];
}


#pragma mark - 旋转木马的代理方法

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return self.imageArray.count;
    
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    
    
    FXImageView *imageView =[[FXImageView alloc]initWithFrame:CGRectMake(kWIDTH/7, kHEIGHT/7, kWIDTH-(kWIDTH/7*2), kHEIGHT-(kHEIGHT/7*2) )];
    
    imageView.image = [self.imageArray objectAtIndex:index];

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.asynchronous = YES;
    imageView.reflectionScale = 0.5f;
    imageView.reflectionAlpha = 0.25f;
    imageView.reflectionGap = 10.0f;
    imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
    imageView.shadowBlur = 5.0f;
    imageView.cornerRadius = 10.0f;
   
    return imageView;
    
}

//将视图转换为UIImage格式
- (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option)
    {
        case iCarouselOptionWrap://这个case里面返回是否循环
        {
            
            return YES;
        }
        case iCarouselOptionSpacing://返回每个item间的距离
        {
            //add a bit of spacing between the item views
            return value * 1;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
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

@end
