//
//  BigImageView.m
//  TestFlutterCompareiOSDemo
//
//  Created by 苏冠超[产品技术中心] on 2018/11/27.
//  Copyright © 2018 苏冠超[产品技术中心]. All rights reserved.
//

#import "BigImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BigImageView()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@end
@implementation BigImageView

+ (BigImageView *)show:(UIView *)superview url:(NSString *)url
{
    BigImageView *imageView = [[BigImageView alloc] initWithFrame:superview.bounds];
    imageView.imageUrl = url;
    imageView.alpha = 0;
    [superview addSubview:imageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 1;
    }];
    return imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        [_backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_backgroundImageView];
        
        UITapGestureRecognizer *re = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        [self addGestureRecognizer:re];
    }
    return self;
}

- (void)onClick:(id)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
        
    [_backgroundImageView sd_cancelCurrentAnimationImagesLoad];
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
}



@end
