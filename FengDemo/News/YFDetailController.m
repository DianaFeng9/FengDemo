//
//  YFDetailController.m
//  FengDemo
//
//  Created by 韩云凤 on 2020/4/15.
//  Copyright © 2020 韩云凤. All rights reserved.
//

#import "YFDetailController.h"
#import <WebKit/WebKit.h>

@interface YFDetailController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, copy) NSString *rul;
@end

@implementation YFDetailController

- (instancetype)initWithData:(NSString *)url {
    self = [super init];
    if (self) {
        self.rul = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 130)];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 10.0f);
    self.progressView.transform = transform;
    
    self.progressView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.rul]]] ;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"kkk");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
