//
//  ReadListCell.h
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadListCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *coverimg;
@property (strong, nonatomic) IBOutlet UILabel *name;

//根据传进来的model来设置传进来的属性
- (void)setCellWithReadModel:(ReadModel *)model;

@end
