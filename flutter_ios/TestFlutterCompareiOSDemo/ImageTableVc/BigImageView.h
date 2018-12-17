//
//  BigImageView.h
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/27.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BigImageView : UIView
@property (strong, nonatomic) NSString *imageUrl;
+ (BigImageView *)show:(UIView *)superview url:(NSString *)url;
@end

