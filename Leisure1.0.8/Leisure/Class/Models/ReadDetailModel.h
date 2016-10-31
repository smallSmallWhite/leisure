//
//  ReadDetailModel.h
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDetailModel : NSObject

@property (nonatomic,strong)NSString *name;     //名字
@property (nonatomic,strong)NSString *title;    //标题
@property (nonatomic,strong)NSString *coverimg; //背景图
@property (nonatomic,strong)NSString *content;  //内容
@property (nonatomic,strong)NSNumber *typeID;     //编号

@end
