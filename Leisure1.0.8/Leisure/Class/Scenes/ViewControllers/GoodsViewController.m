//
//  GoodsViewController.m
//  Leisure
//
//  Created by xalo on 16/4/18.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "GoodsViewController.h"

@interface GoodsViewController ()

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
