//
//  YFDetailController.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/15.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFDetailController.h"
#import <WebKit/WebKit.h>

@interface YFDetailController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation YFDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://time.geekbang.org"]]];
}



@end
