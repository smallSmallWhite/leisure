//
//  RedioDetailModel.h
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedioDetailPlayInfoModel.h"

@interface RedioDetailModel : NSObject

@property (strong, nonatomic)RedioDetailPlayInfoModel *playInfoModel;
@property (strong, nonatomic)NSString *coverimg;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *tingid;
@property (strong, nonatomic)NSString *musicVisit;
@property (strong, nonatomic)NSString *musicUrl;
@property (strong, nonatomic)NSString *isnew;



@end
