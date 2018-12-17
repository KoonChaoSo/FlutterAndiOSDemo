//
//  NewsViewController.h
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"

@interface NewsViewController : UIViewController <ViewControllerProtocol>
@property (strong, nonatomic) NSArray *articleTitleArray;

@end
