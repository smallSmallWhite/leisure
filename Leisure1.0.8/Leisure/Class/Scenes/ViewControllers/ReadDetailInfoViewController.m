//
//  ReadDetailInfoViewController.m
//  Leisure
//
//  Created by xalo on 16/4/20.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "ReadDetailInfoViewController.h"

@interface ReadDetailInfoViewController () <UIWebViewDelegate>

@property (strong, nonatomic)UIWebView *webView;
@property (strong, nonatomic)NSMutableDictionary *parameter;

@end

@implementation ReadDetailInfoViewController

- (UIWebView *)webView {
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kWidths, kHeights)];
        _webView.paginationMode = UIWebPaginationModeTopToBottom;
    }
    return _webView;
}

- (NSMutableDictionary *)parameter {
    
    if (!_parameter) {
        
        _parameter = [NSMutableDictionary dictionaryWithDictionary:@{@"contentid":[NSString stringWithFormat:@"%@",self.contentId]}];
    }
    return _parameter;
}

#pragma mark - 数据请求
//根据网址请求数据
- (void)fetchSourceDataWithUrl:(NSString *)url parameter:(NSMutableDictionary *)parameter {
    
    [LHFetchData postFetchDataWithUrlString:url paramenters:parameter success:^(id data) {
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        NSString *htmlStr = dic[@"data"][@"html"];
//        NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", htmlStr];
//        [self.webView loadHTMLString:htmlcontent baseURL:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *html = [self filterHTML:dic[@"data"][@"html"]];
        [self.webView loadHTMLString:html baseURL:nil];
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    } fail:^{
        
        NSLog(@"0");
    } view:self.view];
}

- (NSString *)filterHTML:(NSString *)str
{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = @"";
    while(![scanner isAtEnd]) {
        
        [scanner scanUpToString:@"<span>pengma: " intoString:nil];
        [scanner scanUpToString:@"</span>&nbsp" intoString:&text];
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@</span>&nbsp",text] withString:@"作者: pengma"];
    }
    return str;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [_webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"var script = document.createElement('script');"
      "script.type = 'text/javascript';"
      "script.text = \"function ResizeImages() { "
      "var myimg,oldwidth;"
      "var maxwidth = %f;"
      "for(i=0;i <document.images.length;i++){"
      "myimg = document.images[i];"
      "if(myimg.width > maxwidth){"
      "oldwidth = myimg.width;"
      "myimg.width = maxwidth;"
      "}"
      "}"
      "}\";"
      "document.getElementsByTagName('head')[0].appendChild(script);",kWidths-20]
     ];
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}


#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchSourceDataWithUrl:kReadDetailInfoUel parameter:self.parameter];
    [self createRightBarItems];
}

//创建收藏分享按钮
- (void)createRightBarItems {
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:(UIBarButtonItemStyleDone) target:self action:@selector(collectionAction:)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItems = @[shareItem,collectionItem];
}

//收藏事件
- (void)collectionAction:(UIBarButtonItem *)sender {
    
    [[DataManager shareDataManager] insertData:self.model];
}

//分享事件
- (void)shareAction:(UIBarButtonItem *)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
