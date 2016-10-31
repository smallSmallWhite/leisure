//
//  RedioModel.h
//  Leisure
//
//  Created by xalo on 16/4/19.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedioModel : NSObject

@property (strong, nonatomic)NSNumber *radioid;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *coverimg;
@property (strong, nonatomic)NSDictionary *userinfo;
@property (strong, nonatomic)NSNumber *count;
@property (strong, nonatomic)NSString *desc;
@property (strong, nonatomic)NSString *isnew;

@end
