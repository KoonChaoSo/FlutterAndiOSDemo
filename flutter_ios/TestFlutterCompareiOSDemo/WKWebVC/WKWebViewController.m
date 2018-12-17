//
//  WKWebViewController.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()<WKNavigationDelegate>

@end

@implementation WKWebViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.wkwebView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.wkwebView.navigationDelegate = self;
        [self.view addSubview:self.wkwebView];
    }
    return self;
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    UIEdgeInsets insets = self.view.safeAreaInsets;
    [self.wkwebView setFrame:CGRectMake(0, insets.top + self.wkwebView.frame.origin.y, self.wkwebView.frame.size.width, self.wkwebView.frame.size.height + insets.bottom)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential*card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}


@end
