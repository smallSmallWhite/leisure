//
//  TopicDetailHeaderView.m
//  Leisure
//
//  Created by xalo on 16/4/25.
//  Copyright © 2016年 pengma. All rights reserved.
//

#import "TopicDetailHeaderView.h"

@interface RedioDetailInfoContent () <UIWebViewDelegate>

@end

@implementation TopicDetailHeaderView

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
      "document.getElementsByTagName('head')[0].appendChild(script);",self.frame.size.width-20]
     ];
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

@end
