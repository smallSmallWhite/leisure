//
//  DrawViewController.m
//  Leisure
//
//  Created by xalo on 16/4/21.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"bz1.jpg"];
    [self.view addSubview:imageView];
    [self.sideMenuViewController setPanGestureEnabled:YES];
    [self.sideMenuViewController setPanFromEdge:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
