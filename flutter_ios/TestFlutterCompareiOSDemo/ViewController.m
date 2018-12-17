//
//  ViewController.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/26.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerProtocol.h"
@interface ViewController () <UITabBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [[self getVcWithTitle:item.title] loadData];
}

- (UIViewController <ViewControllerProtocol>*)getVcWithTitle:(NSString *)title
{
    UIViewController <ViewControllerProtocol>* (^block)(NSString *vcName) = ^(NSString *vcName){
        
        UIViewController <ViewControllerProtocol>* targetVc = nil;
        for (UIViewController *vc in self.viewControllers)
        {
            if ([vc isKindOfClass:NSClassFromString(vcName)] && [vc conformsToProtocol:@protocol(ViewControllerProtocol)])
            {
                targetVc = (UIViewController <ViewControllerProtocol>*)vc;
            }
        }
        return targetVc;
    };
    
    if ([title isEqualToString:@"首页"])
    {
        return block(@"NewsViewController");
    }
    else if ([title isEqualToString:@"单列图片"])
    {
        return block(@"SingleImageViewController");
    }
    else if ([title isEqualToString:@"双列图片"])
    {
        return block(@"DoubleImageViewController");
    }
    return nil;
}
@end
