//
//  NetUtils.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "NetUtils.h"

NSString * const HOST_URL = @"http://www.wanandroid.com/";
NSString * const WAN_ARTICLE_LIST = @"article/list/";    //首页文章列表 http://www.wanandroid.com/article/list/0/json
                                                                // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60

NSString * const WAN_WXARTICLE = @"wxarticle/chapters/json"; //公众号
NSString * const WAN_WXARTICLE_LIST = @"wxarticle/list/";
NSString * const HOST_GANK = @"http://gank.io/api/";
NSString * const GANK_WELFARE = @"%E7%A6%8F%E5%88%A9/"; //福利

@implementation NetUtils


- (NSURLSessionTask *)_requestUrl:(NSString *)urlStr success:(SuccessBlock)success failure:(FailureBlock)failureBlock httpMethodType:(NSString *)methodType
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = methodType;
    
    NSURLSessionTask *sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error)
        {
            failureBlock(error);
        }
        else
        {
            NSHTTPURLResponse *httpRespone = (NSHTTPURLResponse *)response;
            NSError *jsonErr = nil;
            NSDictionary *initDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
            if (jsonErr)
            {
                failureBlock(jsonErr);
            }
            else if (httpRespone.statusCode >= 200 && httpRespone.statusCode < 300 )
            {
                if (initDict != nil)
                    success(initDict);
            }
        }
    }];
    
    [sessionTask resume];
    return sessionTask;
}

- (NSURLSessionTask *)getMethodRequestUrl:(NSString *)urlStr success:(SuccessBlock)success failure:(FailureBlock)failureBlock
{
    return [self _requestUrl:urlStr success:success failure:failureBlock httpMethodType:@"GET"];
}

- (NSURLSessionTask *)postMethodRequestUrl:(NSString *)urlStr success:(SuccessBlock)success failure:(FailureBlock)failureBlock
{
    return [self _requestUrl:urlStr success:success failure:failureBlock httpMethodType:@"POST"];
}

@end
