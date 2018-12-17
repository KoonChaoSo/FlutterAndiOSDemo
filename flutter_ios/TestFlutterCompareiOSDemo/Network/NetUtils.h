//
//  NetUtils.h
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const HOST_URL;
extern NSString * const HOST_GANK;

extern NSString * const WAN_ARTICLE_LIST;
extern NSString * const WAN_WXARTICLE;
extern NSString * const WAN_WXARTICLE_LIST;
extern NSString * const GANK_WELFARE;


typedef void(^SuccessBlock)(NSDictionary *ret);
typedef void(^FailureBlock)(NSError *error);
@interface NetUtils : NSObject
- (NSURLSessionTask *)getMethodRequestUrl:(NSString *)urlStr success:(SuccessBlock)success failure:(FailureBlock)failureBlock;
- (NSURLSessionTask *)postMethodRequestUrl:(NSString *)urlStr success:(SuccessBlock)success failure:(FailureBlock)failureBlock;
@end

